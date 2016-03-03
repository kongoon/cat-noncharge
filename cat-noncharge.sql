-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2016 at 09:36 AM
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
-- Table structure for table `auth_assignment`
--

CREATE TABLE IF NOT EXISTS `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_item`
--

CREATE TABLE IF NOT EXISTS `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_item_child`
--

CREATE TABLE IF NOT EXISTS `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_rule`
--

CREATE TABLE IF NOT EXISTS `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `borrow`
--

CREATE TABLE IF NOT EXISTS `borrow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL COMMENT 'ผู้ยืม',
  `user_id` int(11) NOT NULL COMMENT 'ผู้ให้ยืม',
  `date_out` datetime NOT NULL COMMENT 'วันที่ยืม',
  `start_date` date DEFAULT NULL COMMENT 'วันเริ่มต้น',
  `end_date` date DEFAULT NULL COMMENT 'วันกำหนดส่งคืน',
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
  `number_sim_id` int(11) NOT NULL,
  `date_return` datetime DEFAULT NULL COMMENT 'วันที่คืน',
  `user_id` int(11) DEFAULT NULL COMMENT 'ผู้รับคืน',
  `person_id` int(11) DEFAULT NULL COMMENT 'ผู้คืน',
  `limited_id` int(11) NOT NULL COMMENT 'วงเงิน',
  `borrow_type` enum('0','1') NOT NULL COMMENT 'การใช้งาน',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_borrow_item_borrow1_idx` (`borrow_id`),
  KEY `fk_borrow_item_person1_idx` (`person_id`),
  KEY `fk_borrow_item_user1_idx` (`user_id`),
  KEY `fk_borrow_item_limited1_idx` (`limited_id`),
  KEY `fk_borrow_item_number_sim1_idx` (`number_sim_id`)
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
('m130524_201442_init', 1456888613),
('m140209_132017_init', 1456909877),
('m140403_174025_create_account_table', 1456909881),
('m140504_113157_update_tables', 1456909905),
('m140504_130429_create_token_table', 1456909911),
('m140506_102106_rbac_init', 1456912644),
('m140830_171933_fix_ip_field', 1456909914),
('m140830_172703_change_account_table_name', 1456909915),
('m141222_110026_update_ip_field', 1456909918),
('m141222_135246_alter_username_length', 1456909972),
('m150614_103145_update_social_account_table', 1456909979),
('m150623_212711_fix_username_notnull', 1456910128);

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
-- Table structure for table `number_sim`
--

CREATE TABLE IF NOT EXISTS `number_sim` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_id` int(11) NOT NULL,
  `sim_card_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_number_sim_number1_idx` (`number_id`),
  KEY `fk_number_sim_sim_card1_idx` (`sim_card_id`)
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
-- Table structure for table `profile`
--

CREATE TABLE IF NOT EXISTS `profile` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `public_email` varchar(255) DEFAULT NULL,
  `gravatar_email` varchar(255) DEFAULT NULL,
  `gravatar_id` varchar(32) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `bio` text,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`user_id`, `name`, `public_email`, `gravatar_email`, `gravatar_id`, `location`, `website`, `bio`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
-- Table structure for table `social_account`
--

CREATE TABLE IF NOT EXISTS `social_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `provider` varchar(150) NOT NULL,
  `client_id` varchar(150) NOT NULL,
  `data` text,
  `code` varchar(32) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_unique` (`provider`,`client_id`),
  UNIQUE KEY `account_unique_code` (`code`),
  KEY `fk_user_account` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE IF NOT EXISTS `token` (
  `user_id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `created_at` int(11) NOT NULL,
  `type` smallint(6) NOT NULL,
  UNIQUE KEY `token_unique` (`user_id`,`code`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`user_id`, `code`, `created_at`, `type`) VALUES
(1, 'GQCKtoGJUS_PkHbpnu0X9aASFPL0oOSI', 1456913177, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password_hash` varchar(60) NOT NULL,
  `auth_key` varchar(32) NOT NULL,
  `email` varchar(150) NOT NULL,
  `confirmed_at` int(11) DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `blocked_at` int(11) DEFAULT NULL,
  `registration_ip` varchar(45) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_unique_email` (`email`),
  UNIQUE KEY `user_unique_username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password_hash`, `auth_key`, `email`, `confirmed_at`, `unconfirmed_email`, `blocked_at`, `registration_ip`, `created_at`, `updated_at`, `flags`) VALUES
(1, 'admin', '$2y$10$/P9SDjebBe1xEzfSngx9L.YZbvPyydlkg0RQ4Pm9d0IbuJqgA1jg.', 'dc1xDF_m-ZiUKeGXCEgKaNkraPmuDtlx', 'admin@admin.com', 1456913177, NULL, NULL, '::1', 1456913177, 1456913177, 0);

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
-- Constraints for table `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `fk_borrow_item_person1` FOREIGN KEY (`person_id`) REFERENCES `cat-noncharge`.`person` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_user1` FOREIGN KEY (`user_id`) REFERENCES `cat-noncharge`.`user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_number_sim1` FOREIGN KEY (`number_sim_id`) REFERENCES `cat-noncharge`.`number_sim` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
-- Constraints for table `number_sim`
--
ALTER TABLE `number_sim`
  ADD CONSTRAINT `fk_number_sim_number1` FOREIGN KEY (`number_id`) REFERENCES `cat-noncharge`.`number` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_number_sim_sim_card1` FOREIGN KEY (`sim_card_id`) REFERENCES `cat-noncharge`.`sim_card` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `profile`
--
ALTER TABLE `profile`
  ADD CONSTRAINT `fk_user_profile` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

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

--
-- Constraints for table `social_account`
--
ALTER TABLE `social_account`
  ADD CONSTRAINT `fk_user_account` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `fk_user_token` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
