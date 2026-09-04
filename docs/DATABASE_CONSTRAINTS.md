# RaceDay Database Constraints

## Overview

The RaceDay database uses constraints to maintain data integrity and ensure that valid information is stored in the system.

## Primary Keys

Each main database table has a primary key that uniquely identifies each record.

- USERS - UserID
- EVENT - EventID
- EVENT_TYPE - EventTypeID
- LOCATION - LocationID
- CATEGORY - CategoryID
- ENROLMENT - EnrolmentID
- RESULT - ResultID

## Foreign Keys

Foreign keys are used to maintain relationships between tables.

### EVENT
- OrganiserID references USERS(UserID)
- EventTypeID references EVENT_TYPE(EventTypeID)
- LocationID references LOCATION(LocationID)

### CATEGORY
- EventID references EVENT(EventID)

### ENROLMENT
- ParticipantID references USERS(UserID)
- EventID references EVENT(EventID)
- CategoryID references CATEGORY(CategoryID)

### RESULT
- EnrolmentID references ENROLMENT(EnrolmentID)

## NOT NULL Constraints

Required fields use NOT NULL constraints to prevent essential information from being omitted.

Examples include:

- User names and email addresses.
- Event names and dates.
- Event category information.
- Enrolment participant and event information.

## UNIQUE Constraints

Unique constraints prevent duplicate values where duplication should not be allowed.

Examples include:

- User email addresses must be unique.
- Event type names must be unique.
- Each enrolment can have a maximum of one associated result.

## DEFAULT Constraints

Default values are used where appropriate.

Examples include:

- Enrolment status defaults to Active.
- Enrolment date defaults to the current date.
- Result status defaults to Pending.

## Data Integrity

The combination of primary keys, foreign keys, NOT NULL constraints, UNIQUE constraints and DEFAULT values helps maintain the consistency and reliability of the RaceDay database.
