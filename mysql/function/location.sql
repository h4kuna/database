-- private
DROP FUNCTION `_location`;
DELIMITER ;;
CREATE FUNCTION `_location` (`start_lat` float(10,6), `start_lng` float(10,6), `end_lat` float(10,6), `end_lng` float(10,6), `unit_constant` smallint(4) unsigned) RETURNS float(10,6)
NO SQL
    DETERMINISTIC
BEGIN
-- constant 3959 for mile and for kilometrs 6371
RETURN ( unit_constant * acos( cos( radians(start_lat) ) * cos( radians( end_lat ) ) * cos( radians( end_lng ) - radians(start_lng) ) + sin( radians(start_lat) ) * sin( radians( end_lat ) ) ) );
END;;
DELIMITER ;

-- vzdálenost v km
DROP FUNCTION `location_km`;
DELIMITER ;;
CREATE FUNCTION `location_km` (`start_lat` float(10,6), `start_lng` float(10,6), `end_lat` float(10,6), `end_lng` float(10,6)) RETURNS float(10,6)
NO SQL
    DETERMINISTIC
BEGIN
RETURN _location(start_lat, start_lng, end_lat, end_lng, 6371);
END;;
DELIMITER ;

-- vzdálenost v mílích
DROP FUNCTION `location_ml`;
DELIMITER ;;
CREATE FUNCTION `location_ml` (`start_lat` float(10,6), `start_lng` float(10,6), `end_lat` float(10,6), `end_lng` float(10,6)) RETURNS float(10,6)
NO SQL
    DETERMINISTIC
BEGIN
RETURN _location(start_lat, start_lng, end_lat, end_lng, 3959);
END;;
DELIMITER ;
