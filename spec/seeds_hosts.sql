TRUNCATE TABLE hosts RESTART IDENTITY CASCADE;
INSERT INTO hosts (name, username, password, email) VALUES ('host1', 'hostusername1','password1', 'host1@email.com');
INSERT INTO hosts (name, username, password, email) VALUES ('host2', 'hostusername2','password2', 'host2@email.com');
INSERT INTO hosts (name, username, password, email) VALUES ('host3', 'hostusername3', 'password3', 'host3@email.com');