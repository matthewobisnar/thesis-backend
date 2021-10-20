-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 20, 2021 at 10:12 PM
-- Server version: 8.0.26-0ubuntu0.20.04.3
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elspintor_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int UNSIGNED NOT NULL,
  `customer_first_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `customer_last_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `customer_mobile_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `customer_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `customer_inquiry_details` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `customer_status` tinyint(1) NOT NULL DEFAULT '0',
  `customer_created_at` timestamp NULL DEFAULT NULL,
  `customer_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_first_name`, `customer_last_name`, `customer_mobile_number`, `customer_email`, `customer_inquiry_details`, `customer_status`, `customer_created_at`, `customer_updated_at`) VALUES
(3, 'marki', 'king', '09123456789', 'mark@email.com', 'sample text', 2, '2021-10-16 09:37:14', '2021-10-19 11:53:38'),
(4, 'John', 'depp', '091234567891', 'john@email.com', 'sample text', 1, '2021-10-16 09:37:48', '2021-10-19 11:53:46'),
(8, 'John2', 'depp2', '091234567891', 'john@email.com', 'sample text', 2, '2021-10-16 09:37:48', '2021-10-19 08:16:26'),
(15, 'marki', 'king', '09123456789', 'mark@email.com', 'sample text', 2, '2021-10-16 09:37:14', '2021-10-19 11:53:40'),
(16, 'John', 'depp', '091234567891', 'john@email.com', 'sample text', 2, '2021-10-16 09:37:48', '2021-10-20 07:54:03'),
(19, 'John2', 'depp2', '091234567891', 'john@email.com', 'sample text', 2, '2021-10-16 09:37:48', '2021-10-20 13:51:54');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int UNSIGNED NOT NULL,
  `emp_first_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `emp_last_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `emp_mobile_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `emp_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `emp_status` tinyint(1) NOT NULL DEFAULT '0',
  `emp_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `emp_updated_at` timestamp NULL DEFAULT NULL,
  `emp_last_joined` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `emp_first_name`, `emp_last_name`, `emp_mobile_number`, `emp_email`, `emp_status`, `emp_created_at`, `emp_updated_at`, `emp_last_joined`) VALUES
(14, 'matthew ', 'bisnar', '9452567866', 'matthew@gmail.com', 1, '2021-10-20 10:26:25', '2021-10-20 14:06:09', NULL),
(15, 'louki', 'compton', '9959522576', 'louki@email.com', 1, '2021-10-20 11:08:39', '2021-10-20 11:11:17', NULL),
(16, 'mike ', 'tasse', '9067722502', 'mike@gmail.com', 0, '2021-10-20 14:01:28', '2021-10-20 14:11:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `message_id` int UNSIGNED NOT NULL,
  `message_content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `message_is_sent` tinyint(1) NOT NULL DEFAULT '0',
  `message_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`message_id`, `message_content`, `message_is_sent`, `message_created_at`) VALUES
(1, 'Hello World', 0, '2021-10-17 02:50:37'),
(2, 'Hello There.', 0, '2021-10-20 12:48:25');

-- --------------------------------------------------------

--
-- Table structure for table `opt_in`
--

CREATE TABLE `opt_in` (
  `opt_in_id` int UNSIGNED NOT NULL,
  `opt_in_mobile_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `opt_in_token` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `opt_in_status` tinyint(1) NOT NULL DEFAULT '0',
  `opt_in_is_sent` tinyint(1) NOT NULL DEFAULT '0',
  `opt_in_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `opt_in_updated_at` timestamp NULL DEFAULT NULL,
  `opt_out_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `opt_in`
--

INSERT INTO `opt_in` (`opt_in_id`, `opt_in_mobile_number`, `opt_in_token`, `opt_in_status`, `opt_in_is_sent`, `opt_in_created_at`, `opt_in_updated_at`, `opt_out_at`) VALUES
(4, '9452567866', 'hXSPzkNZ3PGrl1CPyLDsb4rKMche8yR0Tdq_bL6Yujs', 0, 0, '2021-10-20 11:00:58', NULL, NULL),
(5, '9959522576', 'VNxMX22H2GwwQ9LYbUoBp69KGMSS_tC4HQZJx8Dn1zA', 0, 0, '2021-10-20 11:11:17', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int UNSIGNED NOT NULL,
  `product_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `product_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `product_imageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `product_imageData` mediumblob NOT NULL,
  `product_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sent_message`
--

CREATE TABLE `sent_message` (
  `sent_message_id` int UNSIGNED NOT NULL,
  `sent_message_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sent_message_mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sent_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sent_message`
--

INSERT INTO `sent_message` (`sent_message_id`, `sent_message_message`, `sent_message_mobile`, `sent_created_at`) VALUES
(17, '2', '9452567866', '2021-10-20 12:48:25'),
(18, '2', '9959522576', '2021-10-20 12:48:26');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int UNSIGNED NOT NULL,
  `service_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `service_description` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `service_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `service_imageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `service_imageData` mediumblob NOT NULL,
  `service_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `service_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `todo`
--

CREATE TABLE `todo` (
  `todo_id` int UNSIGNED NOT NULL,
  `todo_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `todo_description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `todo_status` tinyint(1) NOT NULL DEFAULT '0',
  `todo_deadline` timestamp NULL DEFAULT NULL,
  `todo_created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `todo_updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `todo`
--

INSERT INTO `todo` (`todo_id`, `todo_title`, `todo_description`, `todo_status`, `todo_deadline`, `todo_created_at`, `todo_updated_at`) VALUES
(39, 'dfsdf', 'sfsdf', 0, '2021-10-06 16:00:00', '2021-10-20 10:46:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `token_id` int NOT NULL,
  `token_user_id` int NOT NULL,
  `token_token` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token_created_at` datetime DEFAULT NULL,
  `token_updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`token_id`, `token_user_id`, `token_token`, `token_created_at`, `token_updated_at`) VALUES
(1, 1, 'dMnZmQJuLzoVdPWIpAn0hAY78XZ3Ksw55sKmEZIpr9ZysYbiuZ9xtME8tCvF2JgV6JUXf3pF6XRjCniLU9GMFxq3HO7wVJDZVJhP4QM9pjr64Q7oFUVYkUahhpGdJHNUHzukU4X97qNPvVOeyuOxIpvVIn710GkJvWsHxxKvz9tE60qTm4k9jqOSB8CP7ld9pJaVGKfwk16lzNDNkfGplhmjGEJMdQgNcrmHPCO6lI677F8HoNHar3QLMmXw7zc', '2021-10-16 20:40:57', '2021-10-20 16:04:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `user_username` varchar(255) NOT NULL,
  `user_password` text NOT NULL,
  `user_created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_updated_at` datetime DEFAULT NULL,
  `user_deleted_at` datetime DEFAULT NULL,
  `user_status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_username`, `user_password`, `user_created_at`, `user_updated_at`, `user_deleted_at`, `user_status`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', '2021-10-16 19:48:25', NULL, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `opt_in`
--
ALTER TABLE `opt_in`
  ADD PRIMARY KEY (`opt_in_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `sent_message`
--
ALTER TABLE `sent_message`
  ADD PRIMARY KEY (`sent_message_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `todo`
--
ALTER TABLE `todo`
  ADD PRIMARY KEY (`todo_id`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`token_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `opt_in`
--
ALTER TABLE `opt_in`
  MODIFY `opt_in_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sent_message`
--
ALTER TABLE `sent_message`
  MODIFY `sent_message_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `todo`
--
ALTER TABLE `todo`
  MODIFY `todo_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `token_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
