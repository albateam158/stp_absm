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
-- Table structure for table `kams_user`
--

DROP TABLE IF EXISTS `kams_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kams_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `emp_no` varchar(10) NOT NULL,
  `password` varchar(255) DEFAULT '',
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dept_cd` varchar(4) NOT NULL,
  `admin_type` varchar(20) NOT NULL,
  `phone` varchar(500) DEFAULT NULL,
  `profile_image_url` varchar(500) DEFAULT NULL,
  `user_state` enum('normal','out','ready','outed') DEFAULT 'normal',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` timestamp NULL DEFAULT NULL,
  `delete_date` timestamp NULL DEFAULT NULL,
  `out_date` timestamp NULL DEFAULT NULL,
  `outed_date` timestamp NULL DEFAULT NULL,
  `encrypted` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `emp_no_UNIQUE` (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=864 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kams_user`
--

LOCK TABLES `kams_user` WRITE;
/*!40000 ALTER TABLE `kams_user` DISABLE KEYS */;
INSERT INTO `kams_user` VALUES (856,'200287','$2a$10$z6Bu79zOrTtnvZodADerheO6/iJvTbVPhfButDbZMvm1K.rUBm/sS','박상현','shpark@kasset.co.kr','1100','SYSAD','6298','','normal','2016-07-20 23:43:02','2016-09-22 00:05:55',NULL,NULL,NULL,NULL),(857,'200999','$2a$10$GtuRoBvly29QfnXs8fQWPOtvoZZm4mxjOxTGpgrvIWdh43wmPvr32','사원','','1100','EMP','','','normal','2016-07-21 00:25:41',NULL,NULL,NULL,NULL,NULL),(858,'100999','$2a$10$LJ0x6qSs/5r/m.GvZu2TnOR3xy8/1DpBljJCMl1FvJ6RVrrLYDWK6','임원1','','1','RECORD','','','normal','2016-09-05 07:36:40','2016-09-21 00:53:51',NULL,NULL,NULL,NULL),(859,'100991','$2a$10$z5HATKrQlQRaQHvR6gHeQOrUsYFeDJyUoeFszHDZWHNhXXkCKwK2e','경영1','','1000','RECORD','','','normal','2016-09-08 00:39:55',NULL,NULL,NULL,NULL,NULL),(860,'100992','$2a$10$hY9ANnL77/0NCK1h797YxObLn0Z6UcjbzugrwnYbTzZFDEzXwMTIi','자금1','','1050','RECORD','','','normal','2016-09-08 00:58:54',NULL,NULL,NULL,NULL,NULL),(861,'200990','$2a$10$wJl4Y9gCjY99ML9iDaOjgOHK0Fmz/fELzmAOezfcAdDNdqSCmbqPK','박상현','shpark@kasset.co.kr','1','RECORD','025506298','','normal','2016-09-21 23:56:07','2016-09-22 00:12:00',NULL,NULL,NULL,NULL),(862,'200991','$2a$10$OKTMGxxH1Skm3t/kq58cnus263MHSCV39pc/7RUqHlFl3/TJ2FP3a','박상현','ikty@naver.com','1','HR','025506298','','normal','2016-09-21 23:57:36','2016-09-22 00:11:46',NULL,NULL,NULL,NULL),(863,'200992','$2a$10$PBVVqRrmtaTRX/9hENiuG.iE.IgA58v7HPxFAqEDzYIs95wbEyOay','박상현','shpark@kasset.co.kr','1','EMP','025506298','','normal','2016-09-21 23:59:18',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `kams_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:08:59
