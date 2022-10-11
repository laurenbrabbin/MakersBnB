TRUNCATE TABLE users RESTART IDENTITY CASCADE;
INSERT INTO users (id, name, username, password, email) VALUES (1, 'user1', 'username1', 'password1', 'email1@email.com');
INSERT INTO users (id, name, username, password, email) VALUES (2, 'user2', 'username2', 'password2', 'email2@email.com');
INSERT INTO users (id, name, username, password, email) VALUES (3, 'user3', 'username3', 'password3', 'email3@email.com');