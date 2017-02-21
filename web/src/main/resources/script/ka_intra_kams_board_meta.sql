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
-- Table structure for table `kams_board_meta`
--

DROP TABLE IF EXISTS `kams_board_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kams_board_meta` (
  `board_id` bigint(20) unsigned NOT NULL,
  `key` varchar(127) NOT NULL,
  `value` text NOT NULL,
  UNIQUE KEY `meta_index` (`board_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kams_board_meta`
--

LOCK TABLES `kams_board_meta` WRITE;
/*!40000 ALTER TABLE `kams_board_meta` DISABLE KEYS */;
INSERT INTO `kams_board_meta` VALUES (1,'comments_plugin_row','10'),(1,'comment_skin','default'),(1,'list_total','1934'),(1,'max_attached_count','2'),(1,'pass_autop','disable'),(1,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(1,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(1,'permission_write_roles','a:2:{i:0;s:13:\"administrator\";i:1;s:6:\"author\";}'),(1,'total','1935'),(4,'auto_page','714'),(4,'comments_plugin_row','10'),(4,'comment_skin','default'),(4,'list_total','8'),(4,'max_attached_count','2'),(4,'pass_autop','disable'),(4,'permission_comment_write','1'),(4,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(4,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(4,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(4,'total','8'),(5,'comments_plugin_row','10'),(5,'comment_skin','default'),(5,'max_attached_count','2'),(5,'pass_autop','disable'),(5,'permission_comment_write','1'),(5,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(5,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(5,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(6,'comments_plugin_row','10'),(6,'comment_skin','default'),(6,'list_total','125'),(6,'max_attached_count','2'),(6,'pass_autop','disable'),(6,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(6,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(6,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(6,'total','126'),(7,'always_view_list','1'),(7,'comments_plugin_row','10'),(7,'comment_skin','default'),(7,'list_total','37'),(7,'max_attached_count','2'),(7,'pass_autop','disable'),(7,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(7,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(7,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(7,'total','37'),(8,'comments_plugin_row','10'),(8,'comment_skin','default'),(8,'list_total','8'),(8,'max_attached_count','2'),(8,'pass_autop','disable'),(8,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(8,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(8,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(8,'total','8'),(9,'comments_plugin_row','10'),(9,'comment_skin','default'),(9,'list_total','8'),(9,'max_attached_count','2'),(9,'pass_autop','disable'),(9,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(9,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(9,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(9,'total','8'),(10,'always_view_list','1'),(10,'comments_plugin_row','10'),(10,'comment_skin','default'),(10,'list_total','30'),(10,'max_attached_count','2'),(10,'pass_autop','disable'),(10,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(10,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(10,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(10,'total','30'),(11,'always_view_list','1'),(11,'comments_plugin_row','10'),(11,'comment_skin','default'),(11,'list_total','6'),(11,'max_attached_count','2'),(11,'pass_autop','disable'),(11,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(11,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(11,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(11,'total','6'),(12,'comments_plugin_row','10'),(12,'comment_skin','default'),(12,'list_total','8'),(12,'max_attached_count','3'),(12,'pass_autop','disable'),(12,'permission_comment_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(12,'permission_read_roles','a:1:{i:0;s:13:\"administrator\";}'),(12,'permission_write_roles','a:1:{i:0;s:13:\"administrator\";}'),(12,'total','8');
/*!40000 ALTER TABLE `kams_board_meta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-21 14:09:01
