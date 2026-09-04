USE RaceDay;
GO

CREATE TABLE USERS
(
UserID INT IDENTITY (1,1) PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
PasswordHash VARCHAR(255) NOT NULL,
Role VARCHAR(20) NOT NULL,
Phone VARCHAR(20) NULL
);
GO

USE RaceDay;
Go
SELECT * FROM USERS;
GO

USE RaceDay;
GO
CREATE TABLE EVENT_TYPE
(
EventTypeID INT IDENTITY(1,1) PRIMARY KEY,
TypeName VARCHAR(50) NOT NULL UNIQUE
);
GO

SELECT * FROM EVENT_TYPE;
GO

USE RaceDay
GO

CREATE TABLE LOACTION
(
LocationID INT IDENTITY(1,1) PRIMARY KEY,
VenueName VARCHAR(100) NOT NULL,
Address VARCHAR(200) NOT NULL,
City VARCHAR(50) NOT NULL,
Province VARCHAR(50) NOT NULL
);

USE RaceDay;
GO

CREATE TABLE EVENT
(
EventID INT IDENTITY(1,1) PRIMARY KEY,
OrganiserID INT NOT NULL,
EventTypeID INT NOT NULL,
LocationID INT NOT NULL,
Name VARCHAR(100) NOT NULL,
Description VARCHAR(500) NOT NULL,
EventDate DATE NOT NULL,
Distance DECIMAL(6,2) NOT NULL,

CONSTRAINT FK_EVENT_USERS
FOREIGN KEY (OrganiserID)
REFERENCES USERS(UserID),

CONSTRAINT FK_EVENT_USERS
FOREIGN KEY (EventTypeID)
REFERENCES EVENT_TYPE(EventTypeID),

CONSTRAINT FK_EVENT_LOCATION
FOREIGN KEY (LocationID)
REFERENCES LOCATION(LocationID)
);
GO

USE RaceDay;
GO

CREATE TABLE CATEGORY
(
CategoryID INT IDENTITY(1,1) PRIMARY KEY,
EVENTID INT NOT NULL, 
CategoryName VARCHAR(100) NOT NULL,
MinimumAge INT NOT NULL,
MaximumAge INT NOT NULL,
Distance DECIMAL(6,2) NOT NULL,

CONSTRAINT FK_CATEGORY_EVENT
FOREIGN KEY (EventID)
REFERENCES EVENT (EventID)

);
GO

IF OBJECT_ID('dbo.EVENT', 'U') IS NULL
BEGIN
CREATE TABLE EVENT
(
EventID INT IDENTITY (1,1) PRIMARY KEY,
OrganiserID INT NOT NULL,
EventTypeID INT NOT NULL,
LocationID INT NOT NULL,
Name VARCHAR(100) NOT NULL,
Description VARCHAR(500) NOT NULL,
EventDate DATE NOT NULL,
Distance DECIMAL(6,2) NOT NULL,

CONSTRAINT FK_EVENT_USERS
FOREIGN KEY (OrganiserID)
REFERENCES USERS(UserID),

CONSTRAINT FK_EVENT_TYPE
FOREIGN KEY (EventTypeID)
REFERENCES EVENT_TYPE(EventTypeID),

CONSTRAINT FK_EVENT_LOCATION
FOREIGN KEY(LocationID)
REFERENCES LOCATION(LocationID)
);
END;
GO

IF OBJECT_ID ('dbo.CATEGORY', 'U') IS NULL
BEGIN

CREATE TABLE CATEGORY
(

CategoryID INT IDENTITY(1,1) PRIMARY KEY,
EVENTID INT NOT NULL, 
CategoryName VARCHAR(100) NOT NULL,
MinimumAge INT NOT NULL,
MaximumAge INT NOT NULL,
Distance DECIMAL(6,2) NOT NULL,

CONSTRAINT FK_CATEGORY_EVENT
FOREIGN KEY (EventID)
REFERENCES EVENT (EventID)
);
END;
GO

IF OBJECT_ID ('dbo.ENRILMENT', 'U') IS NULL
BEGIN

CREATE TABLE ENROLMENT
(
EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
ParticipantID INT NOT NULL,
EventID INT NOT NULL,
CategoryID INT NOT NULL,
EnrolmentDate DATE NOT NULL DEFAULT GETDATE(),
Status VARCHAR(20) NOT NULL DEFAULT 'Active',

CONSTRAINT FK_ENROLMENT_USERS
FOREIGN KEY (ParticipantID)
REFERENCES USERS(UserID),

CONSTRAINT FL_ENROLMENT_EVENT
FOREIGN KEY (EventID)
REFERENCES EVENT (EventID),

CONSTRAINT FK_ENROLMENT_CATEGORY
FOREIGN KEY (CategoryID)
REFERENCES CATEGORY(CategoryID)
);
END;
GO

IF OBJECT_ID ('dbo.RESULT', 'U') IS NULL
BEGIN 

CREATE TABLE RESULT
(
ResultID INT IDENTITY (1,1) PRIMARY KEY,
EnrolmentID INT NOT NULL,
FinishTime TIME NULL,
FinishPosition INT NULL,
ResultStatus VARCHAR(20) NOT NULL DEFAULT 'Pending', 

CONSTRAINT FK_RESULT_ENROLMENT
FOREIGN KEY (EnrolmentID)
REFERENCES ENROLMENT (EnrolmentID),

CONSTRAINT UQ_RESULT_ENROLMENT
UNIQUE(EnrolmentID)
);
END;
GO

USE RaceDay;
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE='BASE TABLE'
ORDER BY TABLE_NAME;
GO

USE RaceDay;
GO

CREATE TABLE EVENT
(
EventID INT NOT NULL,
OrganiserID INT NOT NULL,
EventTypeID INT NOT NULL,
LocationID INT NOT NULL,
Name VARCHAR(100) NOT NULL,
Description VARCHAR(500) NOT NULL,
EventDate DATE NOT NULL,
Distance DECIMAL(6,2) NOT NULL,

CONSTRAINT FK_EVENT_TYPE
FOREIGN KEY (EventTypeID)
REFERENCES USERS(UserID),

CONSTRAINT FK_EVENT_EVENT_TYPE
FOREIGN KEY (EventTypeID)
REFERENCES EVENT_TYPE(EventTypeID),

CONSTRAINT FK_EVENT_LOCATION
FOREIGN KEY (LocationID)
REFERENCES LOCATION(LocationID)
);
GO

USE RaceDay;
GO

EXEC sp_rename 'dbo.LOACTION', 'LOCATION';
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE= 'BASE TABLE' 
ORDER BY TABLE_NAME;
GO

USE RaceDay;
GO
CREATE TABLE CATEGORY
(
CategoryID INT IDENTITY(1,1) PRIMARY KEY,
EventID INT NOT NULL,
CategoryName VARCHAR(100) NOT NULL,
MinimumAge INT NOT NULL,
MaximumAge INT NOT NULL,
Distance DECIMAL(6,2) NOT NULL,

CONSTRAINT FK_CATEGORY_EVENT
FOREIGN KEY (EventID)
REFERENCES EVENT(EventID)
);
GO

USE RaceDay;
GO

IF OBJECT_ID('dbo.CATEGORY', 'U') IS NOT NULL
DROP TABLE dbo.CATEGORY;
GO
IF OBJECT_ID('dbo.EVENT','U') IS NOT NULL
DROP TABLE dbo.EVENT;
GO

CREATE TABLE dbo.EVENT
(
EventID INT IDENTITY(1,1) NOT NULL,
OrganiserID INT NOT NULL,
EventTypeID INT NOT NULL,
LocationID INT NOT NULL,
Name VARCHAR(100) NOT NULL,
Description VARCHAR(500) NOT NULL,
EventDate DATE NOT NULL,
Distance DECIMAL(6,2) NOT NULL

CONSTRAINT PK_EVENT
PRIMARY KEY(EventID),

CONSTRAINT FK_EVENT_USERS
FOREIGN KEY (OrganiserID)
REFERENCES dbo.USERS(UserID),

CONSTRAINT FK_EVENT_LOCATION
FOREIGN KEY(LocationID)
REFERENCES dbo.LOCATION(LocationID)
);
GO

