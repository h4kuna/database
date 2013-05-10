DROP FUNCTION `workdays`;
DELIMITER ;;
CREATE FUNCTION `workdays` (`_date` varchar(10)) RETURNS tinyint(2) unsigned
BEGIN
DECLARE _days tinyint(2) DEFAULT 0;
DECLARE _day tinyint(2) DEFAULT 0;
DECLARE _dayOfWeek tinyint(2) DEFAULT 0;
DECLARE _lastDay tinyint(2) DEFAULT CHAR_LENGTH(_date);

IF _lastDay <= 7 THEN
	SET _date := CONCAT(_date, IF(_lastDay = 7, '-', ''), '01');
	SET _lastDay := DAY(LAST_DAY(_date));
ELSE
	SET _lastDay := DAY(_date);
    SET _date := DATE_FORMAT(_date, '%Y-%m-01');
END IF;

WHILE _day <= _lastDay DO
    IF _day THEN
        SET _day := _day + 7;
        SET _days := _days + 5;
    ELSE
        SET _dayOfWeek := DAYOFWEEK(_date);
        IF _dayOfWeek IN (1, 7) THEN
            SET _day := _day +  2 - _dayOfWeek % 7;
        ELSE
            SET _days := 7 - _dayOfWeek;
            SET _day := _day +  _days + 2;
        END IF;
    END IF;
END WHILE;

RETURN _days + (LEAST(_lastDay - _day, -2)) + 2;
END;;
DELIMITER ;

-- tests
-- ----------------- 30
-- 22 po
SELECT `workdays`('2013-04'), `workdays`('2013-04') = 22;
-- 22 ut
SELECT `workdays`('2008-04'), `workdays`('2008-04') = 22;
-- 22 st
SELECT `workdays`('2009-04'), `workdays`('2009-04') = 22;
-- 22 ct
SELECT `workdays`('2010-04'), `workdays`('2010-04') = 22;
-- 22 pa
SELECT `workdays`('2011-04'), `workdays`('2011-04') = 21;
-- 22 so
SELECT `workdays`('2006-04'), `workdays`('2006-04') = 20;
-- 22 ne
SELECT `workdays`('2012-04'), `workdays`('2012-04') = 21;

-- ----------------- 31
-- 23
SELECT `workdays`('2006-05'), `workdays`('2006-05') = 23;
-- 23
SELECT `workdays`('2012-05'), `workdays`('2012-05') = 23;
-- 23
SELECT `workdays`('2013-05'), `workdays`('2013-05') = 23;
-- 22
SELECT `workdays`('2008-05'), `workdays`('2008-05') = 22;
-- 22
SELECT `workdays`('2009-05'), `workdays`('2009-05') = 21;
-- 22
SELECT `workdays`('2010-05'), `workdays`('2010-05') = 21;
-- 22
SELECT `workdays`('2011-05'), `workdays`('2011-05') = 22;

-- ----------------- 28
-- 20 po
SELECT `workdays`('2010-02'), `workdays`('2010-02') = 20;
-- 20 ut
SELECT `workdays`('2011-02'), `workdays`('2011-02') = 20;
-- 20 st
SELECT `workdays`('2006-02'), `workdays`('2006-02') = 20;
-- 20 ct
SELECT `workdays`('2007-02'), `workdays`('2007-02') = 20;
-- 20 pa
SELECT `workdays`('2013-02'), `workdays`('2013-02') = 20;
-- 20 so
SELECT `workdays`('2003-02'), `workdays`('2003-02') = 20;
-- 20 ne
SELECT `workdays`('2009-02'), `workdays`('2009-02') = 20;


-- ----------------- 29
-- 21 po
SELECT `workdays`('1988-02'), `workdays`('1988-02') = 21;
-- 21 ut
SELECT `workdays`('2000-02'), `workdays`('2000-02') = 21;
-- 21 st
SELECT `workdays`('2012-02'), `workdays`('2012-02') = 21;
-- 21 ct
SELECT `workdays`('1994-02'), `workdays`('1994-02') = 20;
-- 21 pa
SELECT `workdays`('2008-02'), `workdays`('2008-02') = 21;
-- 20 so
SELECT `workdays`('1992-02'), `workdays`('1992-02') = 20;
-- 20 ne
SELECT `workdays`('2004-02'), `workdays`('2004-02') = 20;


SELECT `workdays`('2013-04-01'), `workdays`('2013-04-01') = 1;

SELECT `workdays`('2013-04-02'), `workdays`('2013-04-02') = 2;

SELECT `workdays`('2013-04-03'), `workdays`('2013-04-03') = 3;

SELECT `workdays`('2013-04-04'), `workdays`('2013-04-04') = 4;

SELECT `workdays`('2013-04-05'), `workdays`('2013-04-05') = 5;

SELECT `workdays`('2013-04-06'), `workdays`('2013-04-06') = 5;

SELECT `workdays`('2013-04-07'), `workdays`('2013-04-07') = 5;

SELECT `workdays`('2013-04-08'), `workdays`('2013-04-08') = 6;