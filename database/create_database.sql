-- MySQL Script generated by MySQL Workbench
-- Mon Nov 11 19:02:11 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE database  `31778368_matchfinderdb` DEFAULT CHARACTER SET utf8 ;
USE `31778368_matchfinderdb` ;

-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`Country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


delimiter //
CREATE TRIGGER checkCountryName BEFORE insert ON Country
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckCountryName BEFORE update ON Country
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`City` (
  `id` INT NOT NULL Auto_increment,
  `Country_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_City_Country1_idx` (`Country_id` ASC) ,
  CONSTRAINT `fk_City_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `31778368_matchfinderdb`.`Country` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

delimiter //
CREATE TRIGGER checkCityName BEFORE insert ON City
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckCityName BEFORE update ON City
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`Stadium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`Stadium` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `City_id` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `capacity` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Stadium_City_idx` (`City_id` ASC) ,
  CONSTRAINT `fk_Stadium_City`
    FOREIGN KEY (`City_id`)
    REFERENCES `31778368_matchfinderdb`.`City` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE `Stadium` ADD `latitude` DOUBLE NULL DEFAULT NULL AFTER `capacity`, ADD `longitude` DOUBLE NULL DEFAULT NULL AFTER `latitude`;


delimiter //
CREATE TRIGGER checkStadiumNr BEFORE Insert ON Stadium
       FOR EACH ROW
       BEGIN
           IF NEW.number < 1 THEN
              	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;


delimiter //
CREATE TRIGGER ucheckStadiumNr BEFORE Update ON Stadium
       FOR EACH ROW
       BEGIN
           IF NEW.number < 1 THEN
              	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;


delimiter //
CREATE TRIGGER checkStadiumCapacity BEFORE Insert ON Stadium
       FOR EACH ROW
       BEGIN
           IF NEW.capacity < 1 THEN
               SET NEW.capacity = 1;
               ELSEIF new.capacity>150000 THEN
				SET NEW.capacity=1500000;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckStadiumCapacity BEFORE Update ON Stadium
       FOR EACH ROW
       BEGIN
           IF NEW.capacity < 1 THEN
               SET NEW.capacity = 1;
               ELSEIF new.capacity>150000 THEN
				SET NEW.capacity=1500000;
           END IF;
       END;//
