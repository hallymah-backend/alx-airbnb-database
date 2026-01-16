SELECT users.user_id, users.email
   FROM users 
   INNER JOIN Property
   ON users.user_id = property.host_id;
--    WHERE LOWER(last_name) = LOWER('olakitan')
-- ORDER BY  email DESC;

