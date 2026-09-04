# RaceDay Database Documentation

## Overview

The RaceDay database supports the management of running, walking and cycling events. It stores information about users, events, event categories, locations, enrolments and participant results.

## Database Management System

The database was created and tested using Microsoft SQL Server and SQL Server Management Studio (SSMS).

## Database Entities

### USERS
Stores information about RaceDay users, including organisers and participants.

Primary Key:
- UserID

### EVENT
Stores information about events created by organisers.

Primary Key:
- EventID

Foreign Keys:
- OrganiserID
- EventTypeID
- LocationID

### EVENT_TYPE
Stores the different types of events, such as running, walking and cycling.

Primary Key:
- EventTypeID

### LOCATION
Stores venue and location information for events.

Primary Key:
- LocationID

### CATEGORY
Stores the available categories for each event.

Primary Key:
- CategoryID

Foreign Key:
- EventID

### ENROLMENT
Stores participant registrations for events and their selected categories.

Primary Key:
- EnrolmentID

Foreign Keys:
- ParticipantID
- EventID
- CategoryID

### RESULT
Stores results recorded for participant enrolments.

Primary Key:
- ResultID

Foreign Key:
- EnrolmentID

## Relationships

- One organiser can create many events.
- One event type can be associated with many events.
- One location can host many events.
- One event can contain many categories.
- One participant can have many enrolments.
- One event can have many enrolments.
- One category can have many enrolments.
- One enrolment can have zero or one result.

## Seed Data

The SQL script includes sample data for organisers, participants, events, event types, locations, categories, enrolments and results.

The seed data provides realistic examples that can be used to test the RaceDay database structure.
