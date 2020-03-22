-- Drop and Create the Database, DDL

drop database if exists prs_db;
create database prs_db;
use prs_db;

-- DDL - Create Tables
create table User (
	ID				int 			primary key auto_increment,
	UserName 	    VARCHAR(20)			not null unique,
	Password 		VARCHAR(10) 	    not null,
	FirstName 		VARCHAR(20) 	    not null,
    LastName 	    VARCHAR(20) 		not null,
	PhoneNumber		VARCHAR(12) 	    not null,
	Email 			VARCHAR(75) 	    not null,
	IsReviewer       TinyInt		    not null,
	IsAdmin 		 TinyInt		    not null
	);

create table Vendor (
	ID 				int 			not null primary key auto_increment,
	Code 		    VARCHAR(10)		not null unique,
	Name 			VARCHAR(255)	not null,
	Address 		VARCHAR(255) 	not null,
	City 		    VARCHAR(255)	not null,
    State           VARCHAR(2)      not null,
    Zip				VARCHAR(5)      not null,
    PhoneNumber		VARCHAR(12)     not null,
    Email			VARCHAR(100)    not null
	);


create table Request (
	ID 				INT 			not null primary key auto_increment,
	UserID		    INT 			not null,
	Description		VARCHAR(100)	not null,
	Justification   VARCHAR(255)    not null,
    DateNeeded		DATE			not null,
    DeliveryMode	VARCHAR(25)     not null,
    Status			VARCHAR(25)     not null,
    Total			DECIMAL(10,2)   not null,
    SubmittedDate	DATETIME        not null,
    ReasonForRejection VARCHAR(100),
	FOREIGN KEY (UserID) REFERENCES user(ID)
    );
    
    create table Product (
	ID 				INT 			not null primary key auto_increment,
	VendorID		    INT 		not null,
	PartNumber		VARCHAR(50)	    not null,
	Name            VARCHAR(150)    not null,
    Price		    DECIMAL(10,2)   not null,
    Unit      	    VARCHAR(255),
    PhotoPath	    VARCHAR(255),
    FOREIGN KEY (VendorID) REFERENCES vendor(ID),
    CONSTRAINT vendor_part unique (VendorID, PartNumber)
    );
    
    create table LineItem (
	ID 				INT 			not null primary key auto_increment,
	RequestID	    INT 		    not null unique,
	ProductID		INT	            not null unique,
	Quantity        INT             not null,
    FOREIGN KEY (ProductID) REFERENCES product(ID),
    FOREIGN KEY (RequestID) REFERENCES request(ID),
    CONSTRAINT req_pdt unique (RequestID, ProductID)
    );
    
    
-- DML Insert User Data

insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin) 
	values (838, 'GWashington', 'gw838', 'George', 'Washington', '202-123-4568', 'gwashington@founding.org', 0, 1);
insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin) 
	values (623, 'AHamilton', 'aw623', 'Alexander', 'Hamilton', '202-123-5678', 'ahamilton@founding.org', 1, 0);
insert into User (ID, UserName, Password, FirstName, LastName, PhoneNumber, Email, IsReviewer, IsAdmin) 
	values (259,'BFranklin', 'bf259', 'Benjamin', 'Franklin', '202-123-6789', 'bfranklin@founding.org', 0, 0);



-- DDL Insert Vendor Data

insert into Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values (1, 'OD3374', 'Office Depot', '3990 Montgomery Rd', 'Loveland', 'OH', '45140', '513-360-6358', 'officedepot.com');
insert into Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values (2, 'BB460', 'Best Buy', '9871 Waterstone BLVD', 'Cincinnati', 'OH', '45249', '513-683-7777', 's-000494-Leaders@bestbuy.com');  
insert into Vendor (ID, Code, Name, Address, City, State, Zip, PhoneNumber, Email)
	values (3, 'ST0531', 'Staples', '9550 S. Mason Montgomery Rd', 'Mason', 'OH', '45040', '513-754-0235', 'staples.com'); 
    
    
    
    -- DDL Insert Request Data

