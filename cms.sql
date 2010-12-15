-- MySQL dump 10.13  Distrib 5.1.53, for apple-darwin10.3.0 (i386)
--
-- Host: localhost    Database: simple_cms_development
-- ------------------------------------------------------
-- Server version	5.1.53

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL DEFAULT '',
  `hashed_password` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(25) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_users_on_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'Michael','Sopira','sopira@gmail.com','5542d54e4d9264e6799b1b31740e680303f486e8','2010-12-04 22:20:24','2010-12-13 21:18:29','misosopira','703ecb37ff552e0502d44ed2de8951655919ff85'),(2,'Lara','Sopira','lara@mac.com','41df4af886cc8feea468813e7bc1b8f8aef1b44c','2010-12-13 21:34:30','2010-12-13 21:34:30','larinecka','da33931658bd95cc8504fe07124bb4740b17fe10'),(3,'Livo','Sopira','livo@mac.com','3fc17eb180ac1249e378be9b0d802bdc834a4e6c','2010-12-13 21:35:27','2010-12-13 21:35:27','livosopira','39827837629c58199d90a15da35dc91205d1702a'),(4,'Martinka','Sopira','martinka@mac.com','6d07a7cf816058a08587cc496cbf63bab6f826e9','2010-12-13 21:35:49','2010-12-13 21:35:49','martinkasopira','f70971cb0cab0be7e27631f615762bf712e9bc7a');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users_pages`
--

DROP TABLE IF EXISTS `admin_users_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users_pages` (
  `admin_user_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  KEY `index_admin_users_pages_on_admin_user_id_and_page_id` (`admin_user_id`,`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users_pages`
--

LOCK TABLES `admin_users_pages` WRITE;
/*!40000 ALTER TABLE `admin_users_pages` DISABLE KEYS */;
INSERT INTO `admin_users_pages` VALUES (1,1);
/*!40000 ALTER TABLE `admin_users_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `permalink` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pages_on_permalink` (`permalink`),
  KEY `index_pages_on_subject_id` (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,5,'First page','first',1,1,'2010-12-04 21:54:50','2010-12-06 19:56:40'),(2,NULL,'Halooo',NULL,2,1,'2010-12-05 19:09:47','2010-12-05 19:10:03'),(4,NULL,'Pedro',NULL,3,1,'2010-12-05 19:10:33','2010-12-05 19:10:33'),(5,NULL,'Amor',NULL,4,1,'2010-12-05 19:10:45','2010-12-05 19:10:45'),(6,2,'default_vlak','def',5,0,'2010-12-06 10:17:51','2010-12-06 19:44:52'),(7,2,'Airplane','air-plane',6,0,'2010-12-06 19:13:12','2010-12-06 19:45:00'),(8,3,'Siedma','sedem',7,0,'2010-12-06 19:44:36','2010-12-06 19:44:36'),(9,1,'Story','story',8,0,'2010-12-06 21:38:14','2010-12-06 21:38:28');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20101204190126'),('20101204194417'),('20101204200531'),('20101204200559'),('20101204200628'),('20101204221149'),('20101204222513'),('20101206201119');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_edits`
--

DROP TABLE IF EXISTS `section_edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_edits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_section_edits_on_admin_user_id_and_section_id` (`admin_user_id`,`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_edits`
--

LOCK TABLES `section_edits` WRITE;
/*!40000 ALTER TABLE `section_edits` DISABLE KEYS */;
INSERT INTO `section_edits` VALUES (1,NULL,1,'test edit','2010-12-04 22:36:54','2010-12-04 22:36:54');
/*!40000 ALTER TABLE `section_edits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `content_type` varchar(255) DEFAULT NULL,
  `content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `published_from` datetime DEFAULT '0000-00-00 00:00:00',
  `published_to` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `index_sections_on_page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,5,'section One',1,0,'text','Hladanie strateneho ?oklíka.','2010-12-04 22:35:01','2010-12-06 20:34:07','2010-12-21 00:00:00','2013-03-03 20:24:00'),(2,NULL,'Important',2,0,NULL,NULL,'2010-12-05 19:12:21','2010-12-05 19:12:21','0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,NULL,'News',3,1,NULL,NULL,'2010-12-05 19:12:42','2010-12-05 19:12:42','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,1,'Home',4,1,NULL,'','2010-12-05 19:12:53','2010-12-06 20:36:52','2009-01-01 00:00:00','2010-01-01 00:00:00'),(8,1,'default',1,0,NULL,'','2010-12-05 21:47:34','2010-12-06 20:38:21','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,'UPDATED flash',1,1,'2010-12-04 21:08:35','2010-12-05 19:07:05'),(2,'Revised',2,1,'2010-12-04 21:12:00','2010-12-04 21:17:23'),(3,'Third Subject',3,0,'2010-12-04 21:24:29','2010-12-04 21:24:29'),(4,'Testovacka',4,0,'2010-12-05 13:14:47','2010-12-06 19:37:38'),(5,'Martinka',6,1,'2010-12-05 13:15:49','2010-12-06 19:37:48'),(6,'Po obede UPDATED',5,1,'2010-12-05 13:39:08','2010-12-06 19:37:55'),(10,'default',7,0,'2010-12-06 19:37:18','2010-12-06 19:37:18'),(11,'Dodo',8,0,'2010-12-06 21:32:28','2010-12-06 21:32:28'),(12,'Nero',9,1,'2010-12-06 21:37:55','2010-12-06 21:37:55'),(13,'oto',10,0,'2010-12-11 15:43:40','2010-12-11 15:43:53');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-12-15  9:29:07
