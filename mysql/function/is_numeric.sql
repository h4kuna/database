DROP FUNCTION `is_numeric`;
DELIMITER ;;
CREATE FUNCTION `is_numeric` (`_number` varchar(20)) RETURNS tinyint(1) unsigned
BEGIN
RETURN IFNULL(_number REGEXP '^-?[0-9]+(\.[0-9]*)?$', 0);
END;;
DELIMITER ;

-- test
SELECT is_numeric(NULL) = 0;
SELECT is_numeric('ahoj') = 0;
SELECT is_numeric('') = 0;
SELECT is_numeric(' 0') = 0;
SELECT is_numeric(0) = 1;
SELECT is_numeric('0') = 1;
SELECT is_numeric('0.0') = 1;
SELECT is_numeric('00.00') = 1;
SELECT is_numeric('-0') = 1;
SELECT is_numeric('0001') = 1;
SELECT is_numeric('1.') = 1;
