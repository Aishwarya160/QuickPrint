import os
import re
from flask import Flask, render_template, request, redirect, url_for, session, flash 
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from flask import send_from_directory
from PyPDF2 import PdfReader
from flask import abort


app = Flask(__name__)
app.secret_key = "secret123"
import os

app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get("DATABASE_URL")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

app.config["SQLALCHEMY_ENGINE_OPTIONS"] = {
    "connect_args": {"ssl": {"ssl_mode": "REQUIRED"}}
}



app.config["UPLOAD_FOLDER"] = "uploads"

# ------------ SIMPLE UPI CONFIG ------------
UPI_ID = "quickprint@upi"
UPI_NAME = "QuickPrint Center"

db = SQLAlchemy(app)

# ------------ MODELS ------------
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    usn = db.Column(db.String(20), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)
    role = db.Column(db.String(10), default="student")


class PrintRequest(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    filename = db.Column(db.String(200), nullable=False)
    status = db.Column(db.String(20), default="Pending")
    visible_to_staff = db.Column(db.Boolean, default=True)

    paper_size = db.Column(db.String(20))
    orientation = db.Column(db.String(20))
    color_mode = db.Column(db.String(20))
    print_quality = db.Column(db.String(20))
    finishing = db.Column(db.String(50))
    priority = db.Column(db.String(10), default="Medium")

    pages = db.Column(db.String(100), nullable=False, default='1')
    copies = db.Column(db.Integer, nullable=False, default=1)
    sidedness = db.Column(db.String(20))
    cost = db.Column(db.Integer, default=0)
    file_deleted = db.Column(db.Boolean, default=False)
    printed = db.Column(db.Boolean, default=False)


    payment_status = db.Column(db.String(20), default="Unpaid")
    payment_proof = db.Column(db.String(255))

    # NEW: timestamp when the student uploaded the request
    created_at = db.Column(db.DateTime, server_default=db.func.now())

    user = db.relationship('User', backref='print_requests')


# ------------ HELPERS ------------
def pages_from_pdf(path):
    try:
        reader = PdfReader(path)
        return len(reader.pages)
    except:
        return None


def parse_pages_input(pages_input, file_path=None):
    if not pages_input:
        return 1

    s = str(pages_input).strip().lower()

    # full/all
    if re.search(r'\b(full|all|entire|complete)\b', s):
        if file_path and file_path.endswith(".pdf"):
            pdf_pages = pages_from_pdf(file_path)
            return pdf_pages if pdf_pages else 1
        return 1

    cleaned = re.sub(r'[^\d,\-]', '', s)
    if cleaned == "":
        return 1

    if "," not in cleaned and "-" not in cleaned:
        try:
            return max(1, int(cleaned))
        except:
            return 1

    pages_set = set()
    for part in cleaned.split(","):
        if '-' in part:
            try:
                a, b = map(int, part.split('-'))
                if b < a:
                    a, b = b, a
                for pg in range(a, b + 1):
                    pages_set.add(pg)
            except:
                continue
        else:
            try:
                pages_set.add(int(part))
            except:
                continue

    return len(pages_set) if pages_set else 1


# ------------ ROUTES ------------
@app.route("/")
def home():
    return render_template("home.html")


@app.route("/uploads/<filename>")
def uploaded_file(filename):
    pr = PrintRequest.query.filter_by(filename=filename).first()

    if pr and pr.printed:
        abort(403)

    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)



@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        usn = request.form["usn"]
        password = request.form["password"]
        user = User.query.filter_by(usn=usn, role='student').first()
        if user and user.password == password:
            session["user_id"] = user.id
            session["role"] = user.role
            flash("Login successful")
            return redirect(url_for("dashboard"))
        flash("Invalid credentials")
    return render_template("login.html")


@app.route("/staff_login", methods=["GET", "POST"])
def staff_login():
    if request.method == "POST":
        user_id = request.form["user_id"]
        password = request.form["password"]

        if user_id == "staff1" and password == "aiml":
            session["user_id"] = 1
            session["role"] = "staff"
            flash("Login successful")
            return redirect(url_for("staff_panel"))

        flash("Invalid credentials")
    return render_template("staff_login.html")


@app.route("/logout")
def logout():
    session.clear()
    flash("Logged out")
    return redirect(url_for("home"))


