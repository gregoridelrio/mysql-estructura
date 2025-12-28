-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_pizzeria` ;

-- -----------------------------------------------------
-- Schema db_pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `db_pizzeria` ;

-- -----------------------------------------------------
-- Table `db_pizzeria`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Client` (
  `id_Client` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `cognoms` VARCHAR(90) NOT NULL,
  `adreca` VARCHAR(90) NOT NULL,
  `codi_postal` VARCHAR(5) NOT NULL,
  `localitat` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id_Client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_pizzeria`.`Botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Botiga` (
  `id_Botiga` INT NOT NULL,
  `adreca` VARCHAR(45) NOT NULL,
  `codi_postal` VARCHAR(5) NOT NULL,
  `localitat` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Botiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_pizzeria`.`Comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Comanda` (
  `id_Comanda` INT NOT NULL,
  `data_hora_comanda` DATETIME NOT NULL,
  `tipus_comanda` ENUM('domicili', 'recollida') NOT NULL,
  `preu_total` FLOAT NOT NULL,
  `id_Client` INT NOT NULL,
  `id_Botiga` INT NOT NULL,
  PRIMARY KEY (`id_Comanda`),
  CONSTRAINT `fk_Comanda_Client`
    FOREIGN KEY (`id_Client`)
    REFERENCES `db_pizzeria`.`Client` (`id_Client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_Botiga1`
    FOREIGN KEY (`id_Botiga`)
    REFERENCES `db_pizzeria`.`Botiga` (`id_Botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Comanda_Client_idx` ON `db_pizzeria`.`Comanda` (`id_Client` ASC) ;

CREATE INDEX `fk_Comanda_Botiga1_idx` ON `db_pizzeria`.`Comanda` (`id_Botiga` ASC) ;


-- -----------------------------------------------------
-- Table `db_pizzeria`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Categoria` (
  `id_Categoria` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_pizzeria`.`Producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Producte` (
  `id_Producte` INT NOT NULL,
  `nom` VARCHAR(50) NOT NULL,
  `descripcio` VARCHAR(100) NOT NULL,
  `imatge` VARCHAR(100) NOT NULL,
  `preu` FLOAT NOT NULL,
  `tipus` ENUM('pizza', 'hamburguesa', 'beguda') NOT NULL,
  `id_Categoria` INT NULL,
  PRIMARY KEY (`id_Producte`),
  CONSTRAINT `fk_Producte_Categoria1`
    FOREIGN KEY (`id_Categoria`)
    REFERENCES `db_pizzeria`.`Categoria` (`id_Categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Producte_Categoria1_idx` ON `db_pizzeria`.`Producte` (`id_Categoria` ASC) ;


-- -----------------------------------------------------
-- Table `db_pizzeria`.`Empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Empleat` (
  `id_Empleat` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `cognoms` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `telefon` VARCHAR(9) NOT NULL,
  `id_Botiga` INT NOT NULL,
  `carrec` ENUM('cuiner', 'repartidor') NOT NULL,
  PRIMARY KEY (`id_Empleat`),
  CONSTRAINT `fk_Empleat_Botiga1`
    FOREIGN KEY (`id_Botiga`)
    REFERENCES `db_pizzeria`.`Botiga` (`id_Botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `NIF_UNIQUE` ON `db_pizzeria`.`Empleat` (`NIF` ASC) ;

CREATE INDEX `fk_Empleat_Botiga1_idx` ON `db_pizzeria`.`Empleat` (`id_Botiga` ASC) ;


-- -----------------------------------------------------
-- Table `db_pizzeria`.`Lliurament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Lliurament` (
  `id_Comanda` INT NOT NULL,
  `id_Empleat` INT NOT NULL,
  `data_hora_lliura` DATETIME NOT NULL,
  PRIMARY KEY (`id_Comanda`, `id_Empleat`),
  CONSTRAINT `fk_Comanda_has_Empleat_Comanda1`
    FOREIGN KEY (`id_Comanda`)
    REFERENCES `db_pizzeria`.`Comanda` (`id_Comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_has_Empleat_Empleat1`
    FOREIGN KEY (`id_Empleat`)
    REFERENCES `db_pizzeria`.`Empleat` (`id_Empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Comanda_has_Empleat_Empleat1_idx` ON `db_pizzeria`.`Lliurament` (`id_Empleat` ASC) ;

CREATE INDEX `fk_Comanda_has_Empleat_Comanda1_idx` ON `db_pizzeria`.`Lliurament` (`id_Comanda` ASC) ;


-- -----------------------------------------------------
-- Table `db_pizzeria`.`Comanda_Producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_pizzeria`.`Comanda_Producte` (
  `Comanda_id_Comanda` INT NOT NULL,
  `Producte_id_Producte` INT NOT NULL,
  `quantitat` INT NOT NULL,
  PRIMARY KEY (`Comanda_id_Comanda`, `Producte_id_Producte`),
  CONSTRAINT `fk_Comanda_has_Producte_Comanda1`
    FOREIGN KEY (`Comanda_id_Comanda`)
    REFERENCES `db_pizzeria`.`Comanda` (`id_Comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_has_Producte_Producte1`
    FOREIGN KEY (`Producte_id_Producte`)
    REFERENCES `db_pizzeria`.`Producte` (`id_Producte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Comanda_has_Producte_Producte1_idx` ON `db_pizzeria`.`Comanda_Producte` (`Producte_id_Producte` ASC) ;

CREATE INDEX `fk_Comanda_has_Producte_Comanda1_idx` ON `db_pizzeria`.`Comanda_Producte` (`Comanda_id_Comanda` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
