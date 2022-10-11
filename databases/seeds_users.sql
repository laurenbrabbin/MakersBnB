TRUNCATE TABLE users RESTART IDENTITY CASCADE;
INSERT INTO users (name, password, email) VALUES ('user1', 'password1', 'email1@email.com');
INSERT INTO users (name, password, email) VALUES ('user2', 'password2', 'email2@email.com');
INSERT INTO users (name, password, email) VALUES ('user3', 'password3', 'email3@email.com');