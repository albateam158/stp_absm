CREATE DATABASE  IF NOT EXISTS `ka_intra` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ka_intra`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: ka_intra
-- ------------------------------------------------------
-- Server version	5.7.12-log

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
-- Table structure for table `secured_resources_role`
--

DROP TABLE IF EXISTS `secured_resources_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secured_resources_role` (
  `resource_id` varchar(15) NOT NULL,
  `authority` varchar(50) NOT NULL,
  PRIMARY KEY (`resource_id`,`authority`),
  KEY `authority` (`authority`),
  CONSTRAINT `SECURED_RESOURCES_ROLE_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `secured_resources` (`resource_id`),
  CONSTRAINT `SECURED_RESOURCES_ROLE_ibfk_2` FOREIGN KEY (`authority`) REFERENCES `roles` (`authority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secured_resources_role`
--

LOCK TABLES `secured_resources_role` WRITE;
/*!40000 ALTER TABLE `secured_resources_role` DISABLE KEYS */;
INSERT INTO `secured_resources_role` VALUES ('WEB-0000001','ROLE_ADMIN'),('WEB-0000002','ROLE_ADMIN'),('WEB-0000003','ROLE_ADMIN'),('WEB-0000005','ROLE_DEPT'),('WEB-0000004','ROLE_EMP'),('WEB-0000006','ROLE_HR'),('WEB-0000000','ROLE_INFO'),('WEB-0000007','ROLE_RECORD');
/*!40000 ALTER TABLE `secured_resources_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:08:55
