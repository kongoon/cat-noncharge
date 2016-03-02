-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2016 at 02:10 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cat-noncharge`
--

-- --------------------------------------------------------

--
-- Table structure for table `authority`
--

CREATE TABLE IF NOT EXISTS `authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_authority_user1_idx` (`user_id`),
  KEY `fk_authority_employee1_idx` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `borrow`
--

CREATE TABLE IF NOT EXISTS `borrow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL COMMENT 'ผู้ยืม',
  `user_id` int(11) NOT NULL COMMENT 'ผู้ให้ยืม',
  `date_out` datetime NOT NULL COMMENT 'วันที่ยืม',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_borrow_person1_idx` (`person_id`),
  KEY `fk_borrow_user1_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `borrow_item`
--

CREATE TABLE IF NOT EXISTS `borrow_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `borrow_id` int(11) NOT NULL COMMENT 'การยืม',
  `sim_card_id` int(11) NOT NULL COMMENT 'Sim Card',
  `number_id` int(11) NOT NULL COMMENT 'หมายเลข',
  `date_return` datetime DEFAULT NULL COMMENT 'วันที่คืน',
  `user_id` int(11) DEFAULT NULL COMMENT 'ผู้รับคืน',
  `person_id` int(11) DEFAULT NULL COMMENT 'ผู้คืน',
  `limited_id` int(11) NOT NULL COMMENT 'วงเงิน',
  `borrow_type` enum('0','1') NOT NULL COMMENT 'การใช้งาน',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_borrow_item_borrow1_idx` (`borrow_id`),
  KEY `fk_borrow_item_sim_card1_idx` (`sim_card_id`),
  KEY `fk_borrow_item_number1_idx` (`number_id`),
  KEY `fk_borrow_item_person1_idx` (`person_id`),
  KEY `fk_borrow_item_user1_idx` (`user_id`),
  KEY `fk_borrow_item_limited1_idx` (`limited_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='รายละเอียดการยืม' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_company_id` int(11) NOT NULL COMMENT 'สายงาน',
  `name` varchar(100) NOT NULL COMMENT 'ฝ่าย',
  PRIMARY KEY (`id`),
  KEY `fk_department_line_company_idx` (`line_company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ฝ่าย' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_id` varchar(8) NOT NULL COMMENT 'รหัสพนักงาน',
  `section_id` int(11) NOT NULL COMMENT 'ส่วน',
  `person_id` int(11) NOT NULL COMMENT 'ข้อมูล',
  PRIMARY KEY (`id`),
  KEY `fk_employee_section1_idx` (`section_id`),
  KEY `fk_employee_person1_idx` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='พนักงาน' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `limited`
--

CREATE TABLE IF NOT EXISTS `limited` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `limited` int(5) NOT NULL,
  `group` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='วงเงิน' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `line_company`
--

CREATE TABLE IF NOT EXISTS `line_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'สายงาน',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='สายงาน' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `migration`
--

CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1456888604),
('m130524_201442_init', 1456888613);

-- --------------------------------------------------------

--
-- Table structure for table `number`
--

CREATE TABLE IF NOT EXISTS `number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) NOT NULL COMMENT 'ภาค',
  `number` varchar(45) NOT NULL COMMENT 'เบอร์โทร',
  `owner` enum('1','2') NOT NULL COMMENT 'ความเป็นเจ้าของ',
  `status` enum('0','1','2') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_number_zone1_idx` (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL COMMENT 'ชื่อ',
  `lastname` varchar(100) NOT NULL COMMENT 'นามสกุล',
  `citizen_id` varchar(13) NOT NULL COMMENT 'หมายเลขบัตรประชาชน',
  `address` text NOT NULL COMMENT 'ที่อยู่',
  `tel` varchar(45) NOT NULL COMMENT 'โทรศัพท์',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='บุคคล' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE IF NOT EXISTS `section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL COMMENT 'ฝ่าย',
  `name` varchar(100) NOT NULL COMMENT 'ส่วน',
  PRIMARY KEY (`id`),
  KEY `fk_section_department1_idx` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ส่วน' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sim_card`
--

CREATE TABLE IF NOT EXISTS `sim_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iccid` varchar(19) NOT NULL,
  `sim_size_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sim_card_sim_size1_idx` (`sim_size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sim_size`
--

CREATE TABLE IF NOT EXISTS `sim_size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sim_size` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `zone`
--

CREATE TABLE IF NOT EXISTS `zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT 'ภาค',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authority`
--
ALTER TABLE `authority`
  ADD CONSTRAINT `fk_authority_employee1` FOREIGN KEY (`employee_id`) REFERENCES `cat-noncharge`.`employee` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_authority_user1` FOREIGN KEY (`user_id`) REFERENCES `cat-noncharge`.`user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `borrow`
--
ALTER TABLE `borrow`
  ADD CONSTRAINT `fk_borrow_person1` FOREIGN KEY (`person_id`) REFERENCES `cat-noncharge`.`person` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_user1` FOREIGN KEY (`user_id`) REFERENCES `cat-noncharge`.`user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `borrow_item`
--
ALTER TABLE `borrow_item`
  ADD CONSTRAINT `fk_borrow_item_borrow1` FOREIGN KEY (`borrow_id`) REFERENCES `cat-noncharge`.`borrow` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_limited1` FOREIGN KEY (`limited_id`) REFERENCES `cat-noncharge`.`limited` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_number1` FOREIGN KEY (`number_id`) REFERENCES `cat-noncharge`.`number` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_person1` FOREIGN KEY (`person_id`) REFERENCES `cat-noncharge`.`person` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_sim_card1` FOREIGN KEY (`sim_card_id`) REFERENCES `cat-noncharge`.`sim_card` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_user1` FOREIGN KEY (`user_id`) REFERENCES `cat-noncharge`.`user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `fk_department_line_company` FOREIGN KEY (`line_company_id`) REFERENCES `cat-noncharge`.`line_company` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `fk_employee_person1` FOREIGN KEY (`person_id`) REFERENCES `cat-noncharge`.`person` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_employee_section1` FOREIGN KEY (`section_id`) REFERENCES `cat-noncharge`.`section` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `number`
--
ALTER TABLE `number`
  ADD CONSTRAINT `fk_number_zone1` FOREIGN KEY (`zone_id`) REFERENCES `cat-noncharge`.`zone` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `fk_section_department1` FOREIGN KEY (`department_id`) REFERENCES `cat-noncharge`.`department` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `sim_card`
--
ALTER TABLE `sim_card`
  ADD CONSTRAINT `fk_sim_card_sim_size1` FOREIGN KEY (`sim_size_id`) REFERENCES `cat-noncharge`.`sim_size` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