delimiter ;
-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`Team_currentForm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`Team_currentForm` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `position` INT NULL,
  `ranking` INT NULL,
  `5th_last_game` ENUM('W', 'D', 'L') NULL,
  `4th_last_game` ENUM('W', 'D', 'L') NULL,
  `3rd_last_game` ENUM('W', 'D', 'L') NULL,
  `2nd_last_game` ENUM('W', 'D', 'L') NULL,
  `last_game` ENUM('W', 'D', 'L') NULL,
  `points` INT NULL,
  `goalsScored` INT NULL,
  `goalsAgainst` INT NULL,
  `goalsDifference` INT NULL,
  `cleanSheets` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

delimiter //
CREATE TRIGGER checkTeamPosition BEFORE insert ON Team_currentForm
       FOR EACH ROW
       BEGIN
           IF NEW.position < 1 THEN
				SIGNAL sqlstate '45001' set message_text = "You can't do it!";
				ELSEIF new.position>40 THEN
				SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckTeamPosition BEFORE Update ON Team_currentForm
       FOR EACH ROW
       BEGIN
           IF NEW.position < 1 THEN
              	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
               ELSEIF new.position>40 THEN
				SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;


delimiter //
CREATE TRIGGER checkTeamRank BEFORE insert ON Team_currentForm
       FOR EACH ROW
       BEGIN
           IF NEW.ranking < 1 THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
               ELSEIF new.ranking>10000000 THEN
					SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckTeamRank BEFORE Update ON Team_currentForm
       FOR EACH ROW
       BEGIN
           IF NEW.ranking < 1 THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
               ELSEIF new.ranking>10000000 THEN
					SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;


-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`Team_achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`Team_achievements` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nr_of_championship` INT NULL,
  `years_of_championship` VARCHAR(45) NULL,
  `nr_of_cup_wins` INT NULL,
  `years_of_cup_wins` VARCHAR(45) NULL,
  `nr_of_lesser_cups_win` INT NULL,
  `years_of_leser_cups_win` VARCHAR(45) NULL,
  `nr_of_club_wc_win` INT NULL,
  `years_of_club_wc_win` VARCHAR(45) NULL,
  `nr_of_champions_league_win` INT NULL,
  `years_of_champions_league_win` VARCHAR(45) NULL,
  `nr_of_lesser_international_wins` INT NULL,
  `years_of_lesser_international_wins` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


delimiter //
CREATE TRIGGER checkChampionshipsNr BEFORE Insert ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_championship < 0 THEN
               SET NEW.nr_of_championship = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckChampionshipsNr BEFORE Update ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_championship < 0 THEN
               SET NEW.nr_of_championship = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER checkCupsNr BEFORE Insert ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_cup_wins < 0 THEN
               SET NEW.nr_of_cup_wins = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckCupsNr BEFORE Update ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_cup_wins < 0 THEN
               SET NEW.nr_of_cup_wins = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER checkLesserCupsNr BEFORE Insert ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_lesser_cups_win < 0 THEN
               SET NEW.nr_of_lesser_cups_win = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckLesserCupsNr BEFORE Update ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_lesser_cups_win < 0 THEN
               SET NEW.nr_of_lesser_cups_win = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER checkClubWCNr BEFORE Insert ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_club_wc_win < 0 THEN
               SET NEW.nr_of_club_wc_win = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckClubWCNr BEFORE Update ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_club_wc_win < 0 THEN
               SET NEW.nr_of_club_wc_win = 0;
           END IF;
       END;//
delimiter ;


delimiter //
CREATE TRIGGER checkCLNr BEFORE Insert ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_champions_league_win < 0 THEN
               SET NEW.nr_of_champions_league_win = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckCLNr BEFORE Update ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_champions_league_win < 0 THEN
               SET NEW.nr_of_champions_league_win = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER checkELNr BEFORE Insert ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_lesser_international_wins < 0 THEN
               SET NEW.nr_of_lesser_international_wins = 0;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckELNr BEFORE Update ON Team_achievements
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_lesser_international_wins < 0 THEN
               SET NEW.nr_of_lesser_international_wins = 0;
           END IF;
       END;//
delimiter ;
-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`League`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`League` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Country_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `tier` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_League_Country1_idx` (`Country_id` ASC) ,
  CONSTRAINT `fk_League_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `31778368_matchfinderdb`.`Country` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


delimiter //
CREATE TRIGGER checkTier BEFORE insert ON League
       FOR EACH ROW
       BEGIN
           IF NEW.tier < 1 THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
               ELSEIF new.tier>50 THEN
					SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckTier BEFORE Update ON League
       FOR EACH ROW
       BEGIN
           IF NEW.tier < 1 THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
               ELSEIF new.tier>10000000 THEN
					SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER checkLeagueName BEFORE insert ON League
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckLeagueName BEFORE update ON League
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`Team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Stadium_id` INT NOT NULL,
  `League_id` INT NOT NULL,
  `Team_currentForm_id` INT NULL,
  `Team_achievements_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `coach_name` VARCHAR(45) NULL,
  `logo_image` LONGBLOB NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Team_Team_currentForm1_idx` (`Team_currentForm_id` ASC) ,
  INDEX `fk_Team_Stadium1_idx` (`Stadium_id` ASC) ,
  INDEX `fk_Team_Team_achievements1_idx` (`Team_achievements_id` ASC) ,
  INDEX `fk_Team_League1_idx` (`League_id` ASC) ,
  CONSTRAINT `fk_Team_Team_currentForm1`
    FOREIGN KEY (`Team_currentForm_id`)
    REFERENCES `31778368_matchfinderdb`.`Team_currentForm` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Team_Stadium1`
    FOREIGN KEY (`Stadium_id`)
    REFERENCES `31778368_matchfinderdb`.`Stadium` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Team_Team_achievements1`
    FOREIGN KEY (`Team_achievements_id`)
    REFERENCES `31778368_matchfinderdb`.`Team_achievements` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Team_League1`
    FOREIGN KEY (`League_id`)
    REFERENCES `31778368_matchfinderdb`.`League` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

