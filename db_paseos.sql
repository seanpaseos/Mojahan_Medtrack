-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2025 at 06:38 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_paseos`
--

-- --------------------------------------------------------

--
-- Table structure for table `administer`
--

CREATE TABLE `administer` (
  `Administer_ID` int(11) NOT NULL,
  `doctor_ID` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `assistant_ID` int(11) DEFAULT NULL,
  `patient_ID` int(11) DEFAULT NULL,
  `vaccine_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administer`
--

INSERT INTO `administer` (`Administer_ID`, `doctor_ID`, `date`, `assistant_ID`, `patient_ID`, `vaccine_ID`) VALUES
(1, 1, '2025-03-05', 1, 1, 1),
(2, 2, '2025-03-06', 2, 2, 2),
(3, 1, '2025-03-27', 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `assistant`
--

CREATE TABLE `assistant` (
  `assistant_ID` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `date_hired` date DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assistant`
--

INSERT INTO `assistant` (`assistant_ID`, `username`, `date_hired`, `description`, `password`) VALUES
(1, 'assistant1', '2025-03-01', 'Vaccine supply manager', 'securepass123'),
(2, 'assistant2', '2025-03-02', 'Patient record keeper', 'recordspass456');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `doctor_ID` int(11) NOT NULL,
  `effectivity_date` date DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `dr_License` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`doctor_ID`, `effectivity_date`, `password`, `dr_License`) VALUES
(1, '2020-01-15', 'password123', 'LIC12345'),
(2, '2019-06-10', 'securepass', 'LIC67890');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `order_ID` int(11) NOT NULL,
  `doctor_ID` int(11) DEFAULT NULL,
  `assistant_ID` int(11) DEFAULT NULL,
  `supplier_ID` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`order_ID`, `doctor_ID`, `assistant_ID`, `supplier_ID`, `order_date`, `total`) VALUES
(1, 1, NULL, 1, '2025-03-01', 1999.50),
(2, 2, NULL, 2, '2025-03-02', 1450.00);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_ID` int(11) NOT NULL,
  `PatientName` varchar(100) NOT NULL,
  `VaccineName` varchar(100) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `PurchaseDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_ID`, `PatientName`, `VaccineName`, `Quantity`, `PurchaseDate`) VALUES
(1, 'John Doe', 'Pfizer', 4, '2025-02-18'),
(2, 'Jane Smith', 'Moderna', 5, '2025-02-19'),
(21, 'Pearl', 'Biogesic', 5, '2025-03-21');

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `Person_ID` int(11) NOT NULL,
  `dr_firstname` varchar(50) DEFAULT NULL,
  `dr_Surname` varchar(50) DEFAULT NULL,
  `dr_Middlename` varchar(50) DEFAULT NULL,
  `dr_License` varchar(20) DEFAULT NULL,
  `dr_Gender` char(1) DEFAULT NULL,
  `dr_age` int(11) DEFAULT NULL,
  `dr_number` varchar(15) DEFAULT NULL,
  `dr_address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`Person_ID`, `dr_firstname`, `dr_Surname`, `dr_Middlename`, `dr_License`, `dr_Gender`, `dr_age`, `dr_number`, `dr_address`) VALUES
(1, 'John', 'Doe', 'A.', 'LIC12345', 'M', 45, '1234567890', '123 Main St'),
(2, 'Jane', 'Smith', 'B.', 'LIC67890', 'F', 38, '0987654321', '456 Elm St');

-- --------------------------------------------------------

--
-- Table structure for table `stock_out`
--

