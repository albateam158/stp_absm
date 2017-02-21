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
-- Table structure for table `kams_inter_rule_code`
--

DROP TABLE IF EXISTS `kams_inter_rule_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kams_inter_rule_code` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` varchar(2) NOT NULL,
  `doc_group` varchar(1) NOT NULL,
  `doc_seq` varchar(2) NOT NULL,
  `doc_id` varchar(10) NOT NULL,
  `rule_nm` varchar(100) DEFAULT NULL,
  `establish_dt` varchar(8) DEFAULT NULL,
  `reform_dt` varchar(8) DEFAULT NULL,
  `charge_dept` varchar(4) DEFAULT NULL,
  `charge_dept_detail` varchar(50) DEFAULT NULL,
  `recent_file` int(10) DEFAULT NULL,
  `before_file` int(10) DEFAULT NULL,
  `state` enum('standby','use','disuse') DEFAULT 'use',
  `reg_emp` varchar(10) DEFAULT NULL,
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_emp` varchar(10) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `delete_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kams_inter_rule_code`
--

LOCK TABLES `kams_inter_rule_code` WRITE;
/*!40000 ALTER TABLE `kams_inter_rule_code` DISABLE KEYS */;
INSERT INTO `kams_inter_rule_code` VALUES (14,'1','0','00','1000','test','20161003','20161017','2150','',80,NULL,NULL,'856','2016-10-14 05:39:02',NULL,'2016-10-14 05:39:02','2016-10-14 05:39:02'),(17,'1','1','00','555','555','20160101','','2150','',NULL,NULL,NULL,'856','2016-11-01 04:43:43',NULL,'2016-11-01 04:43:43','2016-11-01 04:43:43'),(18,'1','0','01','111','111','20160303','','2150','',NULL,NULL,NULL,'856','2016-11-01 05:46:37',NULL,'2016-11-01 05:46:37','2016-11-01 05:46:37'),(19,'1','0','02','3232','32323232','20160101','','2150','',NULL,NULL,NULL,'856','2016-11-01 05:55:59',NULL,'2016-11-01 05:55:59','2016-11-01 05:55:59'),(20,'1','0','03','22','222','20160102','','2150','',NULL,NULL,NULL,'856','2016-11-01 05:56:15',NULL,'2016-11-01 05:56:15','2016-11-01 05:56:15'),(21,'1','0','04','1221','122121','20160302','','2150','',NULL,NULL,NULL,'856','2016-11-01 05:59:16',NULL,'2016-11-01 05:59:16','2016-11-01 05:59:16'),(22,'1','0','05','22222','111','20160401','','2150','',NULL,NULL,NULL,'856','2016-11-01 05:59:34',NULL,'2016-11-01 05:59:34','2016-11-01 05:59:34'),(23,'1','0','06','11111','111','20160401','','2150','',NULL,NULL,NULL,'856','2016-11-01 06:36:42',NULL,'2016-11-01 06:36:42','2016-11-01 06:36:42'),(24,'1','0','07','5454','33','20160713','','2150','',NULL,NULL,NULL,'856','2016-11-01 06:36:50',NULL,'2016-11-01 06:36:50','2016-11-01 06:36:50');
/*!40000 ALTER TABLE `kams_inter_rule_code` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:09:02
