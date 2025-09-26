USE cheetah;

CREATE OR REPLACE VIEW Staff_Delivery_Count AS
SELECT 
  s.staff_id,
  s.first_name,
  s.surname,
  COUNT(b.bill_id) AS delivery_count
FROM Staff s
LEFT JOIN Billing b ON b.staff_id = s.staff_id
GROUP BY s.staff_id, s.first_name, s.surname;

SELECT * 
FROM Staff_Delivery_Count
ORDER BY delivery_count DESC, surname, first_name;
