DROP PROCEDURE `null_default`;
DELIMITER ;;
CREATE PROCEDURE `null_default` (INOUT `_val` text)
NO SQL
    DETERMINISTIC
BEGIN
IF TRIM(_val) IN ('0000-00-00', '0000-00-00 00:00:00', '-0001-11-30 00:00:00', '-0001-11-30 00:00:00.000000', '') THEN
-- mysql 5.7+ does not support negative datetime and empty string.
  SET _val := NULL;
END IF;
END;;
DELIMITER ;
