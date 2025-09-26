-- Drop in dependency order (safe re-runs)
DROP TABLE IF EXISTS Driver_Deliveries;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Delivery_Item;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  surname     VARCHAR(50) NOT NULL,
  address     VARCHAR(100),
  phone_num   VARCHAR(20),
  email       VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE Staff (
  staff_id   INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  surname    VARCHAR(50) NOT NULL,
  position   VARCHAR(50),
  phone_num  VARCHAR(20),
  address    VARCHAR(100),
  email      VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE Vehicle (
  vin_number   VARCHAR(20) PRIMARY KEY,
  vehicle_type VARCHAR(50),
  mileage      INT,
  colour       VARCHAR(30),
  manufacturer VARCHAR(30)
) ENGINE=InnoDB;

CREATE TABLE Driver (
  driver_id   INT PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  surname     VARCHAR(50) NOT NULL,
  driver_code VARCHAR(10),
  phone_num   VARCHAR(20),
  address     VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE Delivery_Item (
  delivery_item_id INT PRIMARY KEY,
  description      VARCHAR(100),
  staff_id         INT NOT NULL,
  CONSTRAINT fk_di_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Driver_Deliveries (
  driver_delivery_id INT PRIMARY KEY,
  vin_number         VARCHAR(20) NOT NULL,
  driver_id          INT NOT NULL,
  delivery_item_id   INT NOT NULL,
  CONSTRAINT fk_dd_vehicle  FOREIGN KEY (vin_number) REFERENCES Vehicle(vin_number)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_dd_driver   FOREIGN KEY (driver_id)  REFERENCES Driver(driver_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_dd_item     FOREIGN KEY (delivery_item_id) REFERENCES Delivery_Item(delivery_item_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Billing (
  bill_id     INT PRIMARY KEY,
  customer_id INT NOT NULL,
  staff_id    INT NOT NULL,
  bill_date   DATE,
  CONSTRAINT fk_billing_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_billing_staff    FOREIGN KEY (staff_id)    REFERENCES Staff(staff_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

USE cheetah;

INSERT INTO Customer VALUES
(11011,'Bob','Smith','18 Water rd','0877277521','bobs@isat.com'),
(11012,'Sam','Hendricks','22 Water rd','0863257857','shen@mcom.co.za'),
(11013,'Larry','Clark','101 Summer lane','0834567891','larc@mcom.co.za'),
(11014,'Jeff','Jones','55 Mountain way','0612547895','jj@isat.co.za'),
(11015,'Andre','Kerk','5 Main rd','0827238521','akerk@mcal.co.za'),
(11016,'Wayne','Smith','13 Water rd','0877277522','ws@isat.com'),
(11017,'John','Hendricks','29 Water rd','0863257851','jhen@mcom.co.za'),
(11018,'Sally','Clark','111 Summer lane','0834567892','sallyc@mcom.co.za'),
(11019,'Bridget','Bitterhour','125 Mountain way','0612547896','bb@isat.co.za'),
(11111,'Nicole','Kerk','175 Main rd','0827238529','nk@mcal.co.za'),
(11112,'Catherine','Smith','19 Water rd','0877277523','cath@isat.com'),
(11113,'Mel','Hendricks','5 Water rd','0863257852','melh@mcom.co.za'),
(11114,'Lucy','Du Plessis','221 Summer lane','0834567892','ldup@mcom.co.za'),
(11116,'Josh','Maverick','155 Mountain way','0612547897','joshm@isat.co.za'),
(11117,'Stuart','Jones','35 Main rd','0827238521','sjones@mcal.co.za');

INSERT INTO Staff VALUES
(51011,'Sally','Du Toit','Logistics','0825698547','18 Main rd','sdut@isat.com'),
(51012,'Mark','Wright','CRM','0836984178','12 Cape Way','mwright@isat.com'),
(51013,'Harry','Sheen','Logistics','0725648965','15 Water Street','hsheen@isat.com'),
(51014,'Jabu','Xolani','Logistics','0823116598','18 White Lane','jxo@isat.com'),
(51015,'Roberto','Henry','Packaging','0783521451','55 Cape Street','rhenry@isat.com'),
(51016,'Pat','Durant','Logistics','0825698542','1 Main rd','pd@isat.com'),
(51017,'Steve','Maritz','CRM','0836984173','2 Cape Way','sm@isat.com'),
(51018,'Maxwell','Dube','Logistics','0725648964','5 Water Street','max@isat.com'),
(51019,'Shane','Mane','Logistics','0823116595','8 White Lane','smane@isat.com'),
(51111,'Bob','Truth','Packaging','0783521456','35 Cape Street','btruth@isat.com');

INSERT INTO Vehicle VALUES
('1ZA55858541','Cutaway van chassis',115352,'RED','MAN'),
('1ZA51858542','Flatbed truck',315856,'BLUE','ISUZU'),
('1ZA35858543','Medium Standard Truck',789587,'SILVER','MAN'),
('1ZA15851545','Flatbed truck',555050,'WHITE','TATA'),
('1ZA35868540','Cutaway van chassis',79058,'WHITE','ISUZU'),
('1ZA65858541','Cutaway van chassis',215352,'RED','MAN'),
('1ZA61858542','Flatbed truck',215856,'BLUE','ISUZU'),
('1ZA65858543','Medium Standard Truck',889587,'SILVER','MERC'),
('1ZA65851545','Flatbed truck',155050,'WHITE','MAN'),
('1ZA65868540','Cutaway van chassis',19058,'WHITE','ISUZU'),
('1ZA75858541','Cutaway van chassis',315352,'RED','MAN'),
('1ZA71858542','Flatbed truck',115856,'BLUE','ISUZU'),
('1ZA75858543','Medium Standard Truck',989587,'SILVER','MAN'),
('1ZA17851545','Flatbed truck',755050,'WHITE','TATA'),
('1ZA75868540','Cutaway van chassis',29058,'WHITE','ISUZU'),
('1ZA85858541','Cutaway van chassis',515352,'RED','MERC'),
('1ZA81858542','Flatbed truck',715856,'BLUE','ISUZU'),
('1ZA85858543','Medium Standard Truck',789587,'SILVER','MAN'),
('1ZA85851545','Flatbed truck',955050,'WHITE','TATA'),
('1ZA85868540','Cutaway van chassis',39058,'WHITE','MERC');

INSERT INTO Driver VALUES
(81011,'Buthelezi','Marshall','C1','0725698547','18 Leopard creek'),
(81012,'Tina','Mtati','C','0636984178','12 Cape rd'),
(81013,'Jono','Mvuyisi','EC1','0725648965','15 Circle lane'),
(81014,'Richard','Smith','C1','0623116598','18 Beach rd'),
(81015,'Brett','Smith','EB','0883521457','55 Summer lane');

INSERT INTO Delivery_Item VALUES
(71011,'House relocation',51011),
(71012,'Delivery of specialized consignments',51017),
(71013,'Delivery of specialized consignments',51015),
(71014,'Office relocation',51012),
(71015,'Delivery of specialized consignments',51014);

INSERT INTO Driver_Deliveries VALUES
(91011,'1ZA55858541',81011,71011),
(91012,'1ZA35858543',81012,71013),
(91013,'1ZA17851545',81011,71015),
(91014,'1ZA35868540',81013,71015),
(91015,'1ZA15851545',81014,71012);

INSERT INTO Billing VALUES
(800,11011,51011,'2022-09-06'),
(801,11012,51013,'2022-09-07'),
(802,11014,51015,'2022-11-10'),
(803,11015,51012,'2022-12-09'),
(804,11013,51014,'2022-12-09'),
(805,11111,51011,'2022-09-06'),
(806,11012,51013,'2022-09-07'),
(807,11014,51015,'2022-11-10'),
(808,11015,51012,'2022-12-09'),
(809,11113,51018,'2022-12-09'),
(810,11011,51011,'2022-09-06'),
(811,11012,51013,'2022-09-07'),
(812,11014,51016,'2022-11-10'),
(813,11117,51012,'2022-12-09'),
(814,11013,51014,'2022-12-09'),
(815,11012,51111,'2022-09-06'),
(816,11012,51019,'2022-09-07'),
(817,11014,51015,'2022-11-10'),
(818,11112,51012,'2022-12-09'),
(819,11013,51014,'2022-12-09'),
(820,11116,51019,'2022-12-09');

SELECT * FROM Billing LIMIT 10;