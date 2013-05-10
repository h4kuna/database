DROP FUNCTION `in_date_range`;
DELIMITER ;;
CREATE FUNCTION `in_date_range` (`_from` date, `_to` date) RETURNS tinyint(1) unsigned
BEGIN
IF (_from IS NULL AND _to <= CURDATE()) OR (_to IS NULL AND _from <= CURDATE()) OR (CURDATE() BETWEEN _from AND _to) THEN
	RETURN 1;
END IF;
RETURN 0;
END;;
DELIMITER ;

-- tests
SELECT in_date_range(NULL, CURDATE());
SELECT in_date_range(CURDATE(), NULL);
SELECT in_date_range('2013-04-01', NULL);
SELECT in_date_range('2099-04-01', NULL) = 0;
SELECT in_date_range('2010-04-01', '2099-04-01');