DROP FUNCTION `year_week`;
DELIMITER ;;
CREATE FUNCTION `year_week` (`_date` date) RETURNS varchar(7) CHARACTER SET 'utf8'
NO SQL
    DETERMINISTIC
BEGIN
RETURN DATE_FORMAT(_date, '%x-%v');
END;;
DELIMITER ;

-- example different
SET @date := '2012-12-31';
SELECT DATE_FORMAT(@date, '%x-%v, %Y-%u');