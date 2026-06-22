-- ================================================================
--  FILE 2 : data.sql
--  Hotel Management System
--  Inserts sample data into all 7 tables
-- ================================================================

USE HotelDB;

-- ----------------------------------------------------------------
-- Guests
-- ----------------------------------------------------------------
INSERT INTO Guests (name, phone, email, city) VALUES
    ('Arjun Sharma',  '9876543210', 'arjun@gmail.com',  'Bangalore'),
    ('Priya Nair',    '9123456780', 'priya@gmail.com',   'Chennai'),
    ('Rohit Verma',   '9988776655', 'rohit@gmail.com',   'Mumbai'),
    ('Sneha Patel',   '9001122334', 'sneha@gmail.com',   'Ahmedabad'),
    ('Karan Mehta',   '9445566778', 'karan@gmail.com',   'Delhi');

-- ----------------------------------------------------------------
-- Rooms
-- ----------------------------------------------------------------
INSERT INTO Rooms (room_type, price_per_night) VALUES
    ('Single',  1200.00),
    ('Single',  1200.00),
    ('Double',  2500.00),
    ('Double',  2500.00),
    ('Suite',   5000.00),
    ('Suite',   5500.00);

-- ----------------------------------------------------------------
-- Staff
-- ----------------------------------------------------------------
INSERT INTO Staff (name, role, phone) VALUES
    ('Ravi Kumar',    'Receptionist',  '9111222333'),
    ('Meena Sinha',   'Housekeeping',  '9222333444'),
    ('Suresh Babu',   'Manager',       '9333444555'),
    ('Anita Rao',     'Spa Therapist', '9444555666');

-- ----------------------------------------------------------------
-- Reservations
-- (Trigger in features.sql will auto-update room status to Booked)
-- ----------------------------------------------------------------
INSERT INTO Reservations (guest_id, room_id, check_in_date, check_out_date) VALUES
    (1, 1, '2026-08-01', '2026-08-03'),
    (2, 3, '2026-08-05', '2026-08-08'),
    (3, 5, '2026-08-10', '2026-08-12'),
    (4, 2, '2026-08-15', '2026-08-17');

-- ----------------------------------------------------------------
-- Payments
-- ----------------------------------------------------------------
INSERT INTO Payments (reservation_id, amount, payment_date, payment_mode) VALUES
    (1,  2400.00, '2026-08-01', 'UPI'),    -- 2 nights x 1200
    (2,  7500.00, '2026-08-05', 'Card'),   -- 3 nights x 2500
    (3, 10000.00, '2026-08-10', 'Cash'),   -- 2 nights x 5000
    (4,  2400.00, '2026-08-15', 'UPI');    -- 2 nights x 1200

-- ----------------------------------------------------------------
-- Services
-- ----------------------------------------------------------------
INSERT INTO Services (service_name, price) VALUES
    ('Spa',       1500.00),
    ('Laundry',    300.00),
    ('Gym',        500.00),
    ('Room Service', 800.00);

-- ----------------------------------------------------------------
-- Service_Usage
-- ----------------------------------------------------------------
INSERT INTO Service_Usage (guest_id, service_id, staff_id, usage_date) VALUES
    (1, 1, 4, '2026-08-02'),   -- Arjun used Spa, handled by Anita
    (2, 2, 2, '2026-08-06'),   -- Priya used Laundry, handled by Meena
    (3, 3, 2, '2026-08-11'),   -- Rohit used Gym, handled by Meena
    (1, 4, 1, '2026-08-02');   -- Arjun used Room Service, handled by Ravi

-- Fix: Update room status for reserved rooms
UPDATE Rooms SET status = 'Booked' 
WHERE room_id IN (1, 2, 3, 4);

-- ================================================================
--  data.sql complete
-- ================================================================
