
-- Adminer 3.6.3 MySQL dump

SET NAMES utf8;
SET foreign_key_checks = 0;
SET time_zone = 'SYSTEM';
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(11) unsigned NOT NULL,
  `flag` enum('gate','order-','refunded','deduction-','transfer') NOT NULL COMMENT 'dash indicates a negative value',
  `cash` decimal(14,2) NOT NULL,
  `description` varchar(255) NOT NULL COMMENT 'note',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  CONSTRAINT `wallet_ibfk_2` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER ;;

CREATE TRIGGER `wallet_bi` BEFORE INSERT ON `wallet` FOR EACH ROW
BEGIN
DECLARE _dash char(1) DEFAULT SUBSTR(NEW.flag, -1);

IF _dash = '-' AND NEW.cash > 0 THEN
	CALL error_raise(4, 'Flag is negative, and you have a positive cash.');
ELSEIF _dash != '-' AND NEW.cash < 0 THEN
	CALL error_raise(3, 'Flag is positive, and you have a negativa cash.');
END IF;

IF !NEW.cash THEN
	CALL error_raise(1, 'Cash can not be zero.');
ELSEIF NEW.cash < 0 AND (wallet_debit(NEW.users_id) + NEW.cash) < 0 THEN
	CALL error_raise(2, 'You do not have the money in your wallet.');
END IF;
CALL _null_default(NEW.flag);
END;;

-- you can edit description
CREATE TRIGGER `wallet_bu` BEFORE UPDATE ON `wallet` FOR EACH ROW
BEGIN
SET NEW.users_id := OLD.users_id;
SET NEW.flag := OLD.flag;
SET NEW.cash := OLD.cash;
SET NEW.ts := OLD.ts;
END;;

-- you can't delete row
CREATE TRIGGER `wallet_bd` BEFORE DELETE ON `wallet` FOR EACH ROW
BEGIN
CALL error_raise(5, 'Wallet can be adjusted.');
END;;

DELIMITER ;

-- 2013-04-25 22:03:17