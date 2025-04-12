const express = require('express');
const router = express.Router();
const Note = require('../models/Note');
const authMiddleware = require('../middleware/auth');

router.get('/', (req, res) => {
  res.json({ message: 'This is the note-service.' });
});

// Create a new note
router.post('/', authMiddleware, async (req, res) => {
  try {
    const { title, content } = req.body;

    // Validate required fields
    if (!title || !content) {
      return res.status(400).json({ error: 'Title and content are required' });
    }

    // Create new note
    const note = new Note({
      title,
      content,
      userId: req.user.username // Use email as userId since it's unique
    });

    // Save to database
    const savedNote = await note.save();

    res.status(201).json(savedNote);
  } catch (error) {
    console.error('Error creating note:', error);
    res.status(500).json({ error: 'Error creating note' });
  }
});

module.exports = router;