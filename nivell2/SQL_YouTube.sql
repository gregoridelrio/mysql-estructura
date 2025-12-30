-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_youtube
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_youtube` ;

-- -----------------------------------------------------
-- Schema db_youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_youtube` DEFAULT CHARACTER SET utf8 ;
USE `db_youtube` ;

-- -----------------------------------------------------
-- Table `db_youtube`.`Usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Usuari` (
  `id_Usuari` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codi_postal` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_Usuari`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_youtube`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Video` (
  `id_Video` INT NOT NULL,
  `titol` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `grandaria` VARCHAR(45) NOT NULL,
  `nom_arxiu` VARCHAR(45) NOT NULL,
  `durada` INT NOT NULL,
  `thumbnail` VARCHAR(45) NOT NULL,
  `reproduccions` INT NOT NULL,
  `estat` ENUM('public', 'ocult', 'privat') NOT NULL,
  `data_publicacio` DATETIME NOT NULL,
  `id_Usuari` INT NOT NULL,
  PRIMARY KEY (`id_Video`),
  CONSTRAINT `fk_Video_Usuari1`
    FOREIGN KEY (`id_Usuari`)
    REFERENCES `db_youtube`.`Usuari` (`id_Usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Video_Usuari1_idx` ON `db_youtube`.`Video` (`id_Usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Etiqueta` (
  `id_Etiqueta` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Etiqueta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_youtube`.`Etiquetes_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Etiquetes_video` (
  `id_Video` INT NOT NULL,
  `id_Etiqueta` INT NOT NULL,
  PRIMARY KEY (`id_Video`, `id_Etiqueta`),
  CONSTRAINT `fk_Video_has_Etiqueta_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `db_youtube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_has_Etiqueta_Etiqueta1`
    FOREIGN KEY (`id_Etiqueta`)
    REFERENCES `db_youtube`.`Etiqueta` (`id_Etiqueta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Video_has_Etiqueta_Etiqueta1_idx` ON `db_youtube`.`Etiquetes_video` (`id_Etiqueta` ASC) ;

CREATE INDEX `fk_Video_has_Etiqueta_Video1_idx` ON `db_youtube`.`Etiquetes_video` (`id_Video` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Canal` (
  `id_Canal` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(45) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `id_Usuari` INT NOT NULL,
  PRIMARY KEY (`id_Canal`),
  CONSTRAINT `fk_Canal_Usuari1`
    FOREIGN KEY (`id_Usuari`)
    REFERENCES `db_youtube`.`Usuari` (`id_Usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Canal_Usuari1_idx` ON `db_youtube`.`Canal` (`id_Usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Suscripcio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Suscripcio` (
  `id_Usuari` INT NOT NULL,
  `id_Canal` INT NOT NULL,
  PRIMARY KEY (`id_Usuari`, `id_Canal`),
  CONSTRAINT `fk_Usuari_has_Canal_Usuari1`
    FOREIGN KEY (`id_Usuari`)
    REFERENCES `db_youtube`.`Usuari` (`id_Usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_has_Canal_Canal1`
    FOREIGN KEY (`id_Canal`)
    REFERENCES `db_youtube`.`Canal` (`id_Canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuari_has_Canal_Canal1_idx` ON `db_youtube`.`Suscripcio` (`id_Canal` ASC) ;

CREATE INDEX `fk_Usuari_has_Canal_Usuari1_idx` ON `db_youtube`.`Suscripcio` (`id_Usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Reaccio_Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Reaccio_Video` (
  `id_Usuari` INT NOT NULL,
  `id_Video` INT NOT NULL,
  `tipus_reaccio` ENUM('like', 'dislike') NOT NULL,
  `data_reaccio` DATETIME NOT NULL,
  PRIMARY KEY (`id_Usuari`, `id_Video`),
  CONSTRAINT `fk_Usuari_has_Video_Usuari1`
    FOREIGN KEY (`id_Usuari`)
    REFERENCES `db_youtube`.`Usuari` (`id_Usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_has_Video_Video2`
    FOREIGN KEY (`id_Video`)
    REFERENCES `db_youtube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuari_has_Video_Video2_idx` ON `db_youtube`.`Reaccio_Video` (`id_Video` ASC) ;

CREATE INDEX `fk_Usuari_has_Video_Usuari1_idx` ON `db_youtube`.`Reaccio_Video` (`id_Usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Playlist` (
  `id_Playlist` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `data_creacio` DATE NOT NULL,
  `estat` ENUM('publica', 'privada') NOT NULL,
  `id_Usuari` INT NOT NULL,
  PRIMARY KEY (`id_Playlist`),
  CONSTRAINT `fk_Playlist_Usuari1`
    FOREIGN KEY (`id_Usuari`)
    REFERENCES `db_youtube`.`Usuari` (`id_Usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Playlist_Usuari1_idx` ON `db_youtube`.`Playlist` (`id_Usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Comentari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Comentari` (
  `id_Comentari` INT NOT NULL,
  `text` VARCHAR(200) NOT NULL,
  `data_comentari` DATETIME NOT NULL,
  `id_Video` INT NOT NULL,
  `id_Usuari` INT NOT NULL,
  PRIMARY KEY (`id_Comentari`),
  CONSTRAINT `fk_Comentari_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `db_youtube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentari_Usuari1`
    FOREIGN KEY (`id_Usuari`)
    REFERENCES `db_youtube`.`Usuari` (`id_Usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Comentari_Video1_idx` ON `db_youtube`.`Comentari` (`id_Video` ASC) ;

CREATE INDEX `fk_Comentari_Usuari1_idx` ON `db_youtube`.`Comentari` (`id_Usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Reaccio_Comentari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Reaccio_Comentari` (
  `id_Usuari` INT NOT NULL,
  `id_Comentari` INT NOT NULL,
  `tipus` ENUM('like', 'dislike') NOT NULL,
  `data_reaccio` DATETIME NOT NULL,
  PRIMARY KEY (`id_Usuari`, `id_Comentari`),
  CONSTRAINT `fk_Usuari_has_Comentari_Usuari1`
    FOREIGN KEY (`id_Usuari`)
    REFERENCES `db_youtube`.`Usuari` (`id_Usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_has_Comentari_Comentari1`
    FOREIGN KEY (`id_Comentari`)
    REFERENCES `db_youtube`.`Comentari` (`id_Comentari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuari_has_Comentari_Comentari1_idx` ON `db_youtube`.`Reaccio_Comentari` (`id_Comentari` ASC) ;

CREATE INDEX `fk_Usuari_has_Comentari_Usuari1_idx` ON `db_youtube`.`Reaccio_Comentari` (`id_Usuari` ASC) ;


-- -----------------------------------------------------
-- Table `db_youtube`.`Playlist_Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_youtube`.`Playlist_Video` (
  `id_Video` INT NOT NULL,
  `id_Playlist` INT NOT NULL,
  PRIMARY KEY (`id_Video`, `id_Playlist`),
  CONSTRAINT `fk_Video_has_Playlist_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `db_youtube`.`Video` (`id_Video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_has_Playlist_Playlist1`
    FOREIGN KEY (`id_Playlist`)
    REFERENCES `db_youtube`.`Playlist` (`id_Playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Video_has_Playlist_Playlist1_idx` ON `db_youtube`.`Playlist_Video` (`id_Playlist` ASC) ;

CREATE INDEX `fk_Video_has_Playlist_Video1_idx` ON `db_youtube`.`Playlist_Video` (`id_Video` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