CREATE TABLE dbo.CATEGORY
(
CategoryID INT IDENTITY(1,1) NOT NULL,
EventID INT NOT NULL,
CategoryName VARCHAR(100) NOT NULL,
MinimumAge INT NOT NULL,
MaximumAge INT NOT NULL,
Distance DECIMAL(6,2) NOT NULL,

CONSTRAINT PK_CATEGORY
PRIMARY KEY(CategoryID),

CONSTRAINT FK_CATEGORY_EVENT
FOREIGN KEY (EventID)
REFERENCES dbo.EVENT(EventID)
);
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE= 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

USE RaceDay;
GO

CREATE TABLE dbo.ENROLMENT
(
    EnrolmentID INT IDENTITY(1,1) NOT NULL,
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    EnrolmentDate DATE NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT PK_ENROLMENT
        PRIMARY KEY (EnrolmentID),

    CONSTRAINT FK_ENROLMENT_USERS
        FOREIGN KEY (ParticipantID)
        REFERENCES dbo.USERS(UserID),

    CONSTRAINT FK_ENROLMENT_EVENT
        FOREIGN KEY (EventID)
        REFERENCES dbo.EVENT(EventID),

    CONSTRAINT FK_ENROLMENT_CATEGORY
        FOREIGN KEY (CategoryID)
        REFERENCES dbo.CATEGORY(CategoryID)
);
GO

USE RaceDay;
GO

CREATE TABLE dbo.RESULT
(
    ResultID INT IDENTITY(1,1) NOT NULL,
    EnrolmentID INT NOT NULL,
    FinishTime TIME NULL,
    FinishPosition INT NULL,
    ResultStatus VARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT PK_RESULT
        PRIMARY KEY (ResultID),

    CONSTRAINT FK_RESULT_ENROLMENT
        FOREIGN KEY (EnrolmentID)
        REFERENCES dbo.ENROLMENT(EnrolmentID),

    CONSTRAINT UQ_RESULT_ENROLMENT
        UNIQUE (EnrolmentID)
);
GO


USE RaceDay;
GO


IF NOT EXISTS (
    SELECT 1 FROM dbo.USERS
    WHERE Email = 'thabo.mokoena@raceday.co.za'
)
BEGIN
    INSERT INTO dbo.USERS
        (FirstName, LastName, Email, PasswordHash, Role, Phone)
    VALUES
        ('Thabo', 'Mokoena',
         'thabo.mokoena@raceday.co.za',
         'DemoHash001',
         'Organiser',
         '0821112233');
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.USERS
    WHERE Email = 'lerato.dlamini@raceday.co.za'
)
BEGIN
    INSERT INTO dbo.USERS
        (FirstName, LastName, Email, PasswordHash, Role, Phone)
    VALUES
        ('Lerato', 'Dlamini',
         'lerato.dlamini@raceday.co.za',
         'DemoHash002',
         'Organiser',
         '0832223344');
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.USERS
    WHERE Email = 'sipho.nkosi@example.com'
)
BEGIN
    INSERT INTO dbo.USERS
        (FirstName, LastName, Email, PasswordHash, Role, Phone)
    VALUES
        ('Sipho', 'Nkosi',
         'sipho.nkosi@example.com',
         'DemoHash003',
         'Participant',
         '0843334455');
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.USERS
    WHERE Email = 'amahle.mthembu@example.com'
)
BEGIN
    INSERT INTO dbo.USERS
        (FirstName, LastName, Email, PasswordHash, Role, Phone)
    VALUES
        ('Amahle', 'Mthembu',
         'amahle.mthembu@example.com',
         'DemoHash004',
         'Participant',
         '0854445566');
END;
GO



IF NOT EXISTS (
    SELECT 1 FROM dbo.EVENT_TYPE
    WHERE TypeName = 'Running'
)
BEGIN
    INSERT INTO dbo.EVENT_TYPE (TypeName)
    VALUES ('Running');
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.EVENT_TYPE
    WHERE TypeName = 'Walking'
)
BEGIN
    INSERT INTO dbo.EVENT_TYPE (TypeName)
    VALUES ('Walking');
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.EVENT_TYPE
    WHERE TypeName = 'Cycling'
)
BEGIN
    INSERT INTO dbo.EVENT_TYPE (TypeName)
    VALUES ('Cycling');
END;
GO