delimiter //
CREATE TRIGGER checkTeamName BEFORE insert ON Team
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckTeamName BEFORE update ON Team
       FOR EACH ROW
       BEGIN
           IF NEW.name is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`Game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`Game` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Stadium_id` INT NOT NULL,
  `League_id` INT NOT NULL,
  `Team_home_id` INT NOT NULL,
  `Team_away_id` INT NOT NULL,
  `game_date` DATETIME,
  `home_score` INT NULL DEFAULT 0,
  `away_score` INT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_Game_League1_idx` (`League_id` ASC) ,
  INDEX `fk_Game_Team1_idx` (`Team_home_id` ASC) ,
  INDEX `fk_Game_Team2_idx` (`Team_away_id` ASC) ,
  INDEX `fk_Game_Stadium1_idx` (`Stadium_id` ASC) ,
  CONSTRAINT `fk_Game_League1`
    FOREIGN KEY (`League_id`)
    REFERENCES `31778368_matchfinderdb`.`League` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Team1`
    FOREIGN KEY (`Team_home_id`)
    REFERENCES `31778368_matchfinderdb`.`Team` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Team2`
    FOREIGN KEY (`Team_away_id`)
    REFERENCES `31778368_matchfinderdb`.`Team` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Stadium1`
    FOREIGN KEY (`Stadium_id`)
    REFERENCES `31778368_matchfinderdb`.`Stadium` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `nr_of_games` INT NOT NULL DEFAULT 0,
  `username` VARCHAR(16) NULL,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `City_id` INT NULL,
  `Country_id` INT NULL,
  `street` VARCHAR(45) NULL,
  `house_nr` INT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_User_City1_idx` (`City_id` ASC) ,
  INDEX `fk_User_Country1_idx` (`Country_id` ASC) ,
  CONSTRAINT `fk_User_City1`
    FOREIGN KEY (`City_id`)
    REFERENCES `31778368_matchfinderdb`.`City` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `31778368_matchfinderdb`.`Country` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION);

delimiter //
CREATE TRIGGER checkUserEmail BEFORE insert ON User
       FOR EACH ROW
       BEGIN
           IF NEW.email is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER ucheckUserEmail BEFORE Update ON User
       FOR EACH ROW
       BEGIN
           IF NEW.email is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER checkUserPassword BEFORE insert ON User
       FOR EACH ROW
       BEGIN
           IF NEW.password is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;


delimiter //
CREATE TRIGGER ucheckUserPassword BEFORE Update ON User
       FOR EACH ROW
       BEGIN
           IF NEW.password is Null THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;


delimiter //
CREATE TRIGGER checkUserNrOfGames BEFORE insert ON User
       FOR EACH ROW
       BEGIN
           IF NEW.nr_of_games <0 THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;


delimiter //
CREATE TRIGGER ucheckUserNrOfGames BEFORE Update ON User
       FOR EACH ROW
       BEGIN
        IF NEW.nr_of_games <0 THEN
               	SIGNAL sqlstate '45001' set message_text = "You can't do it!";
           END IF;
       END;//
delimiter ;
-- -----------------------------------------------------
-- Table `31778368_matchfinderdb`.`Users_games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `31778368_matchfinderdb`.`Users_games` (
  `User_id` INT NOT NULL,
  `Game_id` INT NOT NULL,
  PRIMARY KEY (`User_id`, `Game_id`),
  INDEX `fk_User_has_Game_Game1_idx` (`Game_id` ASC) ,
  INDEX `fk_User_has_Game_User1_idx` (`User_id` ASC) ,
  CONSTRAINT `fk_User_has_Game_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `31778368_matchfinderdb`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Game_Game1`
    FOREIGN KEY (`Game_id`)
    REFERENCES `31778368_matchfinderdb`.`Game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


