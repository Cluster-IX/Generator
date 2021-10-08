-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Oct 07, 2021 at 09:51 PM
-- Server version: 5.7.35
-- PHP Version: 7.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `CBT_JATIM`
--
CREATE DATABASE IF NOT EXISTS `CBT_JATIM` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `CBT_JATIM`;

-- --------------------------------------------------------

--
-- Table structure for table `Jawaban`
--

DROP TABLE IF EXISTS `Jawaban`;
CREATE TABLE IF NOT EXISTS `Jawaban` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_siswa` int(11) NOT NULL,
  `id_soal` int(11) NOT NULL,
  `value` enum('a','b','c','d') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jawaban_benar` enum('a','b','c','d') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Jawaban_id_soal_fkey` (`id_soal`),
  KEY `Jawaban_id_siswa_fkey` (`id_siswa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Kota`
--

DROP TABLE IF EXISTS `Kota`;
CREATE TABLE IF NOT EXISTS `Kota` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Mata_Pelajaran`
--

DROP TABLE IF EXISTS `Mata_Pelajaran`;
CREATE TABLE IF NOT EXISTS `Mata_Pelajaran` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Siswa`
--

DROP TABLE IF EXISTS `Siswa`;
CREATE TABLE IF NOT EXISTS `Siswa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nrp` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nrp` (`nrp`),
  UNIQUE KEY `nama` (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Soal`
--

DROP TABLE IF EXISTS `Soal`;
CREATE TABLE IF NOT EXISTS `Soal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_mapel` int(11) NOT NULL,
  `jawaban_benar` enum('a','b','c','d') COLLATE utf8mb4_unicode_ci NOT NULL,
  `konten` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pilihan_a` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pilihan_b` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pilihan_c` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pilihan_d` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Soal_id_mapel_fkey` (`id_mapel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Jawaban`
--
ALTER TABLE `Jawaban`
  ADD CONSTRAINT `Jawaban_id_siswa_fkey` FOREIGN KEY (`id_siswa`) REFERENCES `Siswa` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Jawaban_id_soal_fkey` FOREIGN KEY (`id_soal`) REFERENCES `Soal` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `Soal`
--
ALTER TABLE `Soal`
  ADD CONSTRAINT `Soal_id_mapel_fkey` FOREIGN KEY (`id_mapel`) REFERENCES `Mata_Pelajaran` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
