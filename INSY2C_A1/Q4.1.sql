USE cheetah;

SELECT 
  CONCAT(d.first_name, ', ', d.surname) AS DRIVER,
  d.driver_code                           AS CODE,
  v.vin_number                            AS `VIN NUMBER`,
  v.mileage                               AS MILEAGE
FROM Driver d
JOIN Driver_Deliveries dd ON dd.driver_id = d.driver_id
JOIN Vehicle v            ON v.vin_number = dd.vin_number
WHERE v.mileage < 80000
ORDER BY v.mileage ASC, d.surname, d.first_name;
