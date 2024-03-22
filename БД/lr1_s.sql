-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 22 2024 г., 11:43
-- Версия сервера: 8.0.29
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `lr1_s`
--

-- --------------------------------------------------------

--
-- Структура таблицы `chart`
--

CREATE TABLE `chart` (
  `id` int NOT NULL,
  `day_week` varchar(20) NOT NULL,
  `id_employee` int NOT NULL,
  `working_hours` int NOT NULL,
  `start` time NOT NULL,
  `end` time NOT NULL,
  `date_of_admission` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `chart`
--

INSERT INTO `chart` (`id`, `day_week`, `id_employee`, `working_hours`, `start`, `end`, `date_of_admission`) VALUES
(16, 'Понедельник', 6, 8, '09:00:00', '17:00:00', '2024-02-10'),
(17, 'Вторник', 7, 7, '10:00:00', '17:00:00', '2024-02-11'),
(18, 'Среда', 8, 6, '11:00:00', '17:00:00', '2024-02-12'),
(19, 'Четверг', 9, 8, '09:30:00', '17:30:00', '2024-02-13'),
(20, 'Пятница', 10, 7, '10:30:00', '16:30:00', '2024-02-14');

-- --------------------------------------------------------

--
-- Структура таблицы `customer`
--

CREATE TABLE `customer` (
  `id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `passport` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `customer`
--

INSERT INTO `customer` (`id`, `name`, `lastname`, `passport`) VALUES
(1, 'Клиент1', 'Фамилия1', 123789),
(2, 'Клиент2', 'Фамилия2', 456789),
(3, 'Клиент3', 'Фамилия3', 789123),
(4, 'Клиент4', 'Фамилия4', 987123),
(5, 'Клиент5', 'Фамилия5', 654987);

-- --------------------------------------------------------

--
-- Структура таблицы `employee`
--

CREATE TABLE `employee` (
  `id` int NOT NULL,
  `name` varchar(35) NOT NULL,
  `lastname` varchar(35) NOT NULL,
  `cardnumber` int NOT NULL,
  `passport` int NOT NULL,
  `id_position` int NOT NULL,
  `snils` int NOT NULL,
  `id_workstation` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `employee`
--

INSERT INTO `employee` (`id`, `name`, `lastname`, `cardnumber`, `passport`, `id_position`, `snils`, `id_workstation`) VALUES
(6, 'Иван', 'Иванов', 123456, 789012, 1, 123456789, 1),
(7, 'Анна', 'Петрова', 654321, 987654, 2, 987654321, 2),
(8, 'Сергей', 'Сидоров', 789012, 123456, 3, 111222333, 3),
(9, 'Елена', 'Козлова', 987654, 456789, 1, 222333444, 1),
(10, 'Павел', 'Смирнов', 456789, 789123, 2, 333444555, 2),
(13, 'Елена', 'Соколова', 44556, 1111111111, 4, 123432111, 4),
(14, 'Олег', 'Морозович', 77889, 999999111, 5, 111222332, 5),
(15, 'АААА', 'ааaaaa', 654654, 42115, 4, 123111, 1);

--
-- Триггеры `employee`
--
DELIMITER $$
CREATE TRIGGER `employee_delete_trg` AFTER DELETE ON `employee` FOR EACH ROW BEGIN
  INSERT INTO employee_audit (employee_id, action, action_time)
    VALUES (OLD.id, 'delete', NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `employee_insert_trg` AFTER INSERT ON `employee` FOR EACH ROW BEGIN
 INSERT INTO employee_audit (employee_id,  action, action_time)
VALUES (NEW.id, 'insert', NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `employee_update_trg` AFTER UPDATE ON `employee` FOR EACH ROW BEGIN
INSERT INTO employee_audit (employee_id, action, action_time)
VALUES (OLD.id, 'update', NOW() );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `employee_audit`
--

CREATE TABLE `employee_audit` (
  `id` int NOT NULL,
  `employee_id` int NOT NULL,
  `action` varchar(200) NOT NULL,
  `action_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `employee_audit`
--

INSERT INTO `employee_audit` (`id`, `employee_id`, `action`, `action_time`) VALUES
(1, 0, 'update', '2024-03-22 11:14:42'),
(2, 0, 'insert', '2024-03-22 11:11:23'),
(3, 15, 'update', '2024-03-22 11:16:35'),
(4, 17, 'insert', '2024-03-22 11:17:07'),
(5, 17, 'delete', '2024-03-22 11:17:12');

-- --------------------------------------------------------

--
-- Структура таблицы `execution_of_work`
--

CREATE TABLE `execution_of_work` (
  `id_project` int NOT NULL,
  `execution_stage` varchar(35) NOT NULL,
  `stage_tem` varchar(10) NOT NULL,
  `id_employee` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `execution_of_work`
--

INSERT INTO `execution_of_work` (`id_project`, `execution_stage`, `stage_tem`, `id_employee`) VALUES
(1, 'Анализ', 'Тест1', 6),
(2, 'Разработка', 'Тест2', 7),
(3, 'Тестирование', 'Тест3', 8),
(4, 'Дизайн', 'Тест4', 9),
(5, 'Сопровождение', 'Тест5', 10);

-- --------------------------------------------------------

--
-- Структура таблицы `position`
--

CREATE TABLE `position` (
  `id` int NOT NULL,
  `name` varchar(35) NOT NULL,
  `salary_amount` decimal(8,2) NOT NULL,
  `accrual_date_salary` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `position`
--

INSERT INTO `position` (`id`, `name`, `salary_amount`, `accrual_date_salary`) VALUES
(1, 'Разработчик', '60000.00', '2024-02-09'),
(2, 'Менеджер', '70000.00', '2024-02-09'),
(3, 'Тестировщик', '55000.00', '2024-02-09'),
(4, 'Аналитик', '65000.00', '2024-02-09'),
(5, 'Дизайнер', '60000.00', '2024-02-09');

-- --------------------------------------------------------

--
-- Структура таблицы `reception`
--

CREATE TABLE `reception` (
  `id` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `id_customer` int NOT NULL,
  `id_manager` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `reception`
--

INSERT INTO `reception` (`id`, `date`, `time`, `id_customer`, `id_manager`) VALUES
(1, '2024-02-10', '10:00:00', 1, 1),
(2, '2024-02-11', '11:30:00', 2, 2),
(3, '2024-02-12', '14:00:00', 3, 3),
(4, '2024-02-13', '09:30:00', 4, 4),
(5, '2024-02-14', '16:00:00', 5, 5);

-- --------------------------------------------------------

--
-- Структура таблицы `service_agreement`
--

CREATE TABLE `service_agreement` (
  `id` int NOT NULL,
  `id_customer` int NOT NULL,
  `id_manager` int NOT NULL,
  `date` date NOT NULL,
  `price` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `service_agreement`
--

INSERT INTO `service_agreement` (`id`, `id_customer`, `id_manager`, `date`, `price`) VALUES
(1, 1, 7, '2024-02-10', '15000.00'),
(2, 2, 7, '2024-02-11', '20000.00'),
(3, 3, 7, '2024-02-12', '18000.00'),
(4, 4, 7, '2024-02-13', '22000.00'),
(5, 5, 7, '2024-02-14', '25000.00');

-- --------------------------------------------------------

--
-- Структура таблицы `website_project`
--

CREATE TABLE `website_project` (
  `id` int NOT NULL,
  `id_manager` int NOT NULL,
  `id_customer` int NOT NULL,
  `name` varchar(35) NOT NULL,
  `id_contract` int NOT NULL,
  `decription` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `website_project`
--

INSERT INTO `website_project` (`id`, `id_manager`, `id_customer`, `name`, `id_contract`, `decription`) VALUES
(1, 1, 1, 'Проект1', 101, 'Описание1'),
(2, 2, 2, 'Проект2', 102, 'Описание2'),
(3, 3, 3, 'Проект3', 103, 'Описание3'),
(4, 1, 4, 'Проект4', 104, 'Описание4'),
(5, 2, 5, 'Проект5', 105, 'Описание5');

-- --------------------------------------------------------

--
-- Структура таблицы `workstation`
--

CREATE TABLE `workstation` (
  `id` int NOT NULL,
  `type_workstation` varchar(35) NOT NULL,
  `internet_access` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `workstation`
--

INSERT INTO `workstation` (`id`, `type_workstation`, `internet_access`) VALUES
(1, 'Настольный компьютер', 'Высокоскоростной'),
(2, 'Ноутбук', 'Wi-Fi'),
(3, 'Сервер', 'Ethernet'),
(4, 'Планшет', 'Wi-Fi'),
(5, 'Мобильное устройство', '4G');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `chart`
--
ALTER TABLE `chart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_employee` (`id_employee`);

--
-- Индексы таблицы `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_workstation` (`id_workstation`),
  ADD KEY `id_position` (`id_position`);

--
-- Индексы таблицы `employee_audit`
--
ALTER TABLE `employee_audit`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `execution_of_work`
--
ALTER TABLE `execution_of_work`
  ADD KEY `id_project` (`id_project`,`id_employee`),
  ADD KEY `fk_execution_employee` (`id_employee`);

--
-- Индексы таблицы `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_accrual_date_salary` (`accrual_date_salary`);

--
-- Индексы таблицы `reception`
--
ALTER TABLE `reception`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_customer` (`id_customer`),
  ADD KEY `id_manager` (`id_manager`);

--
-- Индексы таблицы `service_agreement`
--
ALTER TABLE `service_agreement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_customer` (`id_customer`,`id_manager`);

--
-- Индексы таблицы `website_project`
--
ALTER TABLE `website_project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_manager` (`id_manager`,`id_customer`,`id_contract`);

--
-- Индексы таблицы `workstation`
--
ALTER TABLE `workstation`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `chart`
--
ALTER TABLE `chart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `employee_audit`
--
ALTER TABLE `employee_audit`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `position`
--
ALTER TABLE `position`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `reception`
--
ALTER TABLE `reception`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `service_agreement`
--
ALTER TABLE `service_agreement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `website_project`
--
ALTER TABLE `website_project`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `workstation`
--
ALTER TABLE `workstation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `chart`
--
ALTER TABLE `chart`
  ADD CONSTRAINT `fk_chart_employee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`);

--
-- Ограничения внешнего ключа таблицы `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `fk_employee_position` FOREIGN KEY (`id_position`) REFERENCES `position` (`id`),
  ADD CONSTRAINT `fk_employee_workstation` FOREIGN KEY (`id_workstation`) REFERENCES `workstation` (`id`);

--
-- Ограничения внешнего ключа таблицы `execution_of_work`
--
ALTER TABLE `execution_of_work`
  ADD CONSTRAINT `fk_execution_employee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `fk_execution_project` FOREIGN KEY (`id_project`) REFERENCES `website_project` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
