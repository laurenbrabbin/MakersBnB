TRUNCATE TABLE bookings, spaces, hosts, users RESTART IDENTITY CASCADE;
INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ('1', '1', '1', '2022-01-01', '2022-01-14', 'yes');
INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ('2', '2', '2', '2022-02-02', '2022-02-14', 'no');