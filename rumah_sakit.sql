-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 14, 2026 at 05:35 AM
-- Server version: 10.4.28-MariaDB-log
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rumah_sakit`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `check1` ()   BEGIN
START TRANSACTION;

INSERT INTO pasien (nama_pasien, alamat_pasien, jenis_kelamin)
VALUES ('Ardi', 'Jl. Palang no. 30', 'L');
SAVEPOINT POINT1;

INSERT INTO pasien (nama_pasien, alamat_pasien, jenis_kelamin)
VALUES ('Tina', 'Jl. Sangkuriang no 45', 'P');
ROLLBACK TO SAVEPOINT POINT1;

INSERT INTO pasien (nama_pasien, alamat_pasien, jenis_kelamin)
VALUES ('Krisna', 'Jl. Handoyo no 50', 'L');

COMMIT;

SELECT * FROM pasien;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rollback1` ()   BEGIN
START TRANSACTION;

UPDATE pasien SET nama_pasien='Danar' WHERE id_pasien=3;
ROLLBACK;
COMMIT;
SELECT * FROM pasien;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rollback2` ()   BEGIN
START TRANSACTION;

INSERT INTO pasien (nama_pasien, alamat_pasien, jenis_kelamin)
VALUES
('Robi', 'Jl. Simpang no.11', 'L');
ROLLBACK;

UPDATE pasien 
SET nama_pasien = 'Sudirman'
WHERE id_pasien = 1;

COMMIT;

SELECT * FROM pasien;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaksi1` ()   BEGIN
START TRANSACTION;

INSERT INTO pasien (nama_pasien, alamat_pasien, jenis_kelamin)
VALUES
('Lili', 'Jl. Sudirman No. 45', 'P');

SELECT * FROM pasien;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaksi2` ()   BEGIN
START TRANSACTION;

INSERT INTO pasien (nama_pasien, alamat_pasien, jenis_kelamin)
VALUES
('Oka', 'Jl. Linmas No. 45', 'L');

SELECT * FROM pasien;

COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `id_admin` int(11) NOT NULL,
  `nama_admin` varchar(100) NOT NULL,
  `waktu_jaga` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`id_admin`, `nama_admin`, `waktu_jaga`) VALUES
(1, 'Hendra Wijaya', 'Pagi'),
(2, 'Rina Setiawati', 'Siang'),
(3, 'Fahmi Idris', 'Malam');

-- --------------------------------------------------------

--
-- Table structure for table `daftar`
--

CREATE TABLE `daftar` (
  `id_daftar` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `id_pasien` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daftar`
--

INSERT INTO `daftar` (`id_daftar`, `id_admin`, `id_pasien`) VALUES
(1, 2, 3),
(2, 1, 6),
(3, 3, 1),
(4, 1, 7),
(5, 2, 2),
(6, 2, 5),
(7, 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` int(11) NOT NULL,
  `nama_dokter` varchar(100) NOT NULL,
  `spesialisasi` varchar(100) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `alamat_dokter` varchar(100) NOT NULL,
  `no_hp` varchar(15) NOT NULL,
  `waktu_kerja` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `nama_dokter`, `spesialisasi`, `tanggal_lahir`, `alamat_dokter`, `no_hp`, `waktu_kerja`) VALUES
(1, 'Erwin Syarif, Sp.PD', 'Penyakit Dalam', '1989-05-07', 'Jl.Rama no.3, Jakarta', '081256748875', 'Siang'),
(2, 'Farel, Sp.PA', 'Penyakit Anak', '1991-08-13', 'Jl. Ino no.14, Bekasi', '085133495786', 'Pagi'),
(3, 'Abel, Sp.JP', 'Penyakit Jantung dan Pembuluh Darah', '1991-05-12', 'Jl. Luwak no.35, Jakarta', '081143358776', 'Malam');

-- --------------------------------------------------------

--
-- Table structure for table `dokter_admin`
--

CREATE TABLE `dokter_admin` (
  `id_data` int(11) NOT NULL,
  `id_dokter` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dokter_admin`
--

INSERT INTO `dokter_admin` (`id_data`, `id_dokter`, `id_admin`) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(3) NOT NULL,
  `kode_obat` varchar(5) NOT NULL,
  `nama_obat` varchar(30) NOT NULL,
  `harga` int(10) NOT NULL,
  `stok` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id_obat`, `kode_obat`, `nama_obat`, `harga`, `stok`) VALUES
(1, 'D1011', 'Metformin', 150000, 10),
(2, 'D1012', 'Omeprazole', 200000, 16),
(3, 'D1101', 'Ibuprofen', 20000, 30),
(4, 'D1102', 'Amoxicillin', 25000, 33),
(5, 'D2014', 'Isosorbide Dinitrate', 220000, 8),
(6, 'D2015', 'Furosemide', 90000, 22),
(7, 'D1103', 'Salbutamol', 30000, 30);

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` int(11) NOT NULL,
  `nama_pasien` varchar(100) NOT NULL,
  `alamat_pasien` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `nama_pasien`, `alamat_pasien`, `jenis_kelamin`) VALUES
