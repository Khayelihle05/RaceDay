# RaceDay Event Management System

## System Description

RaceDay is a full-stack event management system designed for South African running, walking and cycling events.

The system allows organisers to create and manage events, while participants can browse events, enrol in available categories and track their results.

## User Roles

### Organiser

Organisers are able to:

- Create, edit and delete events.
- Manage event categories.
- View participant enrolments.
- Capture participant results.

### Participant

Participants are able to:

- Create an account.
- Manage their profile.
- Browse available events.
- Enrol in an event and select a category.
- View their event enrolments.
- Track their event results.

## Project Documentation

The `/docs` folder contains the planning and database documentation for RaceDay.

The documentation includes:

- RaceDay Entity Relationship Diagram (ERD)
- API Endpoint Plan
- SQL Server database creation and seed script

## Database

The RaceDay database was created using Microsoft SQL Server.

The database contains the following main entities:

- USERS
- EVENT
- EVENT_TYPE
- LOCATION
- CATEGORY
- ENROLMENT
- RESULT

The SQL script includes:

- Primary keys
- Foreign keys
- NOT NULL constraints
- UNIQUE constraints
- DEFAULT constraints
- Sample seed data

## API Planning

The API Endpoint Plan includes endpoints for:

- Authentication
- User Profile
- Events
- Categories
- Event Enrolments
- Results
- Event Types
- Locations

Each endpoint includes the HTTP method, route, description, required role, request body and expected response.

## CI/CD

GitHub Actions is used to validate the RaceDay repository structure.

The workflow checks that the required project files and folders are available in the repository.

The following screenshot shows the successful GitHub Actions CI workflow:

![Successful RaceDay CI Build](CI_Success.jpg)

## Video Demonstration

YouTube demonstration link will be added here before final submission.
https://youtu.be/ZsQO-wMoaAk?si=ugyWh8cUikhKrpu_
