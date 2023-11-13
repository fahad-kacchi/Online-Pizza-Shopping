/*
    Online-Pizza-Shopping
    Table Names:
    1) customer
    2) admin
    3) pizza
    4) order_now
    5) add_to_cart
    6) bill
    7) payment
*/

create database online_pizza_shopping;
\c online_pizza_shopping

create table customer(
cust_no varchar(10) primary key,
name varchar(50),
email varchar(50),
password varchar(50),
confirmPassword varchar(50)
);

create table admin(
name varchar(50),
email varchar(50),
password varchar(50),
confirmPassword varchar(50)
);

insert into admin values('ABC XYZ', 'admin@gmail.com', '123', '123');

create table pizza(
pizza_no varchar(10) primary key,
pizza_name varchar(30),
small_size_status int,
medium_size_status int,
large_size_status int,
small_price float,
medium_price float,
large_price float,
veg_non_veg_status int
);

create table order_now(
order_no varchar(10) primary key,
full_name varchar(60),
address varchar(100),
city varchar(40),
contact_no varchar(10),
small_pizza_final_price varchar(100),
medium_pizza_final_price varchar(100),
large_pizza_final_price varchar(100),
price varchar(100),
payment_mode varchar(20),
pizza_no varchar(100)
);

create table add_to_cart(
add_to_cart_no varchar(10) primary key,
pizza_no varchar(10) references pizza on delete cascade on update cascade
);

create table payment(
payment_no varchar(10) primary key,
card_no varchar(16),
expiry_month int,
expiry_year int,
cvv_code int,
order_no varchar(10) references order_now on delete cascade on update cascade
);

create table feedback_details(
feedbackno varchar(10) primary key,
fullname varchar(100),
email varchar(30),
feedback_message varchar(400)
);

create table temp_pizza_quantity(
id serial,
pizza_no varchar(10),
pizza_name varchar(100),
small_pizza_quantity int,
medium_pizza_quantity int,
large_pizza_quantity int,
count_of_pizza int
);


insert into pizza values('P1','Margherita',1,2,3,99,195,395,0);
insert into pizza values('P2','Double Cheese Margherita',1,2,3,155,295,445,0);
insert into pizza values('P3','Cheese n Corn',1,2,3,155,295,445,0);
insert into pizza values('P4','Paneer Makhani',1,2,3,155,295,445,0);
insert into pizza values('P5','Fresh Veggie',1,2,3,155,295,445,0);
insert into pizza values('P6','Peppy Paneer',1,2,3,195,365,545,0);
insert into pizza values('P7','Framhouse',1,2,3,195,365,545,0);
insert into pizza values('P8', 'Veggie Paradise',1,2,3,195,365,545,0);
insert into pizza values('P9', 'Pepper',1,2,3,230,440,655,0);
insert into pizza values('P10','Veg Extravaganza',1,2,3,230,440,655,0);
insert into pizza values('P11','Delux Veggie',1,2,3,230,440,655,0);

insert into pizza values('P12','Regular Medium',1,2,3,155,295,455,1);
insert into pizza values('P13','Pepper Barbecue',1,2,3,155,295,455,1);
insert into pizza values('P14','Chicken Sausage',1,2,3,155,295,455,1);
insert into pizza values('P15','Chiken Tikka',1,2,3,195,365,545,1);
insert into pizza values('P16','Peri Peri Chicken',1,2,3,195,365,545,1);
insert into pizza values('P17','Chicken Fiesta',1,2,3,230,440,655,1);
 
