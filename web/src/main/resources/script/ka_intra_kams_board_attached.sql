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
-- Table structure for table `kams_board_attached`
--

DROP TABLE IF EXISTS `kams_board_attached`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kams_board_attached` (
  `uid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content_uid` bigint(20) unsigned DEFAULT NULL,
  `file_key` varchar(127) DEFAULT NULL,
  `date` char(14) DEFAULT NULL,
  `file_path` varchar(127) DEFAULT NULL,
  `file_name` varchar(127) DEFAULT NULL,
  `file_size` double DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `content_uid` (`content_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kams_board_attached`
--

LOCK TABLES `kams_board_attached` WRITE;
/*!40000 ALTER TABLE `kams_board_attached` DISABLE KEYS */;
INSERT INTO `kams_board_attached` VALUES (1,NULL,NULL,'20170217162500','http://kams.kasset.co.kr/files/attached/20170217/c10bacced47cf895bad94501e8771784.pptx','SSL_통신방법_20170213.pptx',90050),(2,NULL,NULL,'20170217162659','http://kams.kasset.co.kr/files/images/20170217/0889e746bc8c8140f7af5d22c4db94d7.jpg','기준일 공고_1.jpg',47086),(3,NULL,NULL,'20170220094930','http://kams.kasset.co.kr/files/images/20170220/4510517f48e9020777353adc9c8c296a.jpeg','image1.jpeg',237687),(4,NULL,NULL,'20170221103318','http://kams.kasset.co.kr/files/images/20170221/bb4c57219e5af3095e61951908541ba0.jpeg','image1.jpeg',237687),(5,NULL,NULL,'20170221103322','http://kams.kasset.co.kr/files/images/20170221/19d8e10f85d39c7983271690dd3fd35e.jpeg','image.jpeg',69594),(6,NULL,NULL,'20170221103723','http://kams.kasset.co.kr/files/images/20170221/a2096839f522b2a2f7013e0daa49aa83.jpeg','image1.jpeg',237687),(7,NULL,NULL,'20170221103725','http://kams.kasset.co.kr/files/images/20170221/83f1a9c0dc517732baa7814bcce84cd7.jpeg','image.jpeg',69594),(8,NULL,NULL,'20170221105204','http://kams.kasset.co.kr/files/images/20170221/cc6160c96b3793bd122389061a65de7a.JPG','IMG_7347.JPG',4570791),(9,15,NULL,'20170221110000','http://kams.kasset.co.kr/files/images/20170221/f3b8f78b227d8cd0560b9fe3e23079e3.jpeg','image1.jpeg',237687),(10,16,NULL,'20170221110256','http://kams.kasset.co.kr/files/images/20170221/0d248deeb6e15b9fbc9e8e61f5384e78.jpeg','image.jpeg',69594);
/*!40000 ALTER TABLE `kams_board_attached` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:08:54
