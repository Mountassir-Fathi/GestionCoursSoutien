CREATE DATABASE  IF NOT EXISTS `centre_cours` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `centre_cours`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: centre_cours
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `emplois`
--

DROP TABLE IF EXISTS `emplois`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emplois` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `niveau_id` int unsigned NOT NULL,
  `groupe_id` int unsigned NOT NULL,
  `matiere_id` int unsigned NOT NULL,
  `salle_id` int unsigned NOT NULL,
  `timestart` time NOT NULL,
  `timeend` time NOT NULL,
  `date` date NOT NULL,
  `fait` tinyint(1) NOT NULL DEFAULT (false),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emplois`
--

LOCK TABLES `emplois` WRITE;
/*!40000 ALTER TABLE `emplois` DISABLE KEYS */;
INSERT INTO `emplois` VALUES (22,2,4,2,2,'23:53:00','23:58:00','2023-12-31',0);
/*!40000 ALTER TABLE `emplois` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `emplois_AFTER_INSERT` AFTER INSERT ON `emplois` FOR EACH ROW BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE vetudiant_id INT;
    DECLARE cur CURSOR FOR 
        SELECT id 
        FROM etudiants 
        WHERE new.niveau_id = niveau_id 
            AND new.groupe_id = group_id 
            AND new.matiere_id IN (SELECT matiere_id FROM etudiant_matiere WHERE etudiant_id = id) 
            AND compte_statue = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    cur_loop: LOOP
        FETCH cur INTO vetudiant_id;
        IF done THEN
            LEAVE cur_loop;
        END IF; 

        INSERT INTO presences (seance_id, etudiant_id) VALUES (NEW.id, vetudiant_id);
    END LOOP cur_loop;

    CLOSE cur;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `etudiant_matiere`
--

DROP TABLE IF EXISTS `etudiant_matiere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant_matiere` (
  `etudiant_id` int unsigned NOT NULL,
  `matiere_id` int unsigned NOT NULL,
  UNIQUE KEY `uc_etudiant_matiere` (`etudiant_id`,`matiere_id`),
  KEY `fk_em_etudiants_idx` (`etudiant_id`),
  KEY `fk_em_matiers_idx` (`matiere_id`),
  CONSTRAINT `fk_em_etudiants` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiants` (`id`),
  CONSTRAINT `fk_em_matiers` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant_matiere`
--

LOCK TABLES `etudiant_matiere` WRITE;
/*!40000 ALTER TABLE `etudiant_matiere` DISABLE KEYS */;
INSERT INTO `etudiant_matiere` VALUES (26,2),(26,3),(42,2),(42,3),(43,3),(49,3);
/*!40000 ALTER TABLE `etudiant_matiere` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiants`
--

DROP TABLE IF EXISTS `etudiants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiants` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tel` varchar(20) NOT NULL,
  `niveau_id` int unsigned NOT NULL,
  `group_id` int unsigned NOT NULL,
  `date_inscri` date NOT NULL,
  `compte_statue` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tel_UNIQUE` (`tel`),
  KEY `fk_niveau_etudiant_idx` (`niveau_id`),
  KEY `fk_groupe_etudiant_idx` (`group_id`),
  CONSTRAINT `fk_groupe_etudiant` FOREIGN KEY (`group_id`) REFERENCES `groupes` (`id`),
  CONSTRAINT `fk_niveau_etudiant` FOREIGN KEY (`niveau_id`) REFERENCES `niveaux` (`id`),
  CONSTRAINT `fk_user_etudiant` FOREIGN KEY (`id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiants`
--

LOCK TABLES `etudiants` WRITE;
/*!40000 ALTER TABLE `etudiants` DISABLE KEYS */;
INSERT INTO `etudiants` VALUES (26,'+212 645454540',5,4,'2023-12-09',1),(42,'+212 645434349',2,4,'2023-12-11',1),(43,'+212 626942351',2,4,'2023-11-14',1),(45,'+212 645454544',1,1,'2023-12-21',0),(46,'+212 645454500',1,1,'2023-12-22',0),(49,'+212 645459993',2,4,'2023-12-24',1);
/*!40000 ALTER TABLE `etudiants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupes`
--

DROP TABLE IF EXISTS `groupes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groupes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `niveau_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom_UNIQUE` (`nom`),
  KEY `fk_groupe_niveau` (`niveau_id`),
  CONSTRAINT `fk_groupe_niveau` FOREIGN KEY (`niveau_id`) REFERENCES `niveaux` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupes`
--

LOCK TABLES `groupes` WRITE;
/*!40000 ALTER TABLE `groupes` DISABLE KEYS */;
INSERT INTO `groupes` VALUES (1,'sans',2),(4,'g4',2);
/*!40000 ALTER TABLE `groupes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matieres`
--

DROP TABLE IF EXISTS `matieres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matieres` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prix` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom_UNIQUE` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matieres`
--

LOCK TABLES `matieres` WRITE;
/*!40000 ALTER TABLE `matieres` DISABLE KEYS */;
INSERT INTO `matieres` VALUES (2,'MATH',100),(3,'SVT',140),(12,'PC',150);
/*!40000 ALTER TABLE `matieres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `niveau_matieres`
--

DROP TABLE IF EXISTS `niveau_matieres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `niveau_matieres` (
  `id_niveau` int unsigned NOT NULL,
  `id_matiere` int unsigned NOT NULL,
  KEY `fk_nm_matier_idx` (`id_matiere`),
  KEY `fk_nm_niveau_idx` (`id_niveau`),
  CONSTRAINT `fk_nm_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matieres` (`id`),
  CONSTRAINT `fk_nm_niveau` FOREIGN KEY (`id_niveau`) REFERENCES `niveaux` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveau_matieres`
--

LOCK TABLES `niveau_matieres` WRITE;
/*!40000 ALTER TABLE `niveau_matieres` DISABLE KEYS */;
INSERT INTO `niveau_matieres` VALUES (2,2),(1,3),(2,2);
/*!40000 ALTER TABLE `niveau_matieres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `niveaux`
--

DROP TABLE IF EXISTS `niveaux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `niveaux` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom_UNIQUE` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveaux`
--

LOCK TABLES `niveaux` WRITE;
/*!40000 ALTER TABLE `niveaux` DISABLE KEYS */;
INSERT INTO `niveaux` VALUES (4,'1AC'),(2,'1BAC'),(6,'2AC'),(3,'2BAC'),(7,'3AC'),(1,'sans'),(5,'TCS');
/*!40000 ALTER TABLE `niveaux` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payement_etudiant`
--

DROP TABLE IF EXISTS `payement_etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payement_etudiant` (
  `payement_id` int unsigned NOT NULL,
  `etudiant_id` int unsigned NOT NULL,
  `payer` tinyint NOT NULL DEFAULT '0',
  KEY `fk_pe_etudiant_idx` (`etudiant_id`),
  KEY `fk_pe_payement_idx` (`payement_id`),
  CONSTRAINT `fk_pe_etudiant` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiants` (`id`),
  CONSTRAINT `fk_pe_payement` FOREIGN KEY (`payement_id`) REFERENCES `payements` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payement_etudiant`
--

LOCK TABLES `payement_etudiant` WRITE;
/*!40000 ALTER TABLE `payement_etudiant` DISABLE KEYS */;
INSERT INTO `payement_etudiant` VALUES (1,26,1);
/*!40000 ALTER TABLE `payement_etudiant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payements`
--

DROP TABLE IF EXISTS `payements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payements` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `mois` varchar(45) NOT NULL,
  `total` double unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mois_UNIQUE` (`mois`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payements`
--

LOCK TABLES `payements` WRITE;
/*!40000 ALTER TABLE `payements` DISABLE KEYS */;
INSERT INTO `payements` VALUES (1,'Janvier',0),(2,'Février',0),(3,'Mars',0),(4,'Avril',0),(5,'Mai',0),(6,'Juin',0),(7,'Juillet',0),(8,'Août',0),(9,'Septembre',0),(10,'Octobre',0),(11,'Novembre',2000),(12,'Décembre',3000);
/*!40000 ALTER TABLE `payements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presences`
--

DROP TABLE IF EXISTS `presences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presences` (
  `seance_id` int unsigned NOT NULL,
  `etudiant_id` int unsigned NOT NULL,
  `pesence` tinyint unsigned NOT NULL DEFAULT '1',
  UNIQUE KEY `unique_key` (`seance_id`,`etudiant_id`),
  KEY `fk_se_seance_idx` (`seance_id`),
  KEY `fk_se_seance_idx1` (`etudiant_id`),
  CONSTRAINT `fk_se_etudiant` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiants` (`id`),
  CONSTRAINT `fk_se_seance` FOREIGN KEY (`seance_id`) REFERENCES `emplois` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presences`
--

LOCK TABLES `presences` WRITE;
/*!40000 ALTER TABLE `presences` DISABLE KEYS */;
/*!40000 ALTER TABLE `presences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prof_niveau`
--

DROP TABLE IF EXISTS `prof_niveau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prof_niveau` (
  `prof_id` int unsigned NOT NULL,
  `niveau_id` int unsigned NOT NULL,
  UNIQUE KEY `uc_prof_niveau` (`prof_id`,`niveau_id`),
  KEY `fk_pn_prof_idx` (`prof_id`) /*!80000 INVISIBLE */,
  KEY `fk_pn_niveau_idx` (`niveau_id`),
  CONSTRAINT `fk_pn_prof` FOREIGN KEY (`prof_id`) REFERENCES `profs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prof_niveau`
