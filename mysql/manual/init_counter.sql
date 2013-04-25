DROP PROCEDURE `categories_count_init`;
DELIMITER ;;
CREATE PROCEDURE `categories_count_init` ()
BEGIN

DECLARE _id INT;
DECLARE _count INT;
DECLARE done INT DEFAULT FALSE;
DECLARE cur1 CURSOR FOR SELECT categories_id, COUNT(*) AS count FROM `goods` GROUP BY categories_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

UPDATE categories SET goods_counter = 0;

OPEN cur1;
read_loop: LOOP
  FETCH cur1 INTO _id, _count;

  IF done THEN
    LEAVE read_loop;
  END IF;

UPDATE categories SET goods_counter = _count WHERE id = _id;
END LOOP;

CLOSE cur1;
END;;
DELIMITER ;
