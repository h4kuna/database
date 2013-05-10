BEGIN
DECLARE _days int signed DEFAULT 0;
DECLARE f_period mediumint(6);
DECLARE t_period mediumint(6);

IF CHAR_LENGTH(_from) IN (6, 7) THEN
    SET f_period := REPLACE(_from, '-', '');
ELSE
    SET f_period := DATE_FORMAT(_from, '%Y%m');
    SET _days := workdays(f_period) - workdays(_from) + LEAST(1, workday(_from));
    SET f_period := PERIOD_ADD(f_period, 1);
END IF;

IF CHAR_LENGTH(_to) IN (6, 7) THEN
    SET t_period := REPLACE(_to, '-', '');
ELSE
    SET t_period := PERIOD_ADD(DATE_FORMAT(_to, '%Y%m'), -1);
    SET _days := _days + workdays(_to);
END IF;

IF PERIOD_DIFF(f_period, t_period) = 2 THEN
	RETURN _days - workdays(PERIOD_ADD(t_period, 1));
END IF;

-- CALL error_raise(workdays(_to), '');

WHILE f_period <= t_period DO
    SET _days := _days + workdays(f_period);
    SET f_period := PERIOD_ADD(f_period, 1);
END WHILE;

RETURN _days;
END