IF NOT EXISTS (
    SELECT 1 FROM dbo.LOCATION
    WHERE VenueName = 'Pretoria National Botanical Garden'
)
BEGIN
    INSERT INTO dbo.LOCATION
        (VenueName, Address, City, Province)
    VALUES
        ('Pretoria National Botanical Garden',
         '2 Cussonia Avenue',
         'Pretoria',
         'Gauteng');
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.LOCATION
    WHERE VenueName = 'Emmarentia Botanical Garden'
)
BEGIN
    INSERT INTO dbo.LOCATION
        (VenueName, Address, City, Province)
    VALUES
        ('Emmarentia Botanical Garden',
         'Olifants Road',
         'Johannesburg',
         'Gauteng');
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.LOCATION
    WHERE VenueName = 'Durban Beachfront'
)
BEGIN
    INSERT INTO dbo.LOCATION
        (VenueName, Address, City, Province)
    VALUES
        ('Durban Beachfront',
         'Marine Parade',
         'Durban',
         'KwaZulu-Natal');
END;
GO


IF NOT EXISTS (
    SELECT 1 FROM dbo.EVENT
    WHERE Name = 'Pretoria City Run'
)
BEGIN
    INSERT INTO dbo.EVENT
        (OrganiserID, EventTypeID, LocationID,
         Name, Description, EventDate, Distance)
    SELECT
        u.UserID,
        et.EventTypeID,
        l.LocationID,
        'Pretoria City Run',
        'A community running event through Pretoria.',
        '2026-10-10',
        10.00
    FROM dbo.USERS u
    CROSS JOIN dbo.EVENT_TYPE et
    CROSS JOIN dbo.LOCATION l
    WHERE u.Email = 'thabo.mokoena@raceday.co.za'
      AND et.TypeName = 'Running'
      AND l.VenueName = 'Pretoria National Botanical Garden';
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.EVENT
    WHERE Name = 'Johannesburg Charity Walk'
)
BEGIN
    INSERT INTO dbo.EVENT
        (OrganiserID, EventTypeID, LocationID,
         Name, Description, EventDate, Distance)
    SELECT
        u.UserID,
        et.EventTypeID,
        l.LocationID,
        'Johannesburg Charity Walk',
        'A charity walking event supporting local communities.',
        '2026-10-24',
        5.00
    FROM dbo.USERS u
    CROSS JOIN dbo.EVENT_TYPE et
    CROSS JOIN dbo.LOCATION l
    WHERE u.Email = 'lerato.dlamini@raceday.co.za'
      AND et.TypeName = 'Walking'
      AND l.VenueName = 'Emmarentia Botanical Garden';
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.EVENT
    WHERE Name = 'Durban Coastal Cycle'
)
BEGIN
    INSERT INTO dbo.EVENT
        (OrganiserID, EventTypeID, LocationID,
         Name, Description, EventDate, Distance)
    SELECT
        u.UserID,
        et.EventTypeID,
        l.LocationID,
        'Durban Coastal Cycle',
        'A scenic cycling event along the Durban coastline.',
        '2026-11-07',
        20.00
    FROM dbo.USERS u
    CROSS JOIN dbo.EVENT_TYPE et
    CROSS JOIN dbo.LOCATION l
    WHERE u.Email = 'thabo.mokoena@raceday.co.za'
      AND et.TypeName = 'Cycling'
      AND l.VenueName = 'Durban Beachfront';
END;
GO




