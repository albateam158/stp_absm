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
-- Table structure for table `kams_board_setting`
--

DROP TABLE IF EXISTS `kams_board_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kams_board_setting` (
  `uid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `board_name` varchar(127) NOT NULL,
  `skin` varchar(127) NOT NULL,
  `use_comment` varchar(5) NOT NULL,
  `use_editor` varchar(5) NOT NULL,
  `permission_read` varchar(127) NOT NULL,
  `permission_write` varchar(127) NOT NULL,
  `admin_user` text NOT NULL,
  `use_category` varchar(5) NOT NULL,
  `category1_list` text NOT NULL,
  `category2_list` text NOT NULL,
  `page_rpp` int(10) unsigned NOT NULL,
  `created` char(14) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kams_board_setting`
--

LOCK TABLES `kams_board_setting` WRITE;
/*!40000 ALTER TABLE `kams_board_setting` DISABLE KEYS */;
INSERT INTO `kams_board_setting` VALUES (1,'공지사항','default','','yes','all','editor','kjs,sckim,carzemumu,hyukiya,yjlee18,kdw','','사내 게시판','2^1',10,'20150519150034'),(4,'IT자료실','default','','yes','all','editor','kjs,kimhj,binusis,cmyang,sunryong','','자료실','5^4',10,'20150519155143'),(5,'시황정보','default','','yes','all','editor','jiwon','','','',10,'20150522161326'),(6,'자유게시판','default','yes','yes','all','all','','','사내 게시판','2^4',10,'20150523160538'),(7,'공문회람','default','yes','yes','all','editor','kjs,sunryong,crazemumu','','사내 게시판','2^5',10,'20150523160749'),(8,'업무서식','default','','yes','all','editor','kjs,sunryong,crazemumu','','자료실','5^5',10,'20150617090943'),(9,'반짝반짝 아이디어','default','yes','yes','all','all','','','사내 게시판','2^6',10,'20150728175958'),(10,'금융당국 보도자료','default','','yes','all','editor','sckim,kjs','','사내 게시판','2^3',10,'20150803090158'),(11,'주요 제도 안내','default','','yes','all','editor','kimhj,sckim,kjs,binusis,sunryong,crazemumu,hyukiya','','사내 게시판','2^2',10,'20151214134322'),(12,'컴플라이언스','default','','','all','editor','','','자료실','5^3',10,'20160929150032');
/*!40000 ALTER TABLE `kams_board_setting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:08:56
