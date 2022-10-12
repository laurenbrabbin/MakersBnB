TRUNCATE TABLE hosts RESTART IDENTITY CASCADE;
TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE spaces RESTART IDENTITY CASCADE;
TRUNCATE TABLE bookings RESTART IDENTITY CASCADE;

INSERT INTO hosts (name, username, password, email) VALUES ('host1', 'hostusername1','password1', 'host1@email.com');
INSERT INTO hosts (name, username, password, email) VALUES ('host2', 'hostusername2','password2', 'host2@email.com');
INSERT INTO hosts (name, username, password, email) VALUES ('host3', 'hostusername3', 'password3', 'host3@email.com');

INSERT INTO spaces (name, description, price,  host_id) VALUES ('property1','description1', 100, 1);
INSERT INTO spaces (name, description, price, host_id) VALUES ('property2','description2', 200, 2);

INSERT INTO users (id, name, username, password, email) VALUES (1, 'user1', 'username1', 'password1', 'email1@email.com');
INSERT INTO users (id, name, username, password, email) VALUES (2, 'user2', 'username2', 'password2', 'email2@email.com');
INSERT INTO users (id, name, username, password, email) VALUES (3, 'user3', 'username3', 'password3', 'email3@email.com');

INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ('1', '1', '1', '2022-01-01', '2022-01-14', 'yes');
INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ('2', '2', '2', '2022-02-02', '2022-02-14', 'no');