@app.route("/dashboard", methods=["GET", "POST"])
def dashboard():
    if "user_id" not in session or session["role"] != "student":
        return redirect(url_for("login"))

    if request.method == "POST":
        file = request.files.get("file")

        if file and file.filename != '':
            filename = secure_filename(file.filename)
            os.makedirs(app.config["UPLOAD_FOLDER"], exist_ok=True)
            file_path = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            file.save(file_path)

            # form fields
            paper_size = request.form.get("paper_size")
            orientation = request.form.get("orientation")
            color_mode = request.form.get("color_mode")
            print_quality = request.form.get("print_quality")
            finishing = request.form.get("finishing")
            sidedness = request.form.get("sidedness")
            pages_input = request.form.get("pages", "1")

            try:
                copies = max(1, int(request.form.get("copies", 1)))
            except:
                copies = 1

            page_count = parse_pages_input(pages_input, file_path=file_path)

            # ------ COSTING LOGIC ------
            color = (color_mode or "").lower()
            rate = 5 if "color" in color else 2

            side = (sidedness or "").lower()
            if "back" in side:
                sheets_per_copy = (page_count + 1) // 2
            else:
                sheets_per_copy = page_count

            printing_cost = sheets_per_copy * copies * rate

            fin = (finishing or "").lower()
            if "soft" in fin:
                finishing_cost = 15 * copies
            elif "spiral" in fin:
                finishing_cost = 30 * copies
            else:
                finishing_cost = 0

            total_cost = printing_cost + finishing_cost

            # Save request
            req = PrintRequest(
                user_id=session["user_id"],
                filename=filename,
                paper_size=paper_size,
                orientation=orientation,
                color_mode=color_mode,
                print_quality=print_quality,
                finishing=finishing,
                pages=pages_input,
                copies=copies,
                sidedness=sidedness,
                cost=total_cost
            )

            db.session.add(req)
            db.session.commit()

            flash(f"Print Request Submitted! Total Cost: ₹{total_cost}", "success")
            return redirect(url_for("dashboard"))

    # 🔔 NEW: completion notification logic
    requests = PrintRequest.query.filter_by(user_id=session["user_id"]).all()

    for r in requests:
        if r.status and r.status.lower() == "completed":
            key = f"notified_{r.id}"

            if not session.get(key):
                session[key] = True          # ✅ mark notified FIRST
                flash(
                    f"🎉 Your print request #{r.id} has been completed!",
                    "success"
                )
                return redirect(url_for("dashboard")) 

    return render_template("dashboard.html", requests=requests)



from datetime import datetime, timedelta

@app.route("/staff")
def staff_panel():
    if "user_id" not in session or session["role"] != "staff":
        return redirect(url_for("staff_login"))

    requests = (
        PrintRequest.query
        .filter_by(visible_to_staff=True)
        .order_by(
            PrintRequest.payment_proof.is_(None),
            PrintRequest.created_at.desc()
        )
        .all()
    )

    today = datetime.now().date()
    yesterday = today - timedelta(days=1)

    for r in requests:
        if r.created_at:
            d = r.created_at.date()
            if d == today:
                r.date_label = "Today"
            elif d == yesterday:
                r.date_label = "Yesterday"
            else:
                r.date_label = r.created_at.strftime("%d-%m-%Y")
        else:
            r.date_label = "-"

    return render_template("staff.html", requests=requests)



@app.route("/trigger_print/<int:req_id>")
def trigger_print(req_id):
    if "user_id" not in session or session["role"] != "staff":
        return redirect(url_for("staff_login"))

    req = PrintRequest.query.get_or_404(req_id)
    if req.status == "Pending":
        req.status = "Completed"
        db.session.commit()

    file_url = url_for("uploaded_file", filename=req.filename, _external=True)
    return render_template("print_page.html", file_url=file_url, filename=req.filename)

@app.route("/mark_printed/<int:request_id>", methods=["POST"])
def mark_printed(request_id):
    pr = PrintRequest.query.get_or_404(request_id)

    pr.printed = True
    pr.status = "completed"

    # OPTION 1: keep record, hide file access
    # db.session.commit()

    # OPTION 2: delete record AFTER print dialog
    db.session.delete(pr)
    db.session.commit()

    return "", 204



@app.route("/delete_request_staff/<int:req_id>", methods=["POST"])
def delete_request_staff(req_id):
    if "user_id" not in session or session["role"] != "staff":
        return redirect(url_for("staff_login"))

    req = PrintRequest.query.get_or_404(req_id)
    req.visible_to_staff = False
    db.session.commit()

    return redirect(url_for("staff_panel"))


@app.route("/view/<int:req_id>")
def view_request(req_id):
    if "user_id" not in session or session["role"] != "student":
        return redirect(url_for("login"))

    req = PrintRequest.query.get_or_404(req_id)
    if req.user_id != session["user_id"]:
        return redirect(url_for("dashboard"))

    return render_template("view_request.html", req=req)


@app.route("/delete/<int:req_id>", methods=["POST"])
def delete_request(req_id):
    if "user_id" not in session or session["role"] != "student":
        return redirect(url_for("login"))

    req = PrintRequest.query.get_or_404(req_id)
    if req.user_id != session["user_id"]:
        return redirect(url_for("dashboard"))

    db.session.delete(req)
    db.session.commit()

    return redirect(url_for("dashboard"))


@app.route("/upload_payment_proof/<int:req_id>", methods=["GET", "POST"])
def upload_payment_proof(req_id):
    if "user_id" not in session or session["role"] != "student":
        return redirect(url_for("login"))

    req = PrintRequest.query.get_or_404(req_id)
    if req.user_id != session["user_id"]:
        return redirect(url_for("dashboard"))

    if request.method == "POST":
        file = request.files.get("proof")
        if file and file.filename:
            filename = secure_filename(f"proof_{req.id}_" + file.filename)
            path = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            file.save(path)

            req.payment_proof = filename
            req.payment_status = "Paid"
            db.session.commit()

            flash("Payment proof uploaded successfully.")
            return redirect(url_for("dashboard"))

    upi_link = f"upi://pay?pa={UPI_ID}&pn={UPI_NAME}&am={req.cost}&cu=INR&tn=QuickPrint%20Order%20{req.id}"

    return render_template("upload_payment_proof.html", req=req, upi_link=upi_link)
    




if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

