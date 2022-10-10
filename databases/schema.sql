CREATE TABLE hosts (
    id SERIAL PRIMARY KEY,
    name text,
    password text,
    email text
);

CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description TEXT,
  price numeric,
  availability text,
  host_id INT,
  constraint fk_host foreign key(host_id) references
  hosts(id)
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    space_id int,
    constraint fk_space foreign key(space_id) references 
    spaces(id),
    host_id int,
    constraint fk_host foreign key(host_id) references 
    hosts(id),
    user_id int,
    constraint fk_user foreign key(user_id) references 
    users(id),
    start_date date,
    end_date date,
    confirmed text
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  password text,
  email text
);