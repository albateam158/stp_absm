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
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq` (
  `FAQ_NO` int(38) NOT NULL DEFAULT '0' COMMENT 'FAQ 순번',
  `FAQ_CATE` varchar(100) DEFAULT NULL COMMENT 'FAQ 카테고리',
  `FAQ_SUBJECT` varchar(1000) DEFAULT NULL COMMENT 'FAQ 제목',
  `FAQ_PUBLIC` varchar(1) DEFAULT NULL COMMENT 'FAQ 공개여부',
  `FAQ_BODY` text COMMENT 'FAQ 내용',
  `FAQ_REG_USER` varchar(50) DEFAULT NULL COMMENT 'FAQ 등록 유저',
  `FAQ_REG_DATE` datetime DEFAULT NULL COMMENT 'FAQ 등록 일자',
  `FAQ_MOD_USER` varchar(50) DEFAULT NULL COMMENT 'FAQ 수정 유저',
  `FAQ_MOD_DATE` datetime DEFAULT NULL COMMENT 'FAQ 수정 일자',
  `FAQ_VIEW_CNT` int(10) DEFAULT NULL COMMENT 'FAQ 조회수',
  `FAQ_VIEW_CNT_FRONT` int(10) DEFAULT NULL,
  PRIMARY KEY (`FAQ_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FAQ 게시판';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
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