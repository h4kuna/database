DROP PROCEDURE `null_default`;
DELIMITER ;;
CREATE PROCEDURE `null_default` (INOUT `_val` text)
NO SQL
    DETERMINISTIC
BEGIN
IF _val = '0000-00-00' OR _val = '0000-00-00 00:00:00' OR TRIM(_val) = '' OR _val = 0 AND is_numeric(_val) THEN
	SET _val := NULL;
END IF;
END;;
DELIMITER ;
