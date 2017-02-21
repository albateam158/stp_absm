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
-- Table structure for table `kams_code`
--

DROP TABLE IF EXISTS `kams_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kams_code` (
  `code_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(3) NOT NULL,
  `data1` varchar(500) DEFAULT NULL,
  `data2` varchar(500) DEFAULT NULL,
  `order_no` int(11) NOT NULL DEFAULT '0',
  `code_name` varchar(255) NOT NULL,
  `code_group` char(3) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` timestamp NULL DEFAULT NULL,
  `delete_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kams_code`
--

LOCK TABLES `kams_code` WRITE;
/*!40000 ALTER TABLE `kams_code` DISABLE KEYS */;
INSERT INTO `kams_code` VALUES (1,'R01','1','Ⅰ',1,'정관','IRG','2016-10-10 00:57:08',NULL,NULL),(2,'R02','2','Ⅱ',2,'경영','IRG','2016-10-10 00:57:57',NULL,NULL),(3,'R03','3','Ⅲ',3,'리스크관리','IRG','2016-10-10 00:57:57',NULL,NULL),(4,'R04','4','Ⅳ',4,'재무','IRG','2016-10-10 00:57:57',NULL,NULL),(5,'R05','5','Ⅴ',5,'인사구분','IRG','2016-10-10 00:57:57',NULL,NULL),(6,'R06','6','Ⅵ',6,'총무','IRG','2016-10-10 00:57:57',NULL,NULL),(7,'R07','7','Ⅶ',7,'영업부장','IRG','2016-10-10 00:57:57',NULL,NULL),(8,'R08','8','Ⅷ',8,'IT','IRG','2016-10-10 00:57:57',NULL,NULL),(9,'R09','9','Ⅸ',9,'컴플라이언스','IRG','2016-10-10 00:57:57',NULL,NULL),(10,'R10','10','Ⅹ',10,'감사','IRG','2016-10-10 00:57:57',NULL,NULL),(11,'100','1',NULL,1,'기준','RDG','2016-10-10 01:05:36',NULL,NULL),(12,'200','2',NULL,2,'규정','RDG','2016-10-10 01:05:36',NULL,NULL),(13,'300','3',NULL,3,'지침','RDG','2016-10-10 01:05:36',NULL,NULL),(14,'400','4',NULL,4,'세칙','RDG','2016-10-10 01:05:36',NULL,NULL);
/*!40000 ALTER TABLE `kams_code` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:08:53
