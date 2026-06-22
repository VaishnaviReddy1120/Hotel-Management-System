-- ================================================================
--  FILE 1 : schema.sql
--  Hotel Management System
--  Creates the database and all 7 tables
-- ================================================================

CREATE DATABASE IF NOT EXISTS HotelDB;
USE HotelDB;

-- ----------------------------------------------------------------
-- TABLE 1 : Guests
-- Stores information about hotel guests
-- ----------------------------------------------------------------
CREATE TABLE Guests (
    guest_id   INT          AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    phone      VARCHAR(15)  NOT NULL UNIQUE,
    email      VARCHAR(100) UNIQUE,
    city       VARCHAR(50)
);

-- ----------------------------------------------------------------
-- TABLE 2 : Rooms
-- Stores room details and availability
-- ----------------------------------------------------------------
CREATE TABLE Rooms (
    room_id          INT           AUTO_INCREMENT PRIMARY KEY,
    room_type        VARCHAR(50)   NOT NULL,   -- Single | Double | Suite
    price_per_night  DECIMAL(8,2)  NOT NULL,
    status           ENUM('Available','Booked') NOT NULL DEFAULT 'Available'
);

-- ----------------------------------------------------------------
-- TABLE 3 : Staff
-- Stores hotel employee details
-- ----------------------------------------------------------------
CREATE TABLE Staff (
    staff_id    INT          AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    role        VARCHAR(50)  NOT NULL,   -- Receptionist | Housekeeping | Manager
    phone       VARCHAR(15)  UNIQUE
);

-- ----------------------------------------------------------------
-- TABLE 4 : Reservations
-- Links guests to rooms with check-in and check-out dates
-- ----------------------------------------------------------------
CREATE TABLE Reservations (
    reservation_id  INT  AUTO_INCREMENT PRIMARY KEY,
    guest_id        INT  NOT NULL,
    room_id         INT  NOT NULL,
    check_in_date   DATE NOT NULL,
    check_out_date  DATE NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id)  REFERENCES Rooms(room_id)
);

-- ----------------------------------------------------------------
-- TABLE 5 : Payments
-- Stores payment made against a reservation
-- ----------------------------------------------------------------
CREATE TABLE Payments (
    payment_id      INT            AUTO_INCREMENT PRIMARY KEY,
    reservation_id  INT            NOT NULL,
    amount          DECIMAL(10,2)  NOT NULL,
    payment_date    DATE           NOT NULL,
    payment_mode    VARCHAR(20)    NOT NULL,   -- Cash | Card | UPI
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);

-- ----------------------------------------------------------------
-- TABLE 6 : Services
-- Hotel services like Spa, Laundry, Gym etc.
-- ----------------------------------------------------------------
CREATE TABLE Services (
    service_id    INT           AUTO_INCREMENT PRIMARY KEY,
    service_name  VARCHAR(100)  NOT NULL,
    price         DECIMAL(8,2)  NOT NULL
);

-- ----------------------------------------------------------------
-- TABLE 7 : Service_Usage
-- Tracks which guest used which service, handled by which staff
-- ----------------------------------------------------------------
CREATE TABLE Service_Usage (
    usage_id    INT  AUTO_INCREMENT PRIMARY KEY,
    guest_id    INT  NOT NULL,
    service_id  INT  NOT NULL,
    staff_id    INT  NOT NULL,
    usage_date  DATE NOT NULL,
    FOREIGN KEY (guest_id)   REFERENCES Guests(guest_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (staff_id)   REFERENCES Staff(staff_id)
);

-- ----------------------------------------------------------------
-- INDEXES — speeds up frequently searched columns
-- ----------------------------------------------------------------
CREATE INDEX idx_guest_phone  ON Guests(phone);
CREATE INDEX idx_res_room     ON Reservations(room_id);
CREATE INDEX idx_res_guest    ON Reservations(guest_id);

-- ================================================================
--  schema.sql complete
-- ================================================================
