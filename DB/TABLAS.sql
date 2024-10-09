USE Integrador
create table Users (
user_id int primary key Identity (1,1),
username varchar (100) not null,
full_name varchar(150),
email varchar(150) not null,
password_hash varchar(255),
user_role varchar(50) not null,
registration_date date default GETDATE()
);

create table MYCattle(
catle_id int primary key identity (1,1),
user_id int not null,
cow_name varchar(100) not null,
cow_breed varchar(100),
birth_date date,
health_status varchar(50),
last_checkup_date date,
farm_id int,
Foreign key (user_id) references Users(user_id),
Foreign key (farm_id) references Farm(farm_id)
);