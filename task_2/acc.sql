-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Фев 27 2020 г., 22:51
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `acc`
--
CREATE DATABASE `acc` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `acc`;

-- --------------------------------------------------------

--
-- Структура таблицы `acc`
--

CREATE TABLE IF NOT EXISTS `acc` (
  `FName` tinytext NOT NULL,
  `LName` tinytext NOT NULL,
  `address` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `acc`
--

INSERT INTO `acc` (`FName`, `LName`, `address`) VALUES
('Alexander', 'Bobkov', 'LS'),
('Robert', 'Sokolkin', 'SF'),
('Viktor', 'Rudnitskin', 'SF'),
('Robert', 'Stankevichev', 'LV'),
('Nikolay', 'Belskin', 'LS'),
('Yury', 'Dmitriev', 'SF'),
('Abram', 'Litvin', 'LV'),
('Mark', 'Romanowskin', 'LV'),
('Nikolay', 'Chabanov', 'LS'),
('Yaroslav', 'Tarasov', 'LV'),
('Trofim', 'Chernov', 'SF'),
('Immanuil', 'Golubev', 'LV'),
('Fedor', 'Polskov', 'LS'),
('Yakov', 'Korsakov', 'LV'),
('Pyotr', 'Dolin', 'SF'),
('Makar', 'Chabanov', 'LS'),
('Yakov', 'Gurkin', 'LV'),
('Yaroslav', 'Burdin', 'SF'),
('Georgy', 'Novosadov', 'LS'),
('Taras', 'Dobrow', 'LV'),
('Anatoly', 'Kuznetsov', 'LV'),
('Peter', 'Polannov', 'LS'),
('Immanuil', 'Chabanov', 'LV'),
('Gleb', 'Minin', 'SF'),
('German', 'Savin', 'LV'),
('Stepan', 'Polanin', 'LS'),
('Vlad', 'Mishkin', 'LS'),
('Fedor', 'Kozlov', 'LV'),
('Mikhail', 'Gubin', 'LS'),
('Peter', 'Markowkin', 'SF'),
('Ilia', 'Minin', 'SF'),
('Maxim', 'Slutzkov', 'LV'),
('Yury', 'Kovalin', 'LS'),
('Fedor', 'Pozniakov', 'SF'),
('Robert', 'Sokolkin', 'LV'),
('Artyom', 'Shostakin', 'LS'),
('Sergei', 'Bobkov', 'SF'),
('Yegor', 'Chabanov', 'LV'),
('Evgeny', 'Mikulichev', 'LS'),
('Marat', 'Holubev', 'SF'),
('Trofim', 'Kravin', 'LV'),
('Arkady', 'Ivanov', 'LS'),
('Fedor', 'Lipovkin', 'LV'),
('Stepan', 'Dmitriev', 'LS'),
('Gavriil', 'Lazarov', 'SF');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