(1, 'Sudirman', 'Jl. Merdeka No. 12, Jakarta', 'L'),
(2, 'Siti Aminah', 'Jl. Mawar No. 5, Bandung', 'P'),
(3, 'Budi Darmawan', 'Jl. Diponegoro No. 45, Surabaya', 'L'),
(4, 'Dewi Lestari', 'Jl. Anggrek No. 8, Yogyakarta', 'P'),
(5, 'Eko Prasetyo', 'Jl. Gatot Subroto No. 21, Medan', 'L'),
(6, 'Fitri Handayani', 'Jl. Kenanga No. 14, Semarang', 'P'),
(7, 'Gilang Permana', 'Jl. Sudirman No. 99, Makassar', 'L'),
(8, 'Tito', 'Jl. Pakis Haji no 23', 'L'),
(12, 'Wallace', 'Jl. Pakis No. 25', 'L'),
(18, 'Smith', 'Jl. Pakis No. 45', 'L'),
(20, 'Sule', 'Jl. Babakan loa no. 30', 'L'),
(22, 'Syarif', 'Jl. Dipenogoro no 50', 'L'),
(24, 'Oka', 'Jl. Linmas No. 45', 'L'),
(26, 'Ardi', 'Jl. Palang no. 30', 'L'),
(28, 'Krisna', 'Jl. Handoyo no 50', 'L');

-- --------------------------------------------------------

--
-- Table structure for table `pasien_dokter`
--

CREATE TABLE `pasien_dokter` (
  `id` int(11) NOT NULL,
  `id_dokter` int(11) NOT NULL,
  `id_pasien` int(11) NOT NULL,
  `resep` varchar(10) NOT NULL,
  `waktu_periksa` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien_dokter`
--

INSERT INTO `pasien_dokter` (`id`, `id_dokter`, `id_pasien`, `resep`, `waktu_periksa`) VALUES
(1, 1, 3, 'D1012', '2026-05-12'),
(2, 2, 6, 'D1102', '2026-04-25'),
(3, 3, 1, 'D2014', '2026-04-22'),
(4, 2, 7, 'D1101', '2026-03-29'),
(5, 1, 2, 'D1011', '2026-03-20'),
(6, 1, 5, 'D1012', '2026-03-15'),
(7, 3, 4, 'D2014', '2026-03-12');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_obat`
--

CREATE TABLE `transaksi_obat` (
  `id_transaksi` int(5) NOT NULL,
  `id_pasien` int(3) NOT NULL,
  `id_obat` int(3) NOT NULL,
  `jumlah` int(10) NOT NULL,
  `total_harga` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi_obat`
--

INSERT INTO `transaksi_obat` (`id_transaksi`, `id_pasien`, `id_obat`, `jumlah`, `total_harga`) VALUES
(1, 1, 5, 2, 440000),
(2, 2, 2, 4, 0),
(3, 3, 4, 2, 0);

--
-- Triggers `transaksi_obat`
--
DELIMITER $$
CREATE TRIGGER `tg_jual` AFTER INSERT ON `transaksi_obat` FOR EACH ROW UPDATE obat SET stok=stok-new.jumlah WHERE id_obat=new.id_obat
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `daftar`
--
ALTER TABLE `daftar`
  ADD PRIMARY KEY (`id_daftar`),
  ADD KEY `FK_ADMIN_DAFTAR` (`id_admin`),
  ADD KEY `FK_PASIEN_DAFTAR` (`id_pasien`);

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`);

--
-- Indexes for table `dokter_admin`
--
ALTER TABLE `dokter_admin`
  ADD PRIMARY KEY (`id_data`),
  ADD KEY `FK_DOKTER_DATA` (`id_dokter`),
  ADD KEY `FK_ADMIN_DATA` (`id_admin`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`);

--
-- Indexes for table `pasien_dokter`
--
ALTER TABLE `pasien_dokter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_DOKTER_PERIKSA` (`id_dokter`),
  ADD KEY `FK_PASIEN_PERIKSA` (`id_pasien`);

--
-- Indexes for table `transaksi_obat`
--
ALTER TABLE `transaksi_obat`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `FK_TRANSAKSI` (`id_pasien`),
  ADD KEY `FK_OBAT` (`id_obat`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrator`
--
ALTER TABLE `administrator`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `daftar`
--
ALTER TABLE `daftar`
  MODIFY `id_daftar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dokter_admin`
--
ALTER TABLE `dokter_admin`
  MODIFY `id_data` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id_pasien` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `pasien_dokter`
--
ALTER TABLE `pasien_dokter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `transaksi_obat`
--
ALTER TABLE `transaksi_obat`
  MODIFY `id_transaksi` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `daftar`
--
ALTER TABLE `daftar`
  ADD CONSTRAINT `FK_ADMIN_DAFTAR` FOREIGN KEY (`id_admin`) REFERENCES `administrator` (`id_admin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PASIEN_DAFTAR` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dokter_admin`
--
ALTER TABLE `dokter_admin`
  ADD CONSTRAINT `FK_ADMIN_DATA` FOREIGN KEY (`id_admin`) REFERENCES `administrator` (`id_admin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DOKTER_DATA` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pasien_dokter`
--
ALTER TABLE `pasien_dokter`
  ADD CONSTRAINT `FK_DOKTER_PERIKSA` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PASIEN_PERIKSA` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaksi_obat`
--
ALTER TABLE `transaksi_obat`
  ADD CONSTRAINT `FK_OBAT` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TRANSAKSI` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
