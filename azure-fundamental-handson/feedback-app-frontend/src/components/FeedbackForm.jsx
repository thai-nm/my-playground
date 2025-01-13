// components/FeedbackForm.jsx
import React, { useState } from 'react';
import QuestionItem from './QuestionItem';
import { questions } from '../data/questions';

const FeedbackForm = ({ onSubmit, isLoading }) => {
  const [answers, setAnswers] = useState({});
  const [errors, setErrors] = useState({});

  const handleChange = (questionId, value) => {
    setAnswers(prev => ({
      ...prev,
      [questionId]: value
    }));
    if (errors[questionId]) {
      setErrors(prev => ({
        ...prev,
        [questionId]: ''
      }));
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const newErrors = {};
    
    questions.forEach(question => {
      if (!answers[question.id] || answers[question.id].trim() === '') {
        newErrors[question.id] = 'This field is required';
      }
    });

    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }

    onSubmit(answers);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      {questions.map(question => (
        <QuestionItem
          key={question.id}
          question={question}
          value={answers[question.id] || ''}
          error={errors[question.id]}
          onChange={(value) => handleChange(question.id, value)}
          disabled={isLoading}
        />
      ))}
      
      <div className="mt-8">
        <button
          type="submit"
          disabled={isLoading}
          className={`w-full px-6 py-3 text-white bg-gradient-to-r from-purple-600 to-pink-600 rounded-xl 
            font-medium text-lg shadow-lg hover:shadow-xl transition-all duration-300 
            ${isLoading ? 'opacity-75 cursor-not-allowed' : 'hover:transform hover:scale-[1.02]'}`}
        >
          {isLoading ? (
            <div className="flex items-center justify-center">
              <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Submitting...
            </div>
          ) : (
            'Submit Feedback'
          )}
        </button>
      </div>
    </form>
  );
};

export default FeedbackForm;