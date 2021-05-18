-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SAMPLE13_44
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SAMPLE13_44
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SAMPLE13_44` DEFAULT CHARACTER SET utf8 ;
USE `SAMPLE13_44` ;

-- -----------------------------------------------------
-- Table `SAMPLE13_44`.`PUBLISHER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE13_44`.`PUBLISHER` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE13_44`.`BOOK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE13_44`.`BOOK` (
  `BookId` INT UNSIGNED NOT NULL,
  `Title` VARCHAR(45) NULL,
  `PublisherName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookId`),
  INDEX `PublisherName_idx` (`PublisherName` ASC),
  CONSTRAINT `BPublisherFK`
    FOREIGN KEY (`PublisherName`)
    REFERENCES `SAMPLE13_44`.`PUBLISHER` (`Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE13_44`.`BOOK_AUTHORS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE13_44`.`BOOK_AUTHORS` (
  `BookId` INT UNSIGNED NOT NULL,
  `AuthorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookId`, `AuthorName`),
  CONSTRAINT `BAIdFK`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE13_44`.`BOOK` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE13_44`.`LIBRARY_BRANCH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE13_44`.`LIBRARY_BRANCH` (
  `BranchId` INT UNSIGNED NOT NULL,
  `BranchName` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`BranchId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE13_44`.`BOOK_COPIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE13_44`.`BOOK_COPIES` (
  `BookId` INT UNSIGNED NOT NULL,
  `BranchId` INT UNSIGNED NOT NULL,
  `No_Of_Copies` INT NOT NULL,
  PRIMARY KEY (`BookId`, `BranchId`),
  INDEX `BranchId_idx` (`BranchId` ASC),
  CONSTRAINT `BCIdFK`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE13_44`.`BOOK` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BCBranchId`
    FOREIGN KEY (`BranchId`)
    REFERENCES `SAMPLE13_44`.`LIBRARY_BRANCH` (`BranchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE13_44`.`BORROWER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE13_44`.`BORROWER` (
  `CardNo` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`CardNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAMPLE13_44`.`BOOK_LOANS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE13_44`.`BOOK_LOANS` (
  `BookId` INT UNSIGNED NOT NULL,
  `BranchId` INT UNSIGNED NOT NULL,
  `CardNo` VARCHAR(45) NOT NULL,
  `DateOut` DATE NULL,
  `DueDate` DATE NULL,
  PRIMARY KEY (`BookId`, `BranchId`, `CardNo`),
  INDEX `CardNo_idx` (`CardNo` ASC),
  INDEX `BranchId_idx` (`BranchId` ASC),
  CONSTRAINT `BLIdFK`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE13_44`.`BOOK` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BLBranchIdFK`
    FOREIGN KEY (`BranchId`)
    REFERENCES `SAMPLE13_44`.`LIBRARY_BRANCH` (`BranchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BLCardNoFK`
    FOREIGN KEY (`CardNo`)
    REFERENCES `SAMPLE13_44`.`BORROWER` (`CardNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
