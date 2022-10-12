TRUNCATE TABLE spaces RESTART IDENTITY CASCADE;
TRUNCATE TABLE hosts RESTART IDENTITY CASCADE;

INSERT INTO hosts (name, username, password, email) VALUES ('host1', 'hostusername1','password1', 'host1@email.com');
INSERT INTO hosts (name, username, password, email) VALUES ('host2', 'hostusername2','password2', 'host2@email.com');
INSERT INTO hosts (name, username, password, email) VALUES ('host3', 'hostusername3', 'password3', 'host3@email.com');

INSERT INTO spaces (name, description, price,  host_id) VALUES ('property1','description1', 100, 1);
INSERT INTO spaces (name, description, price, host_id) VALUES ('property2','description2', 200, 2);




