DROP PROCEDURE `empty`;
DELIMITER ;;
CREATE FUNCTION `empty` (`_val` text) RETURNS tinyint(1) unsigned
BEGIN
CALL null_default(_val);
RETURN _val IS NULL;
END;;
DELIMITER ;
