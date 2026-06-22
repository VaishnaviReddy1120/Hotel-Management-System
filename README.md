# 🏨 Hotel Management System — MySQL Database Project

A relational database system designed to manage the core operations of a hotel —
guests, rooms, reservations, payments, staff, and services.
Built using **MySQL**, this project demonstrates real-world database engineering concepts
including normalization, triggers, views, stored procedures, and indexes.

---

## 📌 Project Overview

This project simulates the backend database of a hotel like **Taj Hotels** or **Marriott International**.
It manages everything from guest check-ins to monthly revenue reporting —
all through a clean, normalized relational database.

---

## 🗂️ Database Structure

The database consists of **7 tables** with proper relationships:

| Table | Description |
|---|---|
| `Guests` | Stores guest personal details |
| `Rooms` | Stores room types, pricing, and availability |
| `Staff` | Stores hotel employee information |
| `Reservations` | Links guests to rooms with check-in/check-out dates |
| `Payments` | Records payments made against reservations |
| `Services` | Hotel services like Spa, Laundry, Gym, Room Service |
| `Service_Usage` | Tracks which guest used which service, handled by which staff |

---

## 🔗 Entity Relationship

```
Guests ──→ Reservations ──→ Payments
  │               │
  │            Rooms
  │
  └──→ Service_Usage ──→ Services
               │
             Staff
```

---

## ⚙️ Database Features

### 🔑 Foreign Keys
All tables are connected through foreign keys ensuring **referential integrity** —
no orphan records, no invalid data.

### ⚡ Trigger
```sql
CREATE TRIGGER after_reservation_insert
AFTER INSERT ON Reservations
FOR EACH ROW
BEGIN
    UPDATE Rooms SET status = 'Booked'
    WHERE room_id = NEW.room_id;
END
```
When a reservation is inserted, the room status automatically changes
from `Available` to `Booked` — no manual update needed.

### 👁️ View
```sql
CREATE VIEW OccupiedRooms AS ...
```
A virtual table that shows all currently occupied rooms along with
guest details — simplifies querying without writing complex JOINs every time.

### 📊 Stored Procedure
```sql
CALL GenerateRevenueReport('2026-08');
```
Pass any month and instantly get:
- Total bookings
- Total revenue
- Average revenue per booking

### 🚀 Indexes
```sql
CREATE INDEX idx_guest_phone ON Guests(phone);
CREATE INDEX idx_res_room    ON Reservations(room_id);
CREATE INDEX idx_res_guest   ON Reservations(guest_id);
```
Indexes on frequently searched columns for optimized query performance.

---

## 📁 File Structure

```
Hotel-Management-System/
│
├── schema.sql       # Creates database and all 7 tables with indexes
├── data.sql         # Inserts sample data into all tables
└── features.sql     # Trigger, View, Stored Procedure, Sample Queries
```

---

## ▶️ How to Run

1. Open **MySQL Workbench**
2. Run the files **in this exact order:**

```
Step 1 → schema.sql      (creates the database and tables)
Step 2 → data.sql        (inserts sample data)
Step 3 → features.sql    (creates trigger, view, and stored procedure)
```

---

## 🧪 Sample Queries Included

```sql
-- See all guests
SELECT * FROM Guests;

-- See currently occupied rooms
SELECT * FROM OccupiedRooms;

-- Full booking summary
SELECT g.name, r.room_type, res.check_in_date,
       res.check_out_date, p.amount, p.payment_mode
FROM Reservations res
JOIN Guests g   ON g.guest_id       = res.guest_id
JOIN Rooms  r   ON r.room_id        = res.room_id
JOIN Payments p ON p.reservation_id = res.reservation_id;

-- Monthly revenue report
CALL GenerateRevenueReport('2026-08');
```

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Database engine |
| MySQL Workbench | Query editor and database management |

---

## 📐 Concepts Demonstrated

- ✅ Database Design and Normalization (3NF)
- ✅ Primary Keys and Foreign Keys
- ✅ ENUM, AUTO_INCREMENT, DEFAULT constraints
- ✅ Trigger (AFTER INSERT)
- ✅ View (Virtual Table)
- ✅ Stored Procedure with Input Parameter
- ✅ Indexes for Query Optimization
- ✅ Multi-table JOINs
- ✅ Aggregate Functions — SUM, COUNT, AVG
- ✅ DATE functions — DATEDIFF, DATE_FORMAT

---

## 👩‍💻 Author

**Vaishnavi Reddy**  
[GitHub Profile](https://github.com/VaishnaviReddy1120)