insert into Request (ID, UserID, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate)
	values (1, 623, 'Headset', 'Need for conference calls', '2020-05-10', 'Ship', 'In process', 27.43, '2020-03-10');
insert into Request (ID, UserID, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate)
	values (2, 838, 'Laptop', 'Laptop not working', '2020-03-25', 'Pick-up', 'Approved', 629.99, '2020-03-20');  
insert into Request (ID, UserID, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate)
	values (3, 259, 'Apple Pencil', 'My finger is tired', '2020-03-30', 'Ship', 'Denied', 129.00, '2020-03-20'); 
insert into Request (ID, UserID, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate)
    values (4, 623, 'Camera Cover', 'Block spies', '2020-03-21', 'Pick-up', 'Approved', 9.29, '2020-03-20');
insert into Request (ID, UserID, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate)
    values (5, 259, 'Anti-glare Screen Filter', 'Eyesight strain', '2020-03-29', 'Ship', 'Approved', 69.99, '2020-03-12');
 insert into Request (ID, UserID, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate)
    values (6, 623, 'Electronic Notebook', 'Need to transfer notes digitally', '2020-04-05', 'Ship', 'In process', 33.99, '2020-03-17');


-- DDL Insert Product Data

insert into Product (ID, VendorID, PartNumber, Name, Price)
	values (1, 3, 'MU8F2AM/A', 'Apple Pencil', 129.00);
insert into Product (ID, VendorID, PartNumber, Name, Price)
	values (2, 3, 'SWVPBLST', 'C Slide Webcam Cover', 9.29); 
insert into Product (ID, VendorID, PartNumber, Name, Price)
	values (3, 3, 'PZ3-00001', 'Microsoft 850 Wireless Keyboard-Black', 27.43); 
insert into Product (ID, VendorID, PartNumber, Name, Price)  
    values (4, 2, 'NS-PAH5205', 'Insignia On Ear Stereo Headset-Black', 19.99);
insert into Product (ID, VendorID, PartNumber, Name, Price)
    values (5, 1, 'AG240W1BEA', '3M Anti-Glare Screen Filter', 69.99);
insert into Product (ID, VendorID, PartNumber, Name, Price)
    values (6, 1, '910-002650', 'Logitech M325 Wireless Mouse-Black', 21.69);
insert into Product (ID, VendorID, PartNumber, Name, Price)
    values (7, 1, 'DPNXL', 'Dust-Off XL Special Application Compressed Gas Aerosol Cleaner-10oz', 26.19);
insert into Product (ID, VendorID, PartNumber, Name, Price)
    values (8, 2, '17-CA1031DX', 'HP-17.3 Laptop AMD Ryzen7-JetBlack', 629.99);
insert into Product (ID, VendorID, PartNumber, Name, Price)
    values (9, 2, 'EVR-L-R', 'Rocket Innovations-Everlast 8.5X11 Notebook-InfinityBlack', 33.99);
insert into Product (ID, VendorID, PartNumber, Name, Price)
    values (10, 3, 'TP9000-BLK', 'Tempur-Pedict TP900 Mesh Task Chair-Black', 308.99);

    
    -- DDL Insert LineItem Data

insert into LineItem (ID, RequestID, ProductID, Quantity)
	values (1, 1, 4, 1);
insert into LineItem (ID, RequestID, ProductID, Quantity)
	values (2, 2, 3, 1);  
insert into LineItem (ID, RequestID, ProductID, Quantity)
	values (3, 3, 1, 1); 
insert into LineItem (ID, RequestID, ProductID, Quantity)
    values (4, 4, 2, 1);
insert into LineItem (ID, RequestID, ProductID, Quantity)
    values (5, 5, 5, 1);
insert into LineItem (ID, RequestID, ProductID, Quantity)
    values (6, 6, 9, 1);