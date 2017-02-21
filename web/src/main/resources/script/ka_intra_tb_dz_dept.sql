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
-- Table structure for table `tb_dz_dept`
--

DROP TABLE IF EXISTS `tb_dz_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_dz_dept` (
  `DEPT_CD` varchar(4) CHARACTER SET utf8 NOT NULL,
  `CO_CD` varchar(4) CHARACTER SET utf8 DEFAULT NULL,
  `SECT_CD` varchar(4) CHARACTER SET utf8 DEFAULT NULL,
  `SECT_NM` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `DEPT_NM` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `DEPT_NMK` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `DIV_CD` varchar(4) CHARACTER SET utf8 DEFAULT NULL,
  `REG_DT` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `TO_DT` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `insert_dt` varchar(14) DEFAULT NULL,
  `modify_dt` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dz_dept`
--

LOCK TABLES `tb_dz_dept` WRITE;
/*!40000 ALTER TABLE `tb_dz_dept` DISABLE KEYS */;
INSERT INTO `tb_dz_dept` VALUES ('1','1000','1000','경영지원부문','임원실','임원실','1000','20000101',NULL,NULL,NULL),('1000','1000','1000','경영지원부문','경영지원팀','경영지원팀','1000','20000101',NULL,NULL,NULL),('1050','1000','8000','영업관리부문','자금팀','자금팀','1000','20130401',NULL,NULL,NULL),('1060','1000','1000','경영지원부문','결제업무팀','결제업무팀','1000','20130401',NULL,NULL,NULL),('1100','1000','8000','영업관리부문','IT지원팀','IT지원팀','1000','20130401',NULL,NULL,NULL),('1150','1000','8100','리스크관리실','리스크관리팀','리스크관리팀','1000','20130401',NULL,NULL,NULL),('1200','1000','8000','영업관리부문','리서치센터','리서치센터','1000','20000101',NULL,NULL,NULL),('1300','1000','2000','준법감시인','컴플라이언스팀','컴플라이언스팀','1000','20130401',NULL,NULL,NULL),('1400','1000','3000','감사','감사팀','감사','1000','20000101',NULL,NULL,NULL),('2000','1000','4000','IB부문','IB본부','IB본부','1000','20120101',NULL,NULL,NULL),('2050','1000','4000','IB부문','종합금융본부','종합금융본부','1000','20120101',NULL,NULL,NULL),('2100','1000','4000','IB부문','그린에너지금융본부','그린에너지금융본부','1000','20130101',NULL,NULL,NULL),('2150','1000','9000','창조금융부문','AI본부','AI본부','1000','20130101',NULL,NULL,NULL),('2200','1000','4000','IB부문','자본시장본부','자본시장본부','1000','20130401',NULL,NULL,NULL),('2250','1000','4000','IB부문','투자금융본부','투자금융본부','1000','20130401',NULL,NULL,NULL),('2251','1000','4000','IB부문','투자금융1팀','투자금융1팀','1000','20130401',NULL,NULL,NULL),('2252','1000','4000','IB부문','투자금융2팀','투자금융2팀','1000','20130401',NULL,NULL,NULL),('2260','1000','4000','IB부문','SF실물투자본부','SF실물투자본부','1000','20130401',NULL,NULL,NULL),('2270','1000','4000','IB부문','프로젝트금융본부','프로젝트금융본부','1000','20130401',NULL,NULL,NULL),('2300','1000','4000','IB부문','기업금융본부','기업금융본부','1000','20130401',NULL,NULL,NULL),('2301','1000','4000','IB부문','기업금융1팀','기업금융1팀','1000','20130401',NULL,NULL,NULL),('2302','1000','4000','IB부문','기업금융2팀','기업금융2팀','1000','20130401',NULL,NULL,NULL),('2303','1000','4000','IB부문','기업금융3팀','기업금융3팀','1000','20130401',NULL,NULL,NULL),('2304','1000','4000','IB부문','기업금융4팀','기업금융4팀','1000','20130401',NULL,NULL,NULL),('2305','1000','4000','IB부문','기업금융5팀','기업금융5팀','1000','20130401',NULL,NULL,NULL),('2350','1000','4000','IB부문','커머셜부동산팀','커머셜부동산팀','1000','20130401',NULL,NULL,NULL),('2360','1000','4000','IB부문','부동산금융팀','부동산금융팀','1000','20130401',NULL,NULL,NULL),('2370','1000','9000','창조금융부문','중소벤처기업금융센터','중소벤처기업금융센터','1000','20130401',NULL,NULL,NULL),('2380','1000','9000','창조금융부문','RS본부','RS본부','1000','20130401',NULL,NULL,NULL),('2390','1000','9000','창조금융부문','PF본부','PF본부','1000','20130401',NULL,NULL,NULL),('2395','1000','9000','창조금융부문','M&A실','M&A실','1000','20130401',NULL,NULL,NULL),('2400','1000','9000','창조금융부문','PE본부','PE본부','1000','20130401',NULL,NULL,NULL),('3000','1000','7000','채권부문','채권영업부','채권영업부','1000','20120101',NULL,NULL,NULL),('3001','1000','7000','채권부문','채권금융팀(구)','채권금융팀(구)','1000','20130401',NULL,NULL,NULL),('3002','1000','7000','채권부문','채권영업본부','채권영업본부','1000','20130401',NULL,NULL,NULL),('3003','1000','7000','채권부문','채권영업팀','채권영업팀','1000','20130401',NULL,NULL,NULL),('3050','1000','7000','채권부문','채권금융부','채권금융부','1000','20120101',NULL,NULL,NULL),('3060','1000','9000','창조금융부문','채권금융본부','채권금융본부','1000','20130401',NULL,NULL,NULL),('3070','1000','4100','FICC부문','FICC본부','FICC','1000','20130401',NULL,NULL,NULL),('3071','1000','7000','채권부문','구조화금융본부','구조화금융본부','1000','20130401',NULL,NULL,NULL),('3080','1000','7000','채권부문','F.I.Sales본부','F.I.Sales본부','1000','20130401',NULL,NULL,NULL),('3090','1000','7000','채권부문','FPS본부','FPS본부','1000','20130401',NULL,NULL,NULL),('3500','1000','5000','법인영업부문','법인영업본부','법인영업본부','1000','20000101',NULL,NULL,NULL),('3501','1000','5000','법인영업부문','구조화영업본부','구조화영업본부','1000','20130401',NULL,NULL,NULL),('4000','1000','6000','리테일영업본부','영업부','영업부','1000','20000101',NULL,NULL,NULL),('5000','1000','1100','헤지펀드운용부문','헤지펀드운용본부','헤지펀드운영본부','1000','20130401',NULL,NULL,NULL);
/*!40000 ALTER TABLE `tb_dz_dept` ENABLE KEYS */;
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
