// Importing required modules
const express = require("express");
const cors = require('cors'); // Import the CORS package

// Create an instance of an Express app
const app = express();

// Middleware to parse JSON request bodies
app.use(express.json());
app.use(cors());

// Array to store feedbacks
const feedbacks = [];

// Route to handle POST requests to /feedbacks
app.post("/feedbacks", (req, res) => {
  const feedback = req.body;

  console.log(feedback)

  if (!feedback || !feedback.message) {
    return res.status(400).json({ error: "Feedback message is required." });
  }

  feedbacks.push(feedback);
  res.status(201).json({ message: "Feedback added successfully.", feedback });
});

// Route to handle GET requests to /feedbacks
app.get("/feedbacks", (req, res) => {
  res.status(200).json(feedbacks);
});

app.get("/", (req, res) => {
    res.status(200).json("Hello, this is a simple feedback app!");
  });

// Start the server
const PORT = 80;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
