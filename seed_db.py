import sqlite3, uuid, time, os, shutil

DB = r"D:\flutter_projects\DueMateSmartReminder\duemate_seed.sqlite"
if os.path.exists(DB):
    os.remove(DB)

conn = sqlite3.connect(DB)
c = conn.cursor()

# Drift schema (matches app_database.g.dart)
c.executescript("""
PRAGMA journal_mode=WAL;
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS reminders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    category TEXT NOT NULL,
    due_date INTEGER NOT NULL,
    amount REAL,
    currency_code TEXT NOT NULL DEFAULT 'BDT',
    is_recurring INTEGER NOT NULL DEFAULT 0 CHECK (is_recurring IN (0,1)),
    recurrence_type TEXT,
    recurrence_interval INTEGER,
    is_completed INTEGER NOT NULL DEFAULT 0 CHECK (is_completed IN (0,1)),
    completed_at INTEGER,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS notification_schedules (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reminder_id INTEGER NOT NULL REFERENCES reminders(id) ON DELETE CASCADE,
    notify_before_days INTEGER NOT NULL,
    scheduled_at INTEGER NOT NULL,
    notification_id INTEGER NOT NULL,
    is_sent INTEGER NOT NULL DEFAULT 0 CHECK (is_sent IN (0,1))
);

CREATE TABLE IF NOT EXISTS custom_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    label TEXT NOT NULL,
    color_value INTEGER NOT NULL,
    created_at INTEGER NOT NULL
);

PRAGMA user_version = 2;
""")

now_s = int(time.time())
# Drift stores DateTime as Unix seconds (INTEGER)

def days_from_now(days):
    return now_s + days * 86400

reminders = [
    (str(uuid.uuid4()), "Electricity Bill",    "Monthly electricity payment",   "payment",      days_from_now(5),   1500.0, "BDT", 0),
    (str(uuid.uuid4()), "Netflix Subscription","Monthly streaming renewal",     "subscription", days_from_now(12),   649.0, "BDT", 0),
    (str(uuid.uuid4()), "Passport Expiry",     "Renew before travel",           "document",     days_from_now(45),  None,   "BDT", 0),
    (str(uuid.uuid4()), "Mobile Insurance",    "Annual device protection plan", "warranty",     days_from_now(30),  2500.0, "BDT", 0),
    (str(uuid.uuid4()), "Internet Bill",       "Broadband monthly payment",     "payment",      days_from_now(-2),   800.0, "BDT", 1),
]

for r in reminders:
    uid, title, desc, cat, due, amt, cur, completed = r
    c.execute("""INSERT INTO reminders
        (uuid,title,description,category,due_date,amount,currency_code,is_recurring,is_completed,created_at,updated_at)
        VALUES (?,?,?,?,?,?,?,0,?,?,?)""",
        (uid, title, desc, cat, due, amt, cur, completed, now_s, now_s))

conn.commit()
conn.close()
print(f"Created {DB}")
print(f"Size: {os.path.getsize(DB)} bytes")
