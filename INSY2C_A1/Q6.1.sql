USE cheetah;

UPDATE Vehicle
SET colour = CONCAT(UCASE(LEFT(colour,1)), LCASE(SUBSTRING(colour,2)))
WHERE UPPER(colour) = 'SILVER';

SELECT ROW_COUNT() AS rows_affected;

DELIMITER $$

DROP PROCEDURE IF EXISTS List_Driver_Trips $$
CREATE PROCEDURE List_Driver_Trips()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_id INT;
  DECLARE v_fn VARCHAR(50);
  DECLARE v_sn VARCHAR(50);
  DECLARE v_trips INT;

  DECLARE cur CURSOR FOR
    SELECT d.driver_id, d.first_name, d.surname,
           (SELECT COUNT(*) FROM Driver_Deliveries dd WHERE dd.driver_id = d.driver_id) AS trips
    FROM Driver d
    ORDER BY d.surname, d.first_name;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_id, v_fn, v_sn, v_trips;
    IF done = 1 THEN LEAVE read_loop; END IF;

    SELECT CONCAT('Driver ', v_fn, ' ', v_sn, ' (ID ', v_id, ') trips: ', v_trips) AS msg;
  END LOOP;
  CLOSE cur;
END $$
DELIMITER ;

CALL List_Driver_Trips();

 