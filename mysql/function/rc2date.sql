DELIMITER ;;
CREATE FUNCTION `rc2date` (`_rc` varchar(12)) RETURNS date
NO SQL
    DETERMINISTIC
BEGIN
declare day int;
declare year int;
declare month int;
declare len int;

SET len := CHAR_LENGTH(_rc);

IF len < 10 THEN
	RETURN NULL;
END IF;

SET year := SUBSTRING(_rc, 1, 2);
SET month := SUBSTRING(_rc, 3, 2);
SET day := SUBSTRING(_rc, 5, 2);

IF year < 54 AND CHAR_LENGTH(_rc) > 10 AND year <= YEAR(CURDATE())-2000 THEN
	SET year := year + 2000;
ELSE
	SET year := year + 1900;
END IF;

IF month > 70 AND year > 2003 THEN
	SET month := month - 70;
ELSEIF month > 50 THEN
	SET month := month - 50;
ELSEIF month > 20 AND year > 2003 THEN
	SET month := month - 20;
END IF;

RETURN DATE(CONCAT_WS('-', year, month, day));
END;;
DELIMITER ;