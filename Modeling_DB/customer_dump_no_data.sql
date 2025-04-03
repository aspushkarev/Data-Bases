-- MySQL dump 10.13  Distrib 9.2.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: customers
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `additional_info_customers`
--

DROP TABLE IF EXISTS `additional_info_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_info_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL COMMENT 'ID клиента',
  `countries_id` int unsigned NOT NULL COMMENT 'Страна',
  `postal_codes_id` int unsigned NOT NULL COMMENT 'Почтовый индекс',
  `regions_id` int unsigned NOT NULL COMMENT 'Регион',
  `cities_id` int unsigned NOT NULL COMMENT 'Город',
  `streets_id` int unsigned NOT NULL COMMENT 'Улица',
  `building_number` int unsigned NOT NULL COMMENT 'Номер дома',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `countries_id` (`countries_id`),
  KEY `postal_codes_id` (`postal_codes_id`),
  KEY `regions_id` (`regions_id`),
  KEY `cities_id` (`cities_id`),
  KEY `streets_id` (`streets_id`),
  CONSTRAINT `additional_info_customers_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `additional_info_customers_ibfk_2` FOREIGN KEY (`countries_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `additional_info_customers_ibfk_3` FOREIGN KEY (`postal_codes_id`) REFERENCES `postal_codes` (`id`),
  CONSTRAINT `additional_info_customers_ibfk_4` FOREIGN KEY (`regions_id`) REFERENCES `regions` (`id`),
  CONSTRAINT `additional_info_customers_ibfk_5` FOREIGN KEY (`cities_id`) REFERENCES `cities` (`id`),
  CONSTRAINT `additional_info_customers_ibfk_6` FOREIGN KEY (`streets_id`) REFERENCES `streets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица дополнительной информации о покупателе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `city` varchar(35) NOT NULL COMMENT 'Город',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица городов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `country` char(2) NOT NULL COMMENT 'Страна',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица стран';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gender_prefix` varchar(20) NOT NULL COMMENT 'Префикс пола',
  `firstname` varchar(50) NOT NULL COMMENT 'Имя',
  `lastname` varchar(50) NOT NULL COMMENT 'Фамилия',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `lastname` (`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица покупателей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers_all`
--

DROP TABLE IF EXISTS `customers_all`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers_all` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gender_prefix` varchar(20) DEFAULT NULL COMMENT 'Префикс пола',
  `firstname` varchar(50) NOT NULL COMMENT 'Имя',
  `lastname` varchar(50) NOT NULL COMMENT 'Фамилия',
  `correspondence_language` char(2) NOT NULL COMMENT 'Язык общения',
  `birth_date` varchar(10) DEFAULT NULL COMMENT 'Дата рождения',
  `gender` varchar(10) NOT NULL COMMENT 'Пол',
  `marital_status` varchar(10) DEFAULT NULL COMMENT 'Семейное положение',
  `country` varchar(20) NOT NULL COMMENT 'Страна',
  `postal_code` varchar(8) DEFAULT NULL COMMENT 'Почтовый индекс',
  `region` varchar(20) NOT NULL COMMENT 'Регион',
  `city` varchar(35) DEFAULT NULL COMMENT 'Город',
  `street` varchar(100) DEFAULT NULL COMMENT 'Улица',
  `building_number` varchar(10) DEFAULT NULL COMMENT 'Номер дома',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица покупателей всё в одном';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers_profile`
--

DROP TABLE IF EXISTS `customers_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers_profile` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL COMMENT 'ID клиента',
  `login` varchar(30) NOT NULL COMMENT 'Логин',
  `password_hash` char(55) NOT NULL COMMENT 'Хэш пароля',
  `phone` char(11) NOT NULL COMMENT 'Номер телефона',
  `email` varchar(120) NOT NULL COMMENT 'e-mail',
  `correspondence_language_id` int unsigned NOT NULL COMMENT 'Язык общения',
  `birth_date` date NOT NULL COMMENT 'Дата рождения',
  `gender` enum('Male','Female') NOT NULL COMMENT 'Пол',
  `marital_status_id` tinyint unsigned NOT NULL COMMENT 'Семейное положение',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `password_hash` (`password_hash`),
  UNIQUE KEY `email` (`email`),
  KEY `customer_id` (`customer_id`),
  KEY `correspondence_language_id` (`correspondence_language_id`),
  KEY `marital_status_id` (`marital_status_id`),
  CONSTRAINT `customers_profile_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `customers_profile_ibfk_2` FOREIGN KEY (`correspondence_language_id`) REFERENCES `languages` (`id`),
  CONSTRAINT `customers_profile_ibfk_3` FOREIGN KEY (`marital_status_id`) REFERENCES `marital_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица профилей покупателей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `correspondence_language` char(2) NOT NULL COMMENT 'Язык общения',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица языков общения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marital_status`
--

DROP TABLE IF EXISTS `marital_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marital_status` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `marital_status` enum('Uknown','Not married','Married','Divorced','Widower') DEFAULT NULL COMMENT 'Семейное положение',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица семейного положения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postal_codes`
--

DROP TABLE IF EXISTS `postal_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postal_codes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `postal_code` varchar(10) NOT NULL COMMENT 'Почтовый индекс',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица почтовых индексов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `region` varchar(20) NOT NULL COMMENT 'Регион',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица регионов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `streets`
--

DROP TABLE IF EXISTS `streets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `street` varchar(100) NOT NULL COMMENT 'Улица',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица улиц';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-03 21:16:03
