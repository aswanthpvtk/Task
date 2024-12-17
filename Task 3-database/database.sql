/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 10.4.22-MariaDB : Database - employeemanagement
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`employeemanagement` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `employeemanagement`;

/*Table structure for table `departments` */

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments` (
  `DepartmentID` int(11) NOT NULL,
  `DepartmentName` varchar(100) NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `departments` */

insert  into `departments`(`DepartmentID`,`DepartmentName`) values 
(1,'HR'),
(2,'Engineering'),
(3,'Finance');

/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `DepartmentID` int(11) NOT NULL,
  `HireDate` date NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `employees` */

insert  into `employees`(`EmployeeID`,`Name`,`DepartmentID`,`HireDate`) values 
(101,'Aswanth',2,'2020-01-15'),
(102,'Anu',3,'2021-03-10'),
(103,'Athul',1,'2019-08-25');

/*Table structure for table `salaries` */

DROP TABLE IF EXISTS `salaries`;

CREATE TABLE `salaries` (
  `EmployeeID` int(11) NOT NULL,
  `BaseSalary` decimal(10,2) NOT NULL,
  `Bonus` decimal(10,2) DEFAULT NULL,
  `Deductions` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `salaries` */

insert  into `salaries`(`EmployeeID`,`BaseSalary`,`Bonus`,`Deductions`) values 
(101,50000.00,5000.00,2000.00),
(102,60000.00,4000.00,3000.00),
(103,45000.00,3000.00,1000.00);

/* Procedure structure for procedure `AddEmployee` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddEmployee` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `AddEmployee`(
    IN empID INT, 
    IN empName VARCHAR(100), 
    IN deptID INT, 
    IN hireDate DATE
)
BEGIN
    INSERT INTO Employees (EmployeeID, Name, DepartmentID, HireDate) 
    VALUES (empID, empName, deptID, hireDate);
END */$$
DELIMITER ;

/* Procedure structure for procedure `CalculatePayroll` */

/*!50003 DROP PROCEDURE IF EXISTS  `CalculatePayroll` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculatePayroll`()
BEGIN
    SELECT SUM(BaseSalary + Bonus - Deductions) AS TotalPayroll 
    FROM Salaries;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateSalary` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateSalary` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSalary`(
    IN empID INT,
    IN newBaseSalary DECIMAL(10, 2),
    IN newBonus DECIMAL(10, 2),
    IN newDeductions DECIMAL(10, 2)
)
BEGIN
    UPDATE Salaries
    SET BaseSalary = newBaseSalary,
        Bonus = newBonus,
        Deductions = newDeductions
    WHERE EmployeeID = empID;
END */$$
DELIMITER ;

/*Table structure for table `employeesalaryview` */

DROP TABLE IF EXISTS `employeesalaryview`;

/*!50001 DROP VIEW IF EXISTS `employeesalaryview` */;
/*!50001 DROP TABLE IF EXISTS `employeesalaryview` */;

/*!50001 CREATE TABLE  `employeesalaryview`(
 `Name` varchar(100) ,
 `DepartmentName` varchar(100) ,
 `NetSalary` decimal(12,2) 
)*/;

/*Table structure for table `highearnerview` */

DROP TABLE IF EXISTS `highearnerview`;

/*!50001 DROP VIEW IF EXISTS `highearnerview` */;
/*!50001 DROP TABLE IF EXISTS `highearnerview` */;

/*!50001 CREATE TABLE  `highearnerview`(
 `Name` varchar(100) ,
 `NetSalary` decimal(12,2) 
)*/;

/*View structure for view employeesalaryview */

/*!50001 DROP TABLE IF EXISTS `employeesalaryview` */;
/*!50001 DROP VIEW IF EXISTS `employeesalaryview` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employeesalaryview` AS select `e`.`Name` AS `Name`,`d`.`DepartmentName` AS `DepartmentName`,`s`.`BaseSalary` + `s`.`Bonus` - `s`.`Deductions` AS `NetSalary` from ((`employees` `e` join `salaries` `s` on(`e`.`EmployeeID` = `s`.`EmployeeID`)) join `departments` `d` on(`e`.`DepartmentID` = `d`.`DepartmentID`)) */;

/*View structure for view highearnerview */

/*!50001 DROP TABLE IF EXISTS `highearnerview` */;
/*!50001 DROP VIEW IF EXISTS `highearnerview` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `highearnerview` AS select `e`.`Name` AS `Name`,`s`.`BaseSalary` + `s`.`Bonus` - `s`.`Deductions` AS `NetSalary` from (`employees` `e` join `salaries` `s` on(`e`.`EmployeeID` = `s`.`EmployeeID`)) where `s`.`BaseSalary` + `s`.`Bonus` - `s`.`Deductions` > 50000 */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
