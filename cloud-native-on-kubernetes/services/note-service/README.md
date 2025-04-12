# Note Service

A RESTful microservice for managing user notes, built with Node.js, Express, and MongoDB.

## Features

- JWT-based authentication
- CRUD operations for notes
- User-specific note management
- MongoDB integration

## API Endpoints

| Method | Endpoint   | Description             | Auth Required |
| ------ | ---------- | ----------------------- | ------------- |
| GET    | /notes     | List all notes          | Yes           |
| GET    | /notes/:id | Get a specific note     | Yes           |
| POST   | /notes     | Create a new note       | Yes           |
| PUT    | /notes/:id | Update an existing note | Yes           |
| DELETE | /notes/:id | Delete a note           | Yes           |

## Getting Started

### Prerequisites

- Node.js 14+
- MongoDB
- npm or yarn

### Environment Variables

Create a `.env` file in the root directory:

```
MONGO_URI=mongodb://localhost:27017/notes-db
SERVICE_NAME=note-service
```

### Installation

```bash
npm install
```

### Running the Service

```bash
npm start
```

## Request/Response Examples

### Create Note
```http
POST /notes
Authorization: Bearer <jwt_token>
Content-Type: application/json

{
  "title": "My Note",
  "content": "Note content here"
}
```

### List Notes
```http
GET /notes
Authorization: Bearer <jwt_token>
```

### Get Note
```http
GET /notes/:id
Authorization: Bearer <jwt_token>
```

### Update Note
```http
PUT /notes/:id
Authorization: Bearer <jwt_token>
Content-Type: application/json

{
  "title": "Updated Title",
  "content": "Updated content"
}
```

### Delete Note
```http
DELETE /notes/:id
Authorization: Bearer <jwt_token>
```

## Project Structure

```
note-service/
├── .env                    # Environment variables
├── .gitignore             # Git ignore file
├── package.json           # Project dependencies and scripts
├── app.js                 # Main application file
├── bin/
│   └── www                # Server startup script
├── models/
│   └── Note.js           # Note model/schema
├── routes/
│   └── notes.js          # Note API routes
└── README.md             # Project documentation
