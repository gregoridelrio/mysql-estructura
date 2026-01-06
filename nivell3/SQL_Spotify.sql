-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_spotify
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_spotify` ;

-- -----------------------------------------------------
-- Schema db_spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_spotify` DEFAULT CHARACTER SET utf8 ;
USE `db_spotify` ;

-- -----------------------------------------------------
-- Table `db_spotify`.`Usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Usuari` (
  `id_usuari` INT NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codi_postal` VARCHAR(45) NOT NULL,
  `tipus` ENUM('free', 'premium') NOT NULL,
  PRIMARY KEY (`id_usuari`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_spotify`.`Targeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Targeta` (
  `id_targeta` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `mes` INT(2) NOT NULL,
  `any` YEAR NOT NULL,
  `codi_seguretat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_targeta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_spotify`.`Paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Paypal` (
  `id_paypal` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_paypal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_spotify`.`Suscripcio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Suscripcio` (
  `id_suscripcio` INT NOT NULL,
  `data_inici` DATE NOT NULL,
  `data_renovacio` DATE NOT NULL,
  `pagament` ENUM('targeta', 'paypal') NOT NULL,
  `Targeta_id_targeta` INT NULL,
  `id_paypal` INT NULL,
  `id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_suscripcio`),
  CONSTRAINT `fk_Suscripcio_Targeta1`
    FOREIGN KEY (`Targeta_id_targeta`)
    REFERENCES `db_spotify`.`Targeta` (`id_targeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Suscripcio_Paypal1`
    FOREIGN KEY (`id_paypal`)
    REFERENCES `db_spotify`.`Paypal` (`id_paypal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Suscripcio_Usuari1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `db_spotify`.`Usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Suscripcio_Targeta1_idx` ON `db_spotify`.`Suscripcio` (`Targeta_id_targeta` ASC) ;

CREATE INDEX `fk_Suscripcio_Paypal1_idx` ON `db_spotify`.`Suscripcio` (`id_paypal` ASC) ;

CREATE INDEX `fk_Suscripcio_Usuari1_idx` ON `db_spotify`.`Suscripcio` (`id_usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`Pagament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Pagament` (
  `id_pagament` INT NOT NULL,
  `data_pagament` DATE NOT NULL,
  `ordre` VARCHAR(45) NOT NULL,
  `total` FLOAT NOT NULL,
  `id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_pagament`),
  CONSTRAINT `fk_Pagament_Usuari1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `db_spotify`.`Usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pagament_Usuari1_idx` ON `db_spotify`.`Pagament` (`id_usuari` ASC) ;

CREATE UNIQUE INDEX `ordre_UNIQUE` ON `db_spotify`.`Pagament` (`ordre` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Playlist` (
  `id_playlist` INT NOT NULL,
  `titol` VARCHAR(45) NOT NULL,
  `num_cancons` INT NOT NULL,
  `data_creacio` DATE NOT NULL,
  `id_usuari` INT NOT NULL,
  `data_esborrada` DATE NULL,
  PRIMARY KEY (`id_playlist`),
  CONSTRAINT `fk_Playlist_Usuari1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `db_spotify`.`Usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Playlist_Usuari1_idx` ON `db_spotify`.`Playlist` (`id_usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`Artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Artista` (
  `id_artista` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `imatge` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_artista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_spotify`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Album` (
  `id_album` INT NOT NULL,
  `titol` VARCHAR(45) NOT NULL,
  `any_publicacio` YEAR NOT NULL,
  `portada` VARCHAR(150) NOT NULL,
  `id_artista` INT NOT NULL,
  PRIMARY KEY (`id_album`),
  CONSTRAINT `fk_Album_Artista1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `db_spotify`.`Artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Album_Artista1_idx` ON `db_spotify`.`Album` (`id_artista` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`Canco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Canco` (
  `id_canco` INT NOT NULL,
  `titol` VARCHAR(45) NOT NULL,
  `durada` INT NOT NULL,
  `reproduccions` INT NOT NULL,
  `id_album` INT NOT NULL,
  PRIMARY KEY (`id_canco`),
  CONSTRAINT `fk_Canco_Album1`
    FOREIGN KEY (`id_album`)
    REFERENCES `db_spotify`.`Album` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Canco_Album1_idx` ON `db_spotify`.`Canco` (`id_album` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`Playlist_Canco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`Playlist_Canco` (
  `id_playlist` INT NOT NULL,
  `id_canco` INT NOT NULL,
  `data_afegida` DATE NOT NULL,
  `id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_playlist`, `id_canco`),
  CONSTRAINT `fk_Playlist_has_Canco_Playlist1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `db_spotify`.`Playlist` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_has_Canco_Canco1`
    FOREIGN KEY (`id_canco`)
    REFERENCES `db_spotify`.`Canco` (`id_canco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_Canco_Usuari1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `db_spotify`.`Usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Playlist_has_Canco_Canco1_idx` ON `db_spotify`.`Playlist_Canco` (`id_canco` ASC) ;

CREATE INDEX `fk_Playlist_has_Canco_Playlist1_idx` ON `db_spotify`.`Playlist_Canco` (`id_playlist` ASC) ;

CREATE INDEX `fk_Playlist_Canco_Usuari1_idx` ON `db_spotify`.`Playlist_Canco` (`id_usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`usuari_segueix_artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`usuari_segueix_artista` (
  `id_usuari` INT NOT NULL,
  `id_artista` INT NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_artista`),
  CONSTRAINT `fk_Usuari_has_Artista_Usuari1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `db_spotify`.`Usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_has_Artista_Artista1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `db_spotify`.`Artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuari_has_Artista_Artista1_idx` ON `db_spotify`.`usuari_segueix_artista` (`id_artista` ASC) ;

CREATE INDEX `fk_Usuari_has_Artista_Usuari1_idx` ON `db_spotify`.`usuari_segueix_artista` (`id_usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`artista_relaciona_artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`artista_relaciona_artista` (
  `id_artista` INT NOT NULL,
  `id_artista2` INT NOT NULL,
  PRIMARY KEY (`id_artista`, `id_artista2`),
  CONSTRAINT `fk_Artista_has_Artista_Artista1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `db_spotify`.`Artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artista_has_Artista_Artista2`
    FOREIGN KEY (`id_artista2`)
    REFERENCES `db_spotify`.`Artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Artista_has_Artista_Artista2_idx` ON `db_spotify`.`artista_relaciona_artista` (`id_artista2` ASC) ;

CREATE INDEX `fk_Artista_has_Artista_Artista1_idx` ON `db_spotify`.`artista_relaciona_artista` (`id_artista` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`usuari_fav_canco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`usuari_fav_canco` (
  `Usuari_id_usuari` INT NOT NULL,
  `Canco_id_canco` INT NOT NULL,
  PRIMARY KEY (`Usuari_id_usuari`, `Canco_id_canco`),
  CONSTRAINT `fk_Usuari_has_Canco_Usuari1`
    FOREIGN KEY (`Usuari_id_usuari`)
    REFERENCES `db_spotify`.`Usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_has_Canco_Canco1`
    FOREIGN KEY (`Canco_id_canco`)
    REFERENCES `db_spotify`.`Canco` (`id_canco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuari_has_Canco_Canco1_idx` ON `db_spotify`.`usuari_fav_canco` (`Canco_id_canco` ASC) ;

CREATE INDEX `fk_Usuari_has_Canco_Usuari1_idx` ON `db_spotify`.`usuari_fav_canco` (`Usuari_id_usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_spotify`.`usuari_fav_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_spotify`.`usuari_fav_album` (
  `id_usuari` INT NOT NULL,
  `id_album` INT NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_album`),
  CONSTRAINT `fk_Usuari_has_Album_Usuari1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `db_spotify`.`Usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_has_Album_Album1`
    FOREIGN KEY (`id_album`)
    REFERENCES `db_spotify`.`Album` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuari_has_Album_Album1_idx` ON `db_spotify`.`usuari_fav_album` (`id_album` ASC) ;

CREATE INDEX `fk_Usuari_has_Album_Usuari1_idx` ON `db_spotify`.`usuari_fav_album` (`id_usuari` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