CREATE TABLE `stock_out` (
  `stockout_ID` int(11) NOT NULL,
  `stockout_date` date DEFAULT NULL,
  `vaccine_ID` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `doctor_ID` int(11) DEFAULT NULL,
  `assistant_ID` int(11) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_out`
--

INSERT INTO `stock_out` (`stockout_ID`, `stockout_date`, `vaccine_ID`, `quantity`, `doctor_ID`, `assistant_ID`, `description`) VALUES
(1, '2025-03-04', 1, 25, 1, 1, 'Distributed to Clinic A'),
(2, '2025-03-05', 2, 10, 2, 2, 'Distributed to Clinic B');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplier_ID` int(11) NOT NULL,
  `supplier_name` varchar(50) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplier_ID`, `supplier_name`, `contact`, `location`) VALUES
(1, 'MediSupply Co.', '555-1234', 'New York'),
(2, 'HealthGoods Inc.', '555-5678', 'Los Angeles'),
(4, 'Medical', '0906-7534', 'Davao city');

-- --------------------------------------------------------

--
-- Table structure for table `vaccination_record`
--

CREATE TABLE `vaccination_record` (
  `Administer_ID` int(11) NOT NULL,
  `vaccine_ID` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `noadminister` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vaccination_record`
--

INSERT INTO `vaccination_record` (`Administer_ID`, `vaccine_ID`, `price`, `noadminister`) VALUES
(1, 1, 19.99, 1),
(2, 2, 14.50, 2);

-- --------------------------------------------------------

--
-- Table structure for table `vaccine`
--

CREATE TABLE `vaccine` (
  `vaccine_ID` int(11) NOT NULL,
  `vaccine_name` varchar(100) DEFAULT NULL,
  `opening_stock` int(11) DEFAULT NULL,
  `purchased` int(11) DEFAULT NULL,
  `total_stock` int(11) GENERATED ALWAYS AS (`opening_stock` + `purchased`) VIRTUAL,
  `dispensed` int(11) DEFAULT 0,
  `closing_stock` int(11) GENERATED ALWAYS AS (`total_stock` - `dispensed`) VIRTUAL,
  `order_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vaccine`
--

INSERT INTO `vaccine` (`vaccine_ID`, `vaccine_name`, `opening_stock`, `purchased`, `dispensed`, `order_date`) VALUES
(1, 'COVID-19 Vaccines', 500, 100, 40, '2025-02-21'),
(2, 'FluVac', 300, 10, 50, '2025-02-28');

-- --------------------------------------------------------

--
-- Table structure for table `vaccine_order`
--

CREATE TABLE `vaccine_order` (
  `order_ID` int(11) NOT NULL,
  `vaccine_ID` int(11) NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `quantity_ordered` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vaccine_order`
--

INSERT INTO `vaccine_order` (`order_ID`, `vaccine_ID`, `expiration_date`, `cost`, `subtotal`, `quantity_ordered`) VALUES
(1, 1, '2025-12-31', 19.99, 999.50, 50),
(2, 2, '2025-11-30', 14.50, 450.00, 30);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administer`
--
ALTER TABLE `administer`
  ADD PRIMARY KEY (`Administer_ID`),
  ADD KEY `doctor_ID` (`doctor_ID`),
  ADD KEY `assistant_ID` (`assistant_ID`),
  ADD KEY `administer_ibfk_3` (`patient_ID`);

--
-- Indexes for table `assistant`
--
ALTER TABLE `assistant`
  ADD PRIMARY KEY (`assistant_ID`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`doctor_ID`),
  ADD KEY `dr_License` (`dr_License`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_ID`),
  ADD KEY `doctor_ID` (`doctor_ID`),
  ADD KEY `assistant_ID` (`assistant_ID`),
  ADD KEY `supplier_ID` (`supplier_ID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_ID`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`Person_ID`),
  ADD UNIQUE KEY `dr_License` (`dr_License`);

--
-- Indexes for table `stock_out`
--
ALTER TABLE `stock_out`
  ADD PRIMARY KEY (`stockout_ID`),
  ADD KEY `vaccine_ID` (`vaccine_ID`),
  ADD KEY `doctor_ID` (`doctor_ID`),
  ADD KEY `assistant_ID` (`assistant_ID`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_ID`);

--
-- Indexes for table `vaccination_record`
--
ALTER TABLE `vaccination_record`
  ADD PRIMARY KEY (`Administer_ID`,`vaccine_ID`),
  ADD KEY `vaccine_ID` (`vaccine_ID`);

--
-- Indexes for table `vaccine`
--
ALTER TABLE `vaccine`
  ADD PRIMARY KEY (`vaccine_ID`);

--
-- Indexes for table `vaccine_order`
--
ALTER TABLE `vaccine_order`
  ADD PRIMARY KEY (`order_ID`,`vaccine_ID`),
  ADD KEY `vaccine_ID` (`vaccine_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administer`
--
ALTER TABLE `administer`
  MODIFY `Administer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `assistant`
--
ALTER TABLE `assistant`
  MODIFY `assistant_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `doctor_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `Person_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stock_out`
--
ALTER TABLE `stock_out`
  MODIFY `stockout_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplier_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vaccine`
--
ALTER TABLE `vaccine`
  MODIFY `vaccine_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administer`
--
ALTER TABLE `administer`
  ADD CONSTRAINT `administer_ibfk_1` FOREIGN KEY (`doctor_ID`) REFERENCES `doctor` (`doctor_ID`),
  ADD CONSTRAINT `administer_ibfk_2` FOREIGN KEY (`assistant_ID`) REFERENCES `assistant` (`assistant_ID`),
  ADD CONSTRAINT `administer_ibfk_3` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`patient_ID`);

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`dr_License`) REFERENCES `person` (`dr_License`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`doctor_ID`) REFERENCES `doctor` (`doctor_ID`),
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`assistant_ID`) REFERENCES `assistant` (`assistant_ID`),
  ADD CONSTRAINT `order_ibfk_3` FOREIGN KEY (`supplier_ID`) REFERENCES `supplier` (`supplier_ID`);

--
-- Constraints for table `stock_out`
--
ALTER TABLE `stock_out`
  ADD CONSTRAINT `stock_out_ibfk_1` FOREIGN KEY (`vaccine_ID`) REFERENCES `vaccine` (`vaccine_ID`),
  ADD CONSTRAINT `stock_out_ibfk_2` FOREIGN KEY (`doctor_ID`) REFERENCES `doctor` (`doctor_ID`),
  ADD CONSTRAINT `stock_out_ibfk_3` FOREIGN KEY (`assistant_ID`) REFERENCES `assistant` (`assistant_ID`);

--
-- Constraints for table `vaccination_record`
--
ALTER TABLE `vaccination_record`
  ADD CONSTRAINT `vaccination_record_ibfk_1` FOREIGN KEY (`Administer_ID`) REFERENCES `administer` (`Administer_ID`),
  ADD CONSTRAINT `vaccination_record_ibfk_2` FOREIGN KEY (`vaccine_ID`) REFERENCES `vaccine` (`vaccine_ID`);

--
-- Constraints for table `vaccine_order`
--
ALTER TABLE `vaccine_order`
  ADD CONSTRAINT `vaccine_order_ibfk_1` FOREIGN KEY (`order_ID`) REFERENCES `order` (`order_ID`),
  ADD CONSTRAINT `vaccine_order_ibfk_2` FOREIGN KEY (`vaccine_ID`) REFERENCES `vaccine` (`vaccine_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
