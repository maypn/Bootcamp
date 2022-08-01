-- Table 1: Menu

create table Menu (
    Menu_id int,
    Name TEXT,
    Type TEXT,
    Price REAL,
    primary key (Menu_id)
);

insert into Menu values
    (1, "French fries", "Appetizers", 70),
    (2, "Onion ring", "Appetizers", 80),
    (3, "Hash browns", "Appetizers", 80),
    (4, "Nuggets", "Appetizers", 90),
    (5, "Caramel sundae", "Desserts", 30),
    (6, "Chocolate brownie", "Desserts", 50),
    (7, "Corn pie", "Desserts", 30),
    (8, "Black coffee", "Beverages", 40),
    (9, "Orange juice", "Beverages", 40),
    (10, "Ice lemon tea", "Beverages",  30);

-- Table 2: Staff

create table Staffs (
    Staff_id TEXT,
    Firstname TEXT,
    Position TEXT,
    primary key (Staff_id)
);

insert into Staffs values
    ("T01", "Lee", "Cashier"),
    ("T02", "Nicole", "Cashier"),
    ("T03", "Ben", "Cashier"),
    ("T04", "Emma", "Cashier"),
    ("T05", "Chris", "Chef"),
    ("T06", "Kate", "Chef"),
    ("T07", "Scarlett", "Assistant manager"),
    ("T08", "Morgan", "Manager");

-- Table 3: Invoices

create table Invoices (
    Invoice_id TEXT,
    Customer_id int,
    Total real,
    Cashier_id TEXT,
    primary key (Invoice_id),
    foreign key (Customer_id) references Customers(Customer_id),
    foreign key (Cashier_id) references Staffs(Staff_id)
);

insert into Invoices values
    ("INV-01", 1, 100, "T01"),
    ("INV-02", 4, 80, "T03"),
    ("INV-03", 4, 150, "T03"),
    ("INV-04", 5, 340, "T03"),
    ("INV-05", 9, 210, "T01"),
    ("INV-06", 2, 560, "T02"),
    ("INV-07", 6, 200, "T04"),
    ("INV-08", 3, 250, "T04"),
    ("INV-09", 9, 190, "T02"),
    ("INV-10", 8, 240, "T02"),
    ("INV-11", 7, 490, "T04"),
    ("INV-12", 7, 50, "T04");

-- Table 4: Orders

create table Orders (
    Order_id int,
    Invoice_id TEXT,
    Menu_id int,
    Quantity int,
    primary key (Order_id),
    foreign key (Invoice_id) references Invoices(Invoice_id),
    foreign key (Menu_id) references Menu(Menu_id)
);

insert into Orders values
    (1, "INV-01", 10, 2),
    (2, "INV-02", 10, 1),
    (3, "INV-03", 9, 2),
    (4, "INV-04", 8, 3),
    (5, "INV-05", 7, 4),
    (6, "INV-06", 6, 1),
    (7, "INV-07", 5, 1),
    (8, "INV-08", 4, 2),
    (9, "INV-09", 3, 2),
    (10, "INV-10", 2, 1),
    (11, "INV-11", 2, 1),
    (12, "INV-12", 1, 2);

-- Table 5: Customers

create table Customers (
    Customer_id int,
    firstname TEXT,
    primary key (Customer_id)
);

insert into Customers values
    (1, "Tom"),
    (2, "Alexandra"),
    (3, "Zoe"),
    (4, "Mark"),
    (5, "Matt"),
    (6, "Natalie"),
    (7, "Nina"),
    (8, "Matthew"),
    (9, "Leonardo");