IF NOT EXISTS (
    SELECT 1 FROM dbo.CATEGORY
    WHERE CategoryName = '10km Open'
)
BEGIN
    INSERT INTO dbo.CATEGORY
        (EventID, CategoryName, MinimumAge, MaximumAge, Distance)
    SELECT
        EventID,
        '10km Open',
        18,
        99,
        10.00
    FROM dbo.EVENT
    WHERE Name = 'Pretoria City Run';
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.CATEGORY
    WHERE CategoryName = '10km Junior'
)
BEGIN
    INSERT INTO dbo.CATEGORY
        (EventID, CategoryName, MinimumAge, MaximumAge, Distance)
    SELECT
        EventID,
        '10km Junior',
        13,
        17,
        10.00
    FROM dbo.EVENT
    WHERE Name = 'Pretoria City Run';
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.CATEGORY
    WHERE CategoryName = '5km Open'
)
BEGIN
    INSERT INTO dbo.CATEGORY
        (EventID, CategoryName, MinimumAge, MaximumAge, Distance)
    SELECT
        EventID,
        '5km Open',
        18,
        99,
        5.00
    FROM dbo.EVENT
    WHERE Name = 'Johannesburg Charity Walk';
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.CATEGORY
    WHERE CategoryName = '5km Junior'
)
BEGIN
    INSERT INTO dbo.CATEGORY
        (EventID, CategoryName, MinimumAge, MaximumAge, Distance)
    SELECT
        EventID,
        '5km Junior',
        13,
        17,
        5.00
    FROM dbo.EVENT
    WHERE Name = 'Johannesburg Charity Walk';
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.CATEGORY
    WHERE CategoryName = '20km Open'
)
BEGIN
    INSERT INTO dbo.CATEGORY
        (EventID, CategoryName, MinimumAge, MaximumAge, Distance)
    SELECT
        EventID,
        '20km Open',
        18,
        99,
        20.00
    FROM dbo.EVENT
    WHERE Name = 'Durban Coastal Cycle';
END;

IF NOT EXISTS (
    SELECT 1 FROM dbo.CATEGORY
    WHERE CategoryName = '20km Junior'
)
BEGIN
    INSERT INTO dbo.CATEGORY
        (EventID, CategoryName, MinimumAge, MaximumAge, Distance)
    SELECT
        EventID,
        '20km Junior',
        16,
        17,
        20.00
    FROM dbo.EVENT
    WHERE Name = 'Durban Coastal Cycle';
END;
GO




IF NOT EXISTS (
    SELECT 1
    FROM dbo.ENROLMENT e
    INNER JOIN dbo.USERS u ON e.ParticipantID = u.UserID
    INNER JOIN dbo.EVENT ev ON e.EventID = ev.EventID
    WHERE u.Email = 'sipho.nkosi@example.com'
      AND ev.Name = 'Pretoria City Run'
)
BEGIN
    INSERT INTO dbo.ENROLMENT
        (ParticipantID, EventID, CategoryID, EnrolmentDate, Status)
    SELECT
        u.UserID,
        ev.EventID,
        c.CategoryID,
        '2026-09-01',
        'Active'
    FROM dbo.USERS u
    CROSS JOIN dbo.EVENT ev
    CROSS JOIN dbo.CATEGORY c
    WHERE u.Email = 'sipho.nkosi@example.com'
      AND ev.Name = 'Pretoria City Run'
      AND c.CategoryName = '10km Open';
END;

IF NOT EXISTS (
    SELECT 1
    FROM dbo.ENROLMENT e
    INNER JOIN dbo.USERS u ON e.ParticipantID = u.UserID
    INNER JOIN dbo.EVENT ev ON e.EventID = ev.EventID
    WHERE u.Email = 'amahle.mthembu@example.com'
      AND ev.Name = 'Johannesburg Charity Walk'
)
BEGIN
    INSERT INTO dbo.ENROLMENT
        (ParticipantID, EventID, CategoryID, EnrolmentDate, Status)
    SELECT
        u.UserID,
        ev.EventID,
        c.CategoryID,
        '2026-09-02',
        'Active'
    FROM dbo.USERS u
    CROSS JOIN dbo.EVENT ev
    CROSS JOIN dbo.CATEGORY c
    WHERE u.Email = 'amahle.mthembu@example.com'
      AND ev.Name = 'Johannesburg Charity Walk'
      AND c.CategoryName = '5km Open';
END;
GO




IF NOT EXISTS (
    SELECT 1
    FROM dbo.RESULT r
    INNER JOIN dbo.ENROLMENT e
        ON r.EnrolmentID = e.EnrolmentID
    INNER JOIN dbo.USERS u
        ON e.ParticipantID = u.UserID
    WHERE u.Email = 'sipho.nkosi@example.com'
)
BEGIN
    INSERT INTO dbo.RESULT
        (EnrolmentID, FinishTime, FinishPosition, ResultStatus)
    SELECT
        e.EnrolmentID,
        '00:52:34',
        15,
        'Completed'
    FROM dbo.ENROLMENT e
    INNER JOIN dbo.USERS u
        ON e.ParticipantID = u.UserID
    WHERE u.Email = 'sipho.nkosi@example.com';
END;
GO

USE RaceDay;
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO