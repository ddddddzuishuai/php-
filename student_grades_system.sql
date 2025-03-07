-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: student_grades_system
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_course`
--

DROP TABLE IF EXISTS `t_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_course` (
  `cid` char(10) NOT NULL COMMENT '课程号',
  `cname` varchar(20) NOT NULL COMMENT '课程名，唯一值',
  `tid` char(10) DEFAULT NULL COMMENT '工号，外键（引用t_teacher的tid）',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cname` (`cname`),
  KEY `tid` (`tid`),
  CONSTRAINT `t_course_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `t_teacher` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_course`
--

LOCK TABLES `t_course` WRITE;
/*!40000 ALTER TABLE `t_course` DISABLE KEYS */;
INSERT INTO `t_course` VALUES ('c001','数据库','t001'),('c002','大学英语','t003'),('c003','软件测试','t001'),('c004','数据结构','t005'),('c005','微机原理','t004'),('c006','网站开发','t007'),('c007','操作系统','t009'),('c008','计算机基础','t004'),('c009','Java程序设计',NULL),('c010','工程数学',NULL);
/*!40000 ALTER TABLE `t_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_student`
--

DROP TABLE IF EXISTS `t_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_student` (
  `sid` char(10) NOT NULL COMMENT '学号',
  `sname` varchar(10) NOT NULL COMMENT '姓名',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `age` int DEFAULT NULL COMMENT '年龄',
  `major` varchar(20) DEFAULT NULL COMMENT '专业',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_student`
--

LOCK TABLES `t_student` WRITE;
/*!40000 ALTER TABLE `t_student` DISABLE KEYS */;
INSERT INTO `t_student` VALUES ('2012001','王珊','女',25,'软件工程'),('2012002','李平','男',27,'软件工程'),('2012003','张华','男',30,'机械电子'),('2012004','吴军','男',33,'软件工程'),('2012005','李勇','男',32,'机械电子'),('2012006','周云','女',30,'英语'),('2012007','李娜','女',29,'软件工程'),('2013001','杨玲','女',28,'英语'),('2013002','王新','男',30,'软件工程'),('2013003','孙强','男',31,'机械电子'),('2013004','华宇','男',19,NULL),('2013005','李华','女',25,'软件工程');
/*!40000 ALTER TABLE `t_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_student_course`
--

DROP TABLE IF EXISTS `t_student_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_student_course` (
  `sid` char(10) NOT NULL COMMENT '学号，外键（引用t_student的sid）',
  `cid` char(10) NOT NULL COMMENT '课程号，外键（引用t_course的cid）',
  `score` int DEFAULT NULL COMMENT '成绩',
  PRIMARY KEY (`sid`,`cid`),
  KEY `cid` (`cid`),
  CONSTRAINT `t_student_course_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `t_student` (`sid`),
  CONSTRAINT `t_student_course_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `t_course` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_student_course`
--

LOCK TABLES `t_student_course` WRITE;
/*!40000 ALTER TABLE `t_student_course` DISABLE KEYS */;
INSERT INTO `t_student_course` VALUES ('2012001','c001',87),('2012001','c002',75),('2012001','c003',80),('2012001','c008',90),('2012002','c003',70),('2012002','c008',88),('2012003','c001',90),('2012003','c003',85),('2012003','c008',77),('2012004','c003',90),('2012004','c008',97),('2012005','c001',NULL),('2012005','c003',88),('2012005','c008',95),('2012006','c003',90),('2012006','c008',92),('2012007','c003',76),('2012007','c008',82),('2013001','c003',67),('2013001','c008',90),('2013002','c008',79),('2013005','c001',NULL),('2013005','c003',80),('2013005','c008',90);
/*!40000 ALTER TABLE `t_student_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_teacher`
--

DROP TABLE IF EXISTS `t_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_teacher` (
  `tid` char(10) NOT NULL COMMENT '工号',
  `tname` varchar(10) NOT NULL COMMENT '姓名',
  `age` int DEFAULT NULL COMMENT '年龄',
  `title` varchar(20) DEFAULT NULL COMMENT '职称',
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_teacher`
--

LOCK TABLES `t_teacher` WRITE;
/*!40000 ALTER TABLE `t_teacher` DISABLE KEYS */;
INSERT INTO `t_teacher` VALUES ('t001','李明',40,'副教授','123456'),('t002','赵云',45,'教授','123456'),('t003','陈军',30,'讲师','123456'),('t004','韩伟',32,'副教授','123456'),('t005','刘红',35,'副教授','123456'),('t006','张雷',33,'副教授','123456'),('t007','李敏',28,'讲师','123456'),('t008','钟燕',31,'讲师','123456'),('t009','王海',34,'副教授','123456'),('t010','李亚',46,'教授','123456');
/*!40000 ALTER TABLE `t_teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-07  9:28:47
