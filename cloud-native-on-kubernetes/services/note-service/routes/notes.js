const express = require('express');
const router = express.Router();
const Note = require('../models/Note');
const authMiddleware = require('../middleware/auth');

// GET /notes - List all notes for the user
router.get('/', authMiddleware, async (req, res) => {
  try {
    const userEmail = req.user.email; // From JWT
    const notes = await Note.find({ userEmail });
    res.json(notes);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET /notes/:id - Get a specific note
router.get('/:id', authMiddleware, async (req, res) => {
  try {
    const note = await Note.findOne({
      _id: req.params.id,
      userEmail: req.user.email
    });
    
    if (!note) {
      return res.status(404).json({ error: 'Note not found' });
    }
    res.json(note);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST /notes - Create a new note
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

// PUT /notes/:id - Update a note
router.put('/:id', authMiddleware, async (req, res) => {
  try {
    const note = await Note.findOneAndUpdate(
      {
        _id: req.params.id,
        userEmail: req.user.email
      },
      {
        title: req.body.title,
        content: req.body.content,
        updatedAt: Date.now()
      },
      { new: true }
    );

    if (!note) {
      return res.status(404).json({ error: 'Note not found' });
    }
    res.json(note);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// DELETE /notes/:id - Delete a note
router.delete('/:id', authMiddleware, async (req, res) => {
  try {
    const note = await Note.findOneAndDelete({
      _id: req.params.id,
      userEmail: req.user.email
    });

    if (!note) {
      return res.status(404).json({ error: 'Note not found' });
    }
    res.json({ message: 'Note deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;