-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: zephyr.proxy.rlwy.net    Database: railway
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `colaborador`
--

DROP TABLE IF EXISTS `colaborador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colaborador` (
  `id_colaborador` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `id_turno` int DEFAULT NULL,
  `nome_completo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `senha` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `avatar_img` mediumblob,
  `biometria_facial` mediumblob,
  `cargo` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `horas_extras` decimal(5,2) DEFAULT '0.00',
  `data_contratacao` date DEFAULT NULL,
  PRIMARY KEY (`id_colaborador`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_colaborador_turno` (`id_turno`),
  KEY `fk_colaborador_empresa` (`id_empresa`),
  CONSTRAINT `fk_colaborador_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`),
  CONSTRAINT `fk_colaborador_turno` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colaborador`
--

LOCK TABLES `colaborador` WRITE;
/*!40000 ALTER TABLE `colaborador` DISABLE KEYS */;
/*!40000 ALTER TABLE `colaborador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracoes`
--

DROP TABLE IF EXISTS `configuracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracoes` (
  `id_config` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int DEFAULT NULL,
  `tema_layout` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tema_tabela` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notificacoes` tinyint(1) DEFAULT '1',
  `alto_contraste` tinyint(1) DEFAULT '0',
  `atrasos` tinyint(1) DEFAULT '1',
  `backup_automatico` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_config`),
  UNIQUE KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `fk_config_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracoes`
--

LOCK TABLES `configuracoes` WRITE;
/*!40000 ALTER TABLE `configuracoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuracoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispositivo`
--

DROP TABLE IF EXISTS `dispositivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispositivo` (
  `id_dispositivo` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `tipo_dispositivo` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `codigo_dispositivo` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `conexao` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_dispositivo`),
  KEY `fk_dispositivo_empresa` (`id_empresa`),
  CONSTRAINT `fk_dispositivo_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispositivo`
--

LOCK TABLES `dispositivo` WRITE;
/*!40000 ALTER TABLE `dispositivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispositivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `id_gestor` int NOT NULL,
  `nome_empresa` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `cnpj` varchar(18) COLLATE utf8mb4_general_ci NOT NULL,
  `telefone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nivel_assinatura` tinyint DEFAULT '1',
  `gasto_estimado` decimal(10,2) DEFAULT NULL,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `cnpj` (`cnpj`),
  KEY `fk_empresa_gestor` (`id_gestor`),
  CONSTRAINT `fk_empresa_gestor` FOREIGN KEY (`id_gestor`) REFERENCES `gestor` (`id_gestor`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,2,'empresa_teste','1111111','','',1,NULL,'2026-05-29 17:51:20'),(2,2,'supcom','1231231312','','',2,NULL,'2026-05-29 18:04:59'),(3,1,'supcom','12','','',1,NULL,'2026-05-29 18:29:41'),(4,3,'nome','1231234','','',1,NULL,'2026-05-29 18:45:07'),(5,4,'teste','1234124','','',1,NULL,'2026-05-31 00:41:56'),(6,5,'asfFafsafs','12342414','','',1,NULL,'2026-05-31 00:42:56'),(7,6,'asffasfasfa','12412424','','',1,NULL,'2026-05-31 02:23:00'),(8,7,'pointr','123132133','','',2,NULL,'2026-05-31 02:35:47'),(9,8,'Cr7','7777777777','11 9777777','cr7-contato@gmail.com',1,NULL,'2026-05-31 02:55:54'),(10,1,'pointr','3243124124','','',1,NULL,'2026-05-31 03:00:04'),(11,1,'siteforge','2343523523','','',1,NULL,'2026-05-31 03:00:17'),(12,10,'sigma games','144124241241','','',1,NULL,'2026-05-31 04:11:19'),(13,11,'Supcom2','3737','','',1,NULL,'2026-05-31 13:09:05'),(14,14,'Os coroas fatecanos','511515515184848','11854184184188484','udhsbudsduc@gmail.com',1,NULL,'2026-05-31 17:43:27'),(15,16,'Os coroas fatecanos 2','41854185689489','14741285848','ervcervcerverver@gmail.com',1,NULL,'2026-05-31 17:50:11'),(16,20,'Pointr','22','11','1@e',1,NULL,'2026-05-31 20:40:24'),(17,20,'Pointr33','12121212121','212','E@E',1,NULL,'2026-05-31 20:58:10'),(18,1,'teste_09','42141414','3124142141','contato@gmail.com',1,NULL,'2026-05-31 21:21:55'),(19,21,'empresa do caio2','12341241','12441','caio2@gmail.com',1,NULL,'2026-05-31 22:00:14');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `id_evento` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `titulo_evento` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descricao` text COLLATE utf8mb4_general_ci,
  `data_evento` date DEFAULT NULL,
  `horario_evento` time DEFAULT NULL,
  `evento_recorrente` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_evento`),
  KEY `fk_evento_empresa` (`id_empresa`),
  CONSTRAINT `fk_evento_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestor`
--

DROP TABLE IF EXISTS `gestor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestor` (
  `id_gestor` int NOT NULL AUTO_INCREMENT,
  `nome_completo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `senha` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` mediumblob,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_gestor`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestor`
--

LOCK TABLES `gestor` WRITE;
/*!40000 ALTER TABLE `gestor` DISABLE KEYS */;
INSERT INTO `gestor` VALUES (1,'caio','11111','caio@gmail.com','12',NULL,'2026-05-29 17:14:45'),(2,'conta2','2222','conta2@gmail.com','12',NULL,'2026-05-29 17:42:52'),(3,'teste','1231312314','teste@gmail.com','12',NULL,'2026-05-29 18:44:47'),(4,'teste3','333333333','teste3@gmail.com','12',NULL,'2026-05-31 00:39:43'),(5,'teste4','44444444','teste4@gmail.com','12',NULL,'2026-05-31 00:42:41'),(6,'teste5','555555555','teste5@gmail.com','12',NULL,'2026-05-31 02:21:35'),(7,'eduardo gama','1223345345345','dudu@gmail.com','12',NULL,'2026-05-31 02:35:16'),(8,'Cristiano Ronaldo','777777','cr7@gmail.com','777',NULL,'2026-05-31 02:54:58'),(9,'joao silva','12345678900','seu@email.com','12',NULL,'2026-05-31 03:07:08'),(10,'tung tung tung sahur','124124124','tripleT@outlook.com.br','0001',NULL,'2026-05-31 04:10:31'),(11,'Caio gay','24242424','lol@gmail.com','caio',NULL,'2026-05-31 13:08:31'),(13,'ao Vasco da Gama','53465','vasco@gmail.com','123',NULL,'2026-05-31 13:09:46'),(14,'Fernando Cruz','12345678910','fernandoteste@gmail.com','@Fernando123',NULL,'2026-05-31 17:42:49'),(16,'Fernando O PENSADOR','12345678911','fernando@gmail.com','Fernando123',NULL,'2026-05-31 17:49:30'),(17,'teste8','888888888','teste8@gmail.com','12',NULL,'2026-05-31 19:41:17'),(20,'Eduardo','99999999999','eu@gmail.com','232323212',NULL,'2026-05-31 20:08:37'),(21,'caio2','22222222222','caio2@gmail.com','123456',NULL,'2026-05-31 21:58:44');
/*!40000 ALTER TABLE `gestor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_sistema`
--

DROP TABLE IF EXISTS `log_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_sistema` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_ponto` int DEFAULT NULL,
  `horario` datetime DEFAULT CURRENT_TIMESTAMP,
  `tipo` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descricao` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id_log`),
  KEY `fk_log_ponto` (`id_ponto`),
  CONSTRAINT `fk_log_ponto` FOREIGN KEY (`id_ponto`) REFERENCES `ponto` (`id_ponto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_sistema`
--

LOCK TABLES `log_sistema` WRITE;
/*!40000 ALTER TABLE `log_sistema` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_sistema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ponto`
--

DROP TABLE IF EXISTS `ponto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ponto` (
  `id_ponto` int NOT NULL AUTO_INCREMENT,
  `id_colaborador` int NOT NULL,
  `id_dispositivo` int DEFAULT NULL,
  `horario` datetime NOT NULL,
  `tipo` enum('ENTRADA','SAIDA','ALMOCO','RETORNO') COLLATE utf8mb4_general_ci NOT NULL,
  `geolocalizacao` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `modificado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_ponto`),
  KEY `fk_ponto_colaborador` (`id_colaborador`),
  KEY `fk_ponto_dispositivo` (`id_dispositivo`),
  CONSTRAINT `fk_ponto_colaborador` FOREIGN KEY (`id_colaborador`) REFERENCES `colaborador` (`id_colaborador`),
  CONSTRAINT `fk_ponto_dispositivo` FOREIGN KEY (`id_dispositivo`) REFERENCES `dispositivo` (`id_dispositivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ponto`
--

LOCK TABLES `ponto` WRITE;
/*!40000 ALTER TABLE `ponto` DISABLE KEYS */;
/*!40000 ALTER TABLE `ponto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relatorio`
--

DROP TABLE IF EXISTS `relatorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relatorio` (
  `id_relatorio` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `data_relatorio` date DEFAULT NULL,
  `periodo` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tipo_relatorio` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `json_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `layout_relatorio` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horas_trabalhadas` decimal(6,2) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `valor_hora_extra` decimal(10,2) DEFAULT NULL,
  `data_envio_email` datetime DEFAULT NULL,
  PRIMARY KEY (`id_relatorio`),
  KEY `fk_relatorio_empresa` (`id_empresa`),
  CONSTRAINT `fk_relatorio_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`),
  CONSTRAINT `relatorio_chk_1` CHECK (json_valid(`json_data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relatorio`
--

LOCK TABLES `relatorio` WRITE;
/*!40000 ALTER TABLE `relatorio` DISABLE KEYS */;
/*!40000 ALTER TABLE `relatorio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno`
--

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turno` (
  `id_turno` int NOT NULL AUTO_INCREMENT,
  `titulo_turno` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horario_entrada` time NOT NULL,
  `horario_saida` time NOT NULL,
  `horario_almoco` time DEFAULT NULL,
  `tolerancia_horario` int DEFAULT '10',
  `tolerancia_almoco` int DEFAULT '10',
  `carga_horaria_semanal` decimal(5,2) DEFAULT NULL,
  `recorrencia` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fuso_horario` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-31 19:51:12
