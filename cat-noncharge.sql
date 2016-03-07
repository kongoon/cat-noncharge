-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 07, 2016 at 01:53 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `authority`
--

INSERT INTO `authority` (`id`, `user_id`, `employee_id`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4);

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

--
-- Dumping data for table `auth_assignment`
--

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`) VALUES
('admin', '1', 1457074654),
('borrow_admin', '3', 1457075319),
('user', '2', 1457075329);

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

--
-- Dumping data for table `auth_item`
--

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`) VALUES
('/borrow/borrow/*', 2, NULL, NULL, NULL, 1457055620, 1457055620),
('/borrow/borrow/create', 2, NULL, NULL, NULL, 1457055642, 1457055642),
('/borrow/borrow/delete', 2, NULL, NULL, NULL, 1457056256, 1457056256),
('/borrow/borrow/index', 2, NULL, NULL, NULL, 1457055642, 1457055642),
('/borrow/borrow/pdf', 2, NULL, NULL, NULL, 1457056260, 1457056260),
('/borrow/borrow/update', 2, NULL, NULL, NULL, 1457056256, 1457056256),
('/borrow/borrow/view', 2, NULL, NULL, NULL, 1457055642, 1457055642),
('/borrow/report/*', 2, NULL, NULL, NULL, 1457055650, 1457055650),
('/borrow/report/index', 2, NULL, NULL, NULL, 1457055620, 1457055620),
('/borrow/report/report1', 2, NULL, NULL, NULL, 1457055649, 1457055649),
('/borrow/report/report2', 2, NULL, NULL, NULL, 1457055650, 1457055650),
('admin', 1, 'ผู้ดูแลระบบ', NULL, NULL, 1457055692, 1457055692),
('borrow_admin', 1, 'เจ้าหน้าที่บริหารจัดการการยืมหมายเลข', NULL, NULL, 1457075055, 1457075055),
('borrowAdmin', 2, 'บริหารจัดการการยืมหมายเลข', NULL, NULL, 1457075094, 1457075213),
('borrowReport', 2, 'ดูรายงานการยืมหมายเลข', NULL, NULL, 1457075141, 1457075141),
('borrowView', 2, 'ดูรายการยืมหมายเลข', NULL, NULL, 1457074532, 1457075180),
('user', 1, 'เจ้าหน้าที่ทั่วไป', NULL, NULL, 1457075025, 1457075025);

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

--
-- Dumping data for table `auth_item_child`
--

INSERT INTO `auth_item_child` (`parent`, `child`) VALUES
('borrowAdmin', '/borrow/borrow/*'),
('borrowView', '/borrow/borrow/index'),
('borrowView', '/borrow/borrow/view'),
('borrowAdmin', '/borrow/report/*'),
('borrowReport', '/borrow/report/*'),
('borrow_admin', 'borrowAdmin'),
('admin', 'borrowReport'),
('admin', 'borrowView'),
('user', 'borrowView');

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

--
-- Dumping data for table `auth_rule`
--

INSERT INTO `auth_rule` (`name`, `data`, `created_at`, `updated_at`) VALUES
('isOwn', 'O:27:"common\\components\\UpdateOwn":3:{s:4:"name";s:5:"isOwn";s:9:"createdAt";i:1457056069;s:9:"updatedAt";i:1457056132;}', 1457056069, 1457056132);

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
  `file1` varchar(150) DEFAULT NULL COMMENT 'หนังสืออนุญาต',
  `file2` varchar(150) DEFAULT NULL COMMENT 'หนังสือยืม',
  `file3` varchar(150) DEFAULT NULL COMMENT 'หนังสือคืน',
  `person_recieve_id` int(11) DEFAULT NULL COMMENT 'ผู้รับ',
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_borrow_person1_idx` (`person_id`),
  KEY `fk_borrow_user1_idx` (`user_id`),
  KEY `fk_borrow_person2_idx` (`person_recieve_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `borrow`
--

