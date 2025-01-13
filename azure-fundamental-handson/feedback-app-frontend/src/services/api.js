// src/services/api.js

const API_BASE_URL = 'https://your-domain.com/api'; // Replace with your actual domain

export const submitFeedback = async (feedbackData) => {
  try {
    const response = await fetch(`${API_BASE_URL}/feedback`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        // Add any additional headers like authentication tokens if needed
        // 'Authorization': 'Bearer your-token'
      },
      body: JSON.stringify(feedbackData)
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error submitting feedback:', error);
    throw error;
  }
};