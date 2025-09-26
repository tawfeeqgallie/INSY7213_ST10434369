USE cheetah;

SELECT 
  s.staff_id,
  s.first_name,
  s.surname,
  COUNT(b.bill_id) AS deliveries_processed
FROM Staff s
JOIN Billing b ON b.staff_id = s.staff_id
GROUP BY s.staff_id, s.first_name, s.surname
ORDER BY deliveries_processed DESC, s.surname, s.first_name
