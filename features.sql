-- ================================================================
--  FILE 3 : features.sql
--  Hotel Management System
--  Trigger | View | Stored Procedure | Sample Queries
-- ================================================================

USE HotelDB;

-- ----------------------------------------------------------------
-- TRIGGER
-- Automatically marks a room as 'Booked' when a reservation
-- is inserted — no manual update needed
-- ----------------------------------------------------------------
DELIMITER $$

CREATE TRIGGER after_reservation_insert
AFTER INSERT ON Reservations
FOR EACH ROW
BEGIN
    UPDATE Rooms
    SET    status = 'Booked'
    WHERE  room_id = NEW.room_id;
END$$

DELIMITER ;

-- ----------------------------------------------------------------
-- VIEW
-- Shows all currently occupied rooms with guest details
-- Instead of writing a JOIN every time, just query this view
-- ----------------------------------------------------------------
CREATE VIEW OccupiedRooms AS
SELECT
    r.room_id,
    r.room_type,
    r.price_per_night,
    g.name           AS guest_name,
    g.phone          AS guest_phone,
    res.check_in_date,
    res.check_out_date
FROM  Reservations res
JOIN  Guests g ON g.guest_id = res.guest_id
JOIN  Rooms  r ON r.room_id  = res.room_id
WHERE r.status = 'Booked';

-- ----------------------------------------------------------------
-- STORED PROCEDURE
-- Pass any month → get total revenue for that month
-- Usage : CALL GenerateRevenueReport('2026-08');
-- ----------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE GenerateRevenueReport(IN report_month VARCHAR(7))
BEGIN
    SELECT
        report_month            AS month,
        COUNT(*)                AS total_bookings,
        SUM(p.amount)           AS total_revenue,
        AVG(p.amount)           AS avg_revenue_per_booking
    FROM  Payments p
    WHERE DATE_FORMAT(p.payment_date, '%Y-%m') = report_month;
END$$

DELIMITER ;

-- ================================================================
--  SAMPLE QUERIES — to see if everything working
-- ================================================================

-- 1. See all guests
SELECT * FROM Guests;

-- 2. See all rooms and their status
SELECT * FROM Rooms;

-- 3. See occupied rooms using the View
SELECT * FROM OccupiedRooms;

-- 4. Full booking details — Guest + Room + Payment in one query
SELECT
    res.reservation_id,
    g.name                                              AS guest,
    r.room_type,
    res.check_in_date,
    res.check_out_date,
    DATEDIFF(res.check_out_date, res.check_in_date)    AS nights,
    p.amount                                            AS amount_paid,
    p.payment_mode
FROM  Reservations res
JOIN  Guests   g ON g.guest_id        = res.guest_id
JOIN  Rooms    r ON r.room_id         = res.room_id
JOIN  Payments p ON p.reservation_id  = res.reservation_id;

-- 5. Which guest used which service and who handled it
SELECT
    g.name          AS guest,
    s.service_name  AS service,
    st.name         AS handled_by,
    su.usage_date
FROM  Service_Usage su
JOIN  Guests   g  ON g.guest_id   = su.guest_id
JOIN  Services s  ON s.service_id = su.service_id
JOIN  Staff    st ON st.staff_id  = su.staff_id;

-- 6. Monthly revenue report (Stored Procedure)
CALL GenerateRevenueReport('2026-08');

-- ================================================================
--  features.sql complete
-- ================================================================
