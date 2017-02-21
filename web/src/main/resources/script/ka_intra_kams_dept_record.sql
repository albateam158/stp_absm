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
-- Table structure for table `kams_dept_record`
--

DROP TABLE IF EXISTS `kams_dept_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kams_dept_record` (
  `DEPT_CD` varchar(4) NOT NULL,
  `CO_CD` varchar(4) DEFAULT NULL,
  `SECT_CD` varchar(4) DEFAULT NULL,
  `SECT_NM` varchar(20) DEFAULT NULL,
  `DEPT_NM` varchar(20) DEFAULT NULL,
  `DEPT_NMK` varchar(20) DEFAULT NULL,
  `DIV_CD` varchar(4) DEFAULT NULL,
  `REG_DT` varchar(8) DEFAULT NULL,
  `TO_DT` varchar(8) DEFAULT NULL,
  `INSERT_DT` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFY_DT` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`DEPT_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kams_dept_record`
--

LOCK TABLES `kams_dept_record` WRITE;
/*!40000 ALTER TABLE `kams_dept_record` DISABLE KEYS */;
INSERT INTO `kams_dept_record` VALUES ('29A1','1000','4000','IB부문','기업금융1팀-강용관','기업금융1팀-강용관','1000','20160930',NULL,'2016-09-30 01:47:01','2016-09-30 01:47:01'),('29A2','1000','4000','IB부문','기업금융1팀-강종욱','기업금융1팀-강종욱','1000','20160930',NULL,'2016-09-30 01:47:36','2016-09-30 01:47:36'),('29A3','1000','4000','IB부문','기업금융2팀-추영재','기업금융2팀-추영재','1000','20160930',NULL,'2016-09-30 01:47:55','2016-09-30 01:47:55'),('29A4','1000','4000','IB부문','기업금융3팀-이성규','기업금융3팀-이성규','1000','20160930',NULL,'2016-09-30 01:48:16','2016-09-30 01:48:16'),('29A5','1000','4000','IB부문','기업금융5팀-정충훈','기업금융5팀-정충훈','1000','20160930',NULL,'2016-09-30 01:48:40','2016-09-30 01:48:40'),('29A6','1000','4000','IB부문','기업금융본부-박성근','기업금융본부-박성근','1000','20160930',NULL,'2016-09-30 01:49:15','2016-09-30 01:49:15'),('29A7','1000','4000','IB부문','기업금융본부-강병석','기업금융본부-강병석','1000','20160930',NULL,'2016-09-30 01:49:34','2016-09-30 01:49:34'),('29A8','1000','4000','IB부문','기업금융본부-정정철','기업금융본부-정정철','1000','20160930',NULL,'2016-09-30 01:50:06','2016-09-30 01:50:06'),('29A9','1000','4000','IB부문','기업금융본부-이석희','기업금융본부-이석희','1000','20160930',NULL,'2016-09-30 01:50:25','2016-09-30 01:50:25'),('29B1','1000','4000','IB부문','기업금융본부-고영태','기업금융본부-고영태','1000','20160930',NULL,'2016-09-30 01:50:51','2016-09-30 01:50:51'),('35A1','1000','5000','법인영업부문','법인영업본부-김병대','법인영업본부-김병대','1000','20160930',NULL,'2016-09-30 01:53:06','2016-09-30 01:53:06'),('35A2','1000','5000','법인영업부문','법인영업본부-오형식','법인영업본부-오형식','1000','20160930',NULL,'2016-09-30 01:53:30','2016-09-30 01:53:30'),('35A3','1000','5000','법인영업부문','법인영업본부-박노철','법인영업본부-박노철','1000','20160930',NULL,'2016-09-30 01:53:48','2016-09-30 01:53:48'),('35A4','1000','5000','법인영업부문','법인영업본부-임성준','법인영업본부-임성준','1000','20160930',NULL,'2016-09-30 01:54:07','2016-09-30 01:54:07'),('35A5','1000','5000','법인영업부문','법인영업본부-김원경','법인영업본부-김원경','1000','20160930',NULL,'2016-09-30 01:54:29','2016-09-30 01:54:29'),('35A6','1000','5000','법인영업부문','법인영업본부-법인2팀','법인영업본부-법인2팀','1000','20160930',NULL,'2016-09-30 01:54:51','2016-09-30 01:54:51'),('A001','1000','A100','기타','자산운용','자산운용','1000','20160930',NULL,'2016-09-30 02:02:34','2016-09-30 02:02:34'),('A002','1000','A100','기타','집합증권','집합증권','1000','20160930',NULL,'2016-09-30 02:02:57','2016-09-30 02:02:57'),('A101','1000','A100','기타','기타-법인공통_KTB','기타-법인공통_KTB','1000','20160930',NULL,'2016-09-30 02:01:31','2016-09-30 02:01:31'),('A102','1000','A100','기타','기타-법인4_추영재','기타-법인4_추영재','1000','20160930',NULL,'2016-09-30 02:01:55','2016-09-30 02:01:55');
/*!40000 ALTER TABLE `kams_dept_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:09:00
