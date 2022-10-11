<<<<<<< HEAD:spec/seeds_bookings.sql
TRUNCATE TABLE bookings, spaces, hosts, users RESTART IDENTITY CASCADE;
=======
TRUNCATE TABLE bookings RESTART IDENTITY CASCADE;
TRUNCATE TABLE spaces RESTART IDENTITY CASCADE;
TRUNCATE TABLE hosts RESTART IDENTITY CASCADE;
TRUNCATE TABLE users RESTART IDENTITY CASCADE;

INSERT INTO hosts (name, password, email) VALUES ('host1', 'password1', 'host1@email.com');
INSERT INTO hosts (name, password, email) VALUES ('host2', 'password2', 'host2@email.com');
INSERT INTO hosts (name, password, email) VALUES ('host3', 'password3', 'host3@email.com');

INSERT INTO users (name, password, email) VALUES ('user1', 'password1', 'email1@email.com');
INSERT INTO users (name, password, email) VALUES ('user2', 'password2', 'email2@email.com');
INSERT INTO users (name, password, email) VALUES ('user3', 'password3', 'email3@email.com');

INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property1','description1', 1, 'available', 1);
INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property2','description2', 12, 'not available', 2);

>>>>>>> 7898ef9fae5301c64367c6387dc5496b23fae077:databases/seeds_bookings.sql
INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ('1', '1', '1', '2022-01-01', '2022-01-14', 'yes');
INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ('2', '2', '2', '2022-02-02', '2022-02-14', 'no');


-- INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property1','description1', 1, 'available', 1);
-- INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property2','description2', 12, 'not available', 2);


-- INSERT INTO hosts (name, password, email) VALUES ('host1', 'password1', 'host1@email.com');
-- INSERT INTO hosts (name, password, email) VALUES ('host2', 'password2', 'host2@email.com');
-- INSERT INTO hosts (name, password, email) VALUES ('host3', 'password3', 'host3@email.com');


-- INSERT INTO users (name, password, email) VALUES ('user1', 'password1', 'email1@email.com');
-- INSERT INTO users (name, password, email) VALUES ('user2', 'password2', 'email2@email.com');
-- INSERT INTO users (name, password, email) VALUES ('user3', 'password3', 'email3@email.com');




