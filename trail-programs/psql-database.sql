create database online_pizza_order;

\c online_pizza_order;

create table order_now(
order_no int primary key,
customer_name varchar(50),
address varchar(100),
city varchar(30),
contact_no varchar(12),
veg varchar(3),
non_veg varchar(7),
order_date date,
payment_mode varchar(10),
small_quantity int,
medium_quantity int,
large_quantity int,
small_size int,
medium_size int,
large_size int,
price float
);


create table pizza(
pizza_no int primary key,
pizza_name varchar(50),
small_size_price float,
medium_size_price float,
large_size_price float,
veg varchar(3),
non_veg varchar(7),
availability_status int
);

create table admin(
admin_no int primary key,
admin_name varchar(50),
contact_no varchar(12),
email_id varchar(40)
);

create table customer_login(
customer_name varchar(50),
city varchar(40),
contact_no varchar(12)
);

create table online_payment(

);

create table cart(
pizza_name varchar(50) primary key,
pizza_size varchar(7),
location_of_order varchar(20)
);