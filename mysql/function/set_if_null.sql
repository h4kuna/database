DROP PROCEDURE `set_if_null`;
DELIMITER ;;
CREATE PROCEDURE `set_if_null` (INOUT `_variable` text, IN `_value` text)
BEGIN
CALL null_default(_variable);
IF _variable IS NULL THEN
	SET _variable := _value;
END IF;
END;;
DELIMITER ;
