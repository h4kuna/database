-- private
DROP FUNCTION `_day`;
DELIMITER ;;
CREATE FUNCTION `_day` (`_date` date, `_day_num` tinyint(1)) RETURNS date
BEGIN
-- monday = 0, sunday = 6
DECLARE _day tinyint(1) DEFAULT DAYOFWEEK(_date);
IF(_day = 1) THEN
	SET _day := 6 - _day_num;
ELSE
	SET _day := _day - 2 - _day_num;
END IF;
RETURN DATE_SUB(_date, INTERVAL _day DAY);
END;;
DELIMITER ;

-- monday this week
DROP FUNCTION `monday`;
DELIMITER ;;
CREATE FUNCTION `monday` (`_date` date) RETURNS date
BEGIN
RETURN _day(_date, 0);
END;;
DELIMITER ;

-- sunday this week
DROP FUNCTION `sunday`;
DELIMITER ;;
CREATE FUNCTION `sunday` (`_date` date) RETURNS date
BEGIN
RETURN _day(_date, 6);
END;;
DELIMITER ;

-- tests
SELECT `sunday`('2013-04-08');
SELECT `sunday`('2013-04-07');
SELECT `sunday`('2013-04-06');
SELECT `sunday`('2013-04-05');
SELECT `sunday`('2013-04-04');
SELECT `sunday`('2013-04-03');
SELECT `sunday`('2013-04-02');
SELECT `sunday`('2013-04-01');
SELECT `sunday`('2013-03-31');