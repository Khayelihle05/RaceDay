# RaceDay API Response Codes

## Overview

The RaceDay API will use standard HTTP status codes to communicate whether a request was successful or unsuccessful.

## Success Responses

### 200 OK
Used when a request is completed successfully, such as retrieving events, viewing a profile or updating information.

### 201 Created
Used when a new resource is successfully created, such as a user account, event, category, enrolment or result.

### 204 No Content
Used when a resource is successfully deleted and no response body is required.

## Client Error Responses

### 400 Bad Request
Used when the request contains invalid or missing information.

### 401 Unauthorized
Used when authentication is required but the user is not logged in or does not provide valid authentication credentials.

### 403 Forbidden
Used when the authenticated user does not have permission to perform an operation.

For example, a Participant cannot create or delete an event.

### 404 Not Found
Used when the requested resource does not exist, such as an event, category, enrolment or result.

### 409 Conflict
Used when the request conflicts with existing data.

Examples include:
- Registering with an email address that already exists.
- Attempting to enrol in the same event more than once.
- Attempting to create a second result for the same enrolment.

## Role-Based Responses

RaceDay uses two primary roles:

- Organiser
- Participant

Protected API endpoints will verify the authenticated user's role before allowing access to restricted operations.
