
DROP FUNCTION `workday_of_week`;
DELIMITER ;;
CREATE FUNCTION `workday_of_week` (`_day` date, `_left` tinyint(1) unsigned) RETURNS tinyint(1) unsigned
BEGIN
DECLARE _days tinyint(1) DEFAULT (DAYOFWEEK(_day) - 1) % 6;
DECLARE _actualDay tinyint(1);

IF _left THEN
    SET _actualDay := DAY(_day);
    IF _days THEN
        RETURN LEAST(_days, _actualDay);
    END IF;

    RETURN LEAST(5, _actualDay);
END IF;


IF _days THEN
    RETURN 6 - _days;
END IF;
RETURN 0;
END;;
DELIMITER ;