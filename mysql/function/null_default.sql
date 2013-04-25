DROP PROCEDURE `null_default`;
DELIMITER ;;
CREATE PROCEDURE `null_default` (INOUT `_val` text)
NO SQL
    DETERMINISTIC
BEGIN
IF TRIM(_val) = '' OR is_numeric(_val) AND _val = 0 OR _val = '0000-00-00' OR _val = '0000-00-00 00:00:00' THEN
	SET _val := NULL;
END IF;
END;;
DELIMITER ;
