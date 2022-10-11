TRUNCATE TABLE spaces RESTART IDENTITY CASCADE;
<<<<<<< HEAD:spec/seeds_spaces.sql
INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property1','description1', 1, 'available' 1);
INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property2','description2', 12, 'not available' 2);

TRUNCATE TABLE hosts RESTART IDENTITY CASCADE;
=======
TRUNCATE TABLE hosts RESTART IDENTITY CASCADE ;


>>>>>>> 7898ef9fae5301c64367c6387dc5496b23fae077:databases/seeds_spaces.sql
INSERT INTO hosts (name, password, email) VALUES ('host1', 'password1', 'host1@email.com');
INSERT INTO hosts (name, password, email) VALUES ('host2', 'password2', 'host2@email.com');
INSERT INTO hosts (name, password, email) VALUES ('host3', 'password3', 'host3@email.com');

INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property1','description1', 1, 'available', 1);
INSERT INTO spaces (name, description, price, availability, host_id) VALUES ('property2','description2', 12, 'not available', 2);