INSERT INTO `borrow` (`id`, `person_id`, `user_id`, `date_out`, `start_date`, `end_date`, `file1`, `file2`, `file3`, `person_recieve_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2016-03-03 00:00:00', '2016-03-03', '2016-03-30', NULL, NULL, NULL, NULL, 0, 1456985703),
(2, 1, 1, '2016-03-03 00:00:00', '2016-03-03', '2016-03-30', NULL, NULL, NULL, NULL, 0, 0),
(3, 2, 1, '2016-03-03 00:00:00', '2016-03-03', '2016-03-03', 'f68c15024a876460feaff0b8c1544f20.pdf', 'f68c15024a876460feaff0b8c1544f20.pdf', NULL, NULL, 0, 1456994178),
(4, 1, 1, '2016-03-03 00:00:00', '2016-03-01', '2016-03-02', NULL, NULL, NULL, NULL, 0, 0),
(5, 1, 1, '2016-03-03 00:00:00', '2016-03-03', '2016-03-03', NULL, NULL, NULL, NULL, 0, 0);

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
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_borrow_item_borrow1_idx` (`borrow_id`),
  KEY `fk_borrow_item_person1_idx` (`person_id`),
  KEY `fk_borrow_item_user1_idx` (`user_id`),
  KEY `fk_borrow_item_limited1_idx` (`limited_id`),
  KEY `fk_borrow_item_number_sim1_idx` (`number_sim_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='รายละเอียดการยืม' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `borrow_item`
--

INSERT INTO `borrow_item` (`id`, `borrow_id`, `number_sim_id`, `date_return`, `user_id`, `person_id`, `limited_id`, `borrow_type`, `created_at`, `updated_at`) VALUES
(2, 2, 1, NULL, NULL, NULL, 1, '0', 0, 0),
(3, 3, 1, NULL, NULL, NULL, 1, '0', 0, 0),
(4, 4, 1, NULL, NULL, NULL, 1, '0', 0, 0),
(5, 5, 3, NULL, NULL, NULL, 1, '0', 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='ฝ่าย' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `line_company_id`, `name`) VALUES
(5, 1, 'วางแผน');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='พนักงาน' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `emp_id`, `section_id`, `person_id`) VALUES
(2, '100001', 1, 1),
(3, '1234', 1, 3),
(4, '6547', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `limited`
--

CREATE TABLE IF NOT EXISTS `limited` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `limited` int(5) NOT NULL,
  `group` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='วงเงิน' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `limited`
--

INSERT INTO `limited` (`id`, `limited`, `group`) VALUES
(1, 500, 'A'),
(2, 1000, 'B');

-- --------------------------------------------------------

--
-- Table structure for table `line_company`
--

CREATE TABLE IF NOT EXISTS `line_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'สายงาน',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='สายงาน' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `line_company`
--

INSERT INTO `line_company` (`id`, `name`) VALUES
(1, 'ไร้สาย'),
(2, 'การเงิน');

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
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_number_zone1_idx` (`zone_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `number`
--

INSERT INTO `number` (`id`, `zone_id`, `number`, `owner`, `status`) VALUES
(3, 2, '0123456789', '1', 1),
(4, 2, '0123456788', '1', 1),
(5, 4, '32154654', '2', 1),
(6, 5, '6546548', '2', 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `number_sim`
--

INSERT INTO `number_sim` (`id`, `number_id`, `sim_card_id`) VALUES
(1, 3, 1),
(2, 4, 2),
(3, 5, 3),
(4, 6, 4);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL COMMENT 'ชื่อ',
  `lastname` varchar(100) NOT NULL COMMENT 'นามสกุล',
  `photo` varchar(100) DEFAULT 'nopic.jpg',
  `citizen_id` varchar(13) NOT NULL COMMENT 'หมายเลขบัตรประชาชน',
  `address` text NOT NULL COMMENT 'ที่อยู่',
  `tel` varchar(45) NOT NULL COMMENT 'โทรศัพท์',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='บุคคล' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`id`, `firstname`, `lastname`, `photo`, `citizen_id`, `address`, `tel`) VALUES
(1, 'ทดสอบ', 'ทดสอบ', 'nopic.jpg', '1234567891011', 'address', ''),
(2, 'ทดสอบ2', 'ทดสอบ2', 'nopic.jpg', '1234567891012', 'address', ''),
(3, 'Test', 'Test', 'nopic.jpg', '', '', ''),
(4, 'Demo', 'Demo', 'nopic.jpg', '', '', '');

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
(1, 'ทดสอบ นามสกุล', '', '', 'd41d8cd98f00b204e9800998ecf8427e', '', '', ''),
(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='ส่วน' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`id`, `department_id`, `name`) VALUES
(1, 5, 'ไอที');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `sim_card`
--

INSERT INTO `sim_card` (`id`, `iccid`, `sim_size_id`) VALUES
(1, '123456789', 1),
(2, '32156468', 2),
(3, '65454', 2),
(4, '484945', 3);

-- --------------------------------------------------------

--
-- Table structure for table `sim_size`
--

CREATE TABLE IF NOT EXISTS `sim_size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sim_size` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `sim_size`
--

INSERT INTO `sim_size` (`id`, `sim_size`) VALUES
(1, 'Standard Sim'),
(2, 'Micro Sim'),
(3, 'Nano Sim');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password_hash`, `auth_key`, `email`, `confirmed_at`, `unconfirmed_email`, `blocked_at`, `registration_ip`, `created_at`, `updated_at`, `flags`) VALUES
(1, 'admin', '$2y$10$/P9SDjebBe1xEzfSngx9L.YZbvPyydlkg0RQ4Pm9d0IbuJqgA1jg.', 'dc1xDF_m-ZiUKeGXCEgKaNkraPmuDtlx', 'admin@admin.com', 1456913177, NULL, NULL, '::1', 1456913177, 1456913177, 0),
(2, 'test', '$2y$12$DAvShsZq6O4xba2FPJQiM.ns6oE9p0BzEXCNjX9sQW73RTUQlH7im', 'AjnPnSz_D3dZbq19CdjO2Cym8zWazIwr', 'test@test.com', 1457074970, NULL, NULL, '::1', 1457074970, 1457074970, 0),
(3, 'demo', '$2y$12$3zCdJipehr5QH.qZy8wj7OvMs5mlEPjfcf7qZMYAhP3RcZtZuq1Um', 'L9lw-FeJd14G9781zdyEtCLBgxQPMPVf', 'demo@demo.com', 1457074984, NULL, NULL, '::1', 1457074984, 1457074984, 0);

-- --------------------------------------------------------

--
-- Table structure for table `zone`
--

CREATE TABLE IF NOT EXISTS `zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT 'ภาค',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `zone`
--

INSERT INTO `zone` (`id`, `name`) VALUES
(1, 'เหนือ'),
(2, 'กลาง'),
(3, 'อีสาน'),
(4, 'ใต้'),
(5, 'ตะวันออก'),
(6, 'ตะวันตก');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authority`
--
ALTER TABLE `authority`
  ADD CONSTRAINT `fk_authority_employee1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_authority_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_borrow_person1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_person2` FOREIGN KEY (`person_recieve_id`) REFERENCES `cat-noncharge`.`person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `borrow_item`
--
ALTER TABLE `borrow_item`
  ADD CONSTRAINT `fk_borrow_item_borrow1` FOREIGN KEY (`borrow_id`) REFERENCES `borrow` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_limited1` FOREIGN KEY (`limited_id`) REFERENCES `limited` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_number_sim1` FOREIGN KEY (`number_sim_id`) REFERENCES `number_sim` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_person1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_borrow_item_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `fk_department_line_company` FOREIGN KEY (`line_company_id`) REFERENCES `line_company` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `fk_employee_person1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_employee_section1` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `number`
--
ALTER TABLE `number`
  ADD CONSTRAINT `fk_number_zone1` FOREIGN KEY (`zone_id`) REFERENCES `zone` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `number_sim`
--
ALTER TABLE `number_sim`
  ADD CONSTRAINT `fk_number_sim_number1` FOREIGN KEY (`number_id`) REFERENCES `number` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_number_sim_sim_card1` FOREIGN KEY (`sim_card_id`) REFERENCES `sim_card` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `profile`
--
ALTER TABLE `profile`
  ADD CONSTRAINT `fk_user_profile` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `fk_section_department1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `sim_card`
--
ALTER TABLE `sim_card`
  ADD CONSTRAINT `fk_sim_card_sim_size1` FOREIGN KEY (`sim_size_id`) REFERENCES `sim_size` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
