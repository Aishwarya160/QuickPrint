-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: quickprint_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usn` varchar(20) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usn` (`usn`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'abc1','aiml','student'),(5,'abc2','aiml','student'),(6,'4GW23CI001','aiml','student'),(7,'4GW23CI002','aiml','student'),(8,'4GW23CI003','aiml','student'),(9,'4GW23CI004','aiml','student'),(10,'4GW23CI005','aiml','student'),(11,'4GW23CI006','aiml','student'),(12,'4GW23CI007','aiml','student'),(13,'4GW23CI008','aiml','student'),(14,'4GW23CI009','aiml','student'),(15,'4GW23CI010','aiml','student'),(16,'4GW23CI011','aiml','student'),(17,'4GW23CI012','aiml','student'),(18,'4GW23CI013','aiml','student'),(19,'4GW23CI014','aiml','student'),(20,'4GW23CI015','aiml','student'),(21,'4GW23CI016','aiml','student'),(22,'4GW23CI017','aiml','student'),(23,'4GW23CI018','aiml','student'),(24,'4GW23CI019','aiml','student'),(25,'4GW23CI020','aiml','student'),(26,'4GW23CI021','aiml','student'),(27,'4GW23CI022','aiml','student'),(28,'4GW23CI023','aiml','student'),(29,'4GW23CI024','aiml','student'),(30,'4GW23CI025','aiml','student'),(31,'4GW23CI026','aiml','student'),(32,'4GW23CI027','aiml','student'),(33,'4GW23CI028','aiml','student'),(34,'4GW23CI029','aiml','student'),(35,'4GW23CI030','aiml','student'),(36,'4GW23CI031','aiml','student'),(37,'4GW23CI032','aiml','student'),(38,'4GW23CI033','aiml','student'),(39,'4GW23CI034','aiml','student'),(40,'4GW23CI035','aiml','student'),(41,'4GW23CI036','aiml','student'),(42,'4GW23CI037','aiml','student'),(43,'4GW23CI038','aiml','student'),(44,'4GW23CI039','aiml','student'),(45,'4GW23CI040','aiml','student'),(46,'4GW23CI041','aiml','student'),(47,'4GW23CI042','aiml','student'),(48,'4GW23CI043','aiml','student'),(49,'4GW23CI044','aiml','student'),(50,'4GW23CI045','aiml','student'),(51,'4GW23CI046','aiml','student'),(52,'4GW23CI047','aiml','student'),(53,'4GW23CI048','aiml','student'),(54,'4GW23CI049','aiml','student'),(55,'4GW23CI050','aiml','student'),(56,'4GW23CI051','aiml','student'),(57,'4GW23CI052','aiml','student'),(58,'4GW23CI053','aiml','student'),(59,'4GW23CI054','aiml','student'),(60,'4GW23CI055','aiml','student'),(61,'4GW23CI056','aiml','student'),(62,'4GW23CI057','aiml','student'),(63,'4GW23CI058','aiml','student'),(64,'4GW23CI059','aiml','student'),(65,'4GW23CI060','aiml','student'),(66,'4GW23CI061','aiml','student'),(67,'4GW24CI400','aiml','student'),(68,'4GW24CI401','aiml','student'),(69,'4GW24CI402','aiml','student'),(70,'4GW24CI403','aiml','student'),(71,'4GW24CI404','aiml','student'),(72,'4GW24CI405','aiml','student'),(73,'4GW24CI001','aiml','student'),(74,'4GW24CI002','aiml','student'),(75,'4GW24CI003','aiml','student'),(76,'4GW24CI004','aiml','student'),(77,'4GW24CI005','aiml','student'),(78,'4GW24CI006','aiml','student'),(79,'4GW24CI007','aiml','student'),(80,'4GW24CI008','aiml','student'),(81,'4GW24CI009','aiml','student'),(82,'4GW24CI010','aiml','student'),(83,'4GW24CI011','aiml','student'),(84,'4GW24CI012','aiml','student'),(85,'4GW24CI013','aiml','student'),(86,'4GW24CI014','aiml','student'),(87,'4GW24CI015','aiml','student'),(88,'4GW24CI016','aiml','student'),(89,'4GW24CI017','aiml','student'),(90,'4GW24CI018','aiml','student'),(91,'4GW24CI019','aiml','student'),(92,'4GW24CI020','aiml','student'),(93,'4GW24CI021','aiml','student'),(94,'4GW24CI022','aiml','student'),(95,'4GW24CI023','aiml','student'),(96,'4GW24CI024','aiml','student'),(97,'4GW24CI025','aiml','student'),(98,'4GW24CI026','aiml','student'),(99,'4GW24CI027','aiml','student'),(100,'4GW24CI028','aiml','student'),(101,'4GW24CI029','aiml','student'),(102,'4GW24CI030','aiml','student'),(103,'4GW24CI031','aiml','student'),(104,'4GW24CI032','aiml','student'),(105,'4GW24CI033','aiml','student'),(106,'4GW24CI034','aiml','student'),(107,'4GW24CI035','aiml','student'),(108,'4GW24CI036','aiml','student'),(109,'4GW24CI037','aiml','student'),(110,'4GW24CI038','aiml','student'),(111,'4GW24CI039','aiml','student'),(112,'4GW24CI040','aiml','student'),(113,'4GW24CI041','aiml','student'),(114,'4GW24CI042','aiml','student'),(115,'4GW24CI043','aiml','student'),(116,'4GW24CI044','aiml','student'),(117,'4GW24CI045','aiml','student'),(118,'4GW24CI046','aiml','student'),(119,'4GW24CI047','aiml','student'),(120,'4GW24CI048','aiml','student'),(121,'4GW24CI049','aiml','student'),(122,'4GW24CI050','aiml','student'),(123,'4GW24CI051','aiml','student'),(124,'4GW24CI052','aiml','student'),(125,'4GW24CI053','aiml','student'),(126,'4GW24CI054','aiml','student'),(127,'4GW24CI055','aiml','student'),(128,'4GW24CI056','aiml','student'),(129,'4GW24CI057','aiml','student'),(130,'4GW24CI058','aiml','student'),(131,'4GW24CI059','aiml','student'),(132,'4GW24CI060','aiml','student'),(133,'4GW24CI061','aiml','student'),(134,'4GW24CI062','aiml','student'),(135,'4GW24CI063','aiml','student'),(136,'4GW24CI064','aiml','student'),(137,'4GW24CI065','aiml','student'),(138,'4GW24CI066','aiml','student'),(139,'4GW24CI067','aiml','student'),(140,'4GW24CI068','aiml','student'),(141,'4GW24CI069','aiml','student'),(142,'4GW25CI400','aiml','student'),(143,'4GW25CI401','aiml','student'),(144,'4GW25CI402','aiml','student'),(145,'4GW25CI403','aiml','student'),(146,'4GW25CI404','aiml','student'),(147,'4GW25CI405','aiml','student'),(148,'4GW25CI406','aiml','student'),(149,'4GW25CI001','aiml','student'),(150,'4GW25CI002','aiml','student'),(151,'4GW25CI003','aiml','student'),(152,'4GW25CI004','aiml','student'),(153,'4GW25CI005','aiml','student'),(154,'4GW25CI006','aiml','student'),(155,'4GW25CI007','aiml','student'),(156,'4GW25CI008','aiml','student'),(157,'4GW25CI009','aiml','student'),(158,'4GW25CI010','aiml','student'),(159,'4GW25CI011','aiml','student'),(160,'4GW25CI012','aiml','student'),(161,'4GW25CI013','aiml','student'),(162,'4GW25CI014','aiml','student'),(163,'4GW25CI015','aiml','student'),(164,'4GW25CI016','aiml','student'),(165,'4GW25CI017','aiml','student'),(166,'4GW25CI018','aiml','student'),(167,'4GW25CI019','aiml','student'),(168,'4GW25CI020','aiml','student'),(169,'4GW25CI021','aiml','student'),(170,'4GW25CI022','aiml','student'),(171,'4GW25CI023','aiml','student'),(172,'4GW25CI024','aiml','student'),(173,'4GW25CI025','aiml','student'),(174,'4GW25CI026','aiml','student'),(175,'4GW25CI027','aiml','student'),(176,'4GW25CI028','aiml','student'),(177,'4GW25CI029','aiml','student'),(178,'4GW25CI030','aiml','student'),(179,'4GW25CI031','aiml','student'),(180,'4GW25CI032','aiml','student'),(181,'4GW25CI033','aiml','student'),(182,'4GW25CI034','aiml','student'),(183,'4GW25CI035','aiml','student'),(184,'4GW25CI036','aiml','student'),(185,'4GW25CI037','aiml','student'),(186,'4GW25CI038','aiml','student'),(187,'4GW25CI039','aiml','student'),(188,'4GW25CI040','aiml','student'),(189,'4GW25CI041','aiml','student'),(190,'4GW25CI042','aiml','student'),(191,'4GW25CI043','aiml','student'),(192,'4GW25CI044','aiml','student'),(193,'4GW25CI045','aiml','student'),(194,'4GW25CI046','aiml','student'),(195,'4GW25CI047','aiml','student'),(196,'4GW25CI048','aiml','student'),(197,'4GW25CI049','aiml','student'),(198,'4GW25CI050','aiml','student'),(199,'4GW25CI051','aiml','student'),(200,'4GW25CI052','aiml','student'),(201,'4GW25CI053','aiml','student'),(202,'4GW25CI054','aiml','student'),(203,'4GW25CI055','aiml','student'),(204,'4GW25CI056','aiml','student'),(205,'4GW25CI057','aiml','student'),(206,'4GW25CI058','aiml','student'),(207,'4GW25CI059','aiml','student'),(208,'4GW25CI060','aiml','student'),(209,'4GW25CI061','aiml','student'),(210,'4GW25CI062','aiml','student'),(211,'4GW25CI063','aiml','student'),(212,'4GW25CI064','aiml','student'),(213,'4GW25CI065','aiml','student'),(214,'4GW25CI066','aiml','student'),(215,'4GW25CI067','aiml','student'),(216,'4GW25CI068','aiml','student'),(217,'4GW25CI069','aiml','student'),(218,'4GW26CI400','aiml','student'),(219,'4GW26CI401','aiml','student'),(220,'4GW26CI402','aiml','student'),(221,'4GW26CI403','aiml','student'),(222,'4GW26CI404','aiml','student'),(223,'4GW26CI405','aiml','student'),(224,'4GW26CI406','aiml','student');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-01  9:30:31