--

LOCK TABLES `prof_niveau` WRITE;
/*!40000 ALTER TABLE `prof_niveau` DISABLE KEYS */;
INSERT INTO `prof_niveau` VALUES (52,2),(53,2),(41,5),(52,5);
/*!40000 ALTER TABLE `prof_niveau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profs`
--

DROP TABLE IF EXISTS `profs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profs` (
  `id` int unsigned NOT NULL,
  `date_debut` date NOT NULL,
  `matiere_id` int unsigned NOT NULL,
  `tel` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tel_UNIQUE` (`tel`),
  KEY `fk_matiere_prof_idx` (`matiere_id`),
  CONSTRAINT `fk_matiere_prof` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profs`
--

LOCK TABLES `profs` WRITE;
/*!40000 ALTER TABLE `profs` DISABLE KEYS */;
INSERT INTO `profs` VALUES (41,'2023-12-11',2,'+212 645454541'),(52,'2023-12-28',2,'+212 645454549'),(53,'2023-12-30',12,'+212 645454111');
/*!40000 ALTER TABLE `profs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salle`
--

DROP TABLE IF EXISTS `salle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salle` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nemuro` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nemuro_UNIQUE` (`nemuro`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salle`
--

LOCK TABLES `salle` WRITE;
/*!40000 ALTER TABLE `salle` DISABLE KEYS */;
INSERT INTO `salle` VALUES (2,'Salle1'),(8,'Salle2'),(6,'Salle3');
/*!40000 ALTER TABLE `salle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('ETUDIANT','PROF','MANAGER') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'amal','sou','ama@gmail.com','123','PROF'),(26,'abdo','hind','example@example.com','1234','ETUDIANT'),(41,'kram','sin','sdfsd@dfdf33','123','MANAGER'),(42,'mountassir','fathi','sdfsd@dfdf','123','ETUDIANT'),(43,'oussama','kaissouni','oussama@gmail.com','123','ETUDIANT'),(45,'fahti','karam','example1@example.com','sdfsffsdsdf','ETUDIANT'),(46,'douaf','anass','example5@example.com','123','ETUDIANT'),(49,'karim','aaban','karim@gmail.com','123','ETUDIANT'),(52,'abdsamad','hafiani','Prof@example.com','123','PROF'),(53,'kamal','fathi','kamal@gmail.com','123','PROF');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'centre_cours'
--

--
-- Dumping routines for database 'centre_cours'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-02 13:43:26
