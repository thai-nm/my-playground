// App.jsx
import React, { useState } from 'react';
import FeedbackForm from './components/FeedbackForm';
import SubmissionSuccess from './components/SubmissionSuccess';
import { submitFeedback } from './services/api';

const App = () => {
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmission = async (answers) => {
    setIsLoading(true);
    setError(null);
    
    try {
      const response = await submitFeedback({
        answers,
        submittedAt: new Date().toISOString(),
      });
      
      console.log('Server response:', response);
      setIsSubmitted(true);
    } catch (err) {
      setError('Failed to submit feedback. Please try again later.');
      console.error('Submission error:', err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen gradient-background py-6 flex flex-col justify-center px-4 sm:px-6 lg:px-8">
      <div className="relative max-w-4xl mx-auto w-full">
        <div className="relative glass-morphism rounded-3xl shadow-xl overflow-hidden">
          <div className="relative pt-24 pb-16 px-4 sm:px-6 lg:px-8">
            <div className="text-center mb-12">
              <h1 className="text-4xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-purple-600 to-pink-600 mb-4">
                Share Your Feedback
              </h1>
              <p className="text-gray-600 text-lg max-w-2xl mx-auto">
                Help us create a better workplace by sharing your thoughts and experiences
              </p>
            </div>

            <div className="max-w-2xl mx-auto">
              {error && (
                <div className="mb-6 p-4 bg-red-50 rounded-lg text-red-600 text-center animate-fade-in">
                  <p className="flex items-center justify-center">
                    <svg className="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                      <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                    </svg>
                    {error}
                  </p>
                </div>
              )}

              {!isSubmitted ? (
                <FeedbackForm onSubmit={handleSubmission} isLoading={isLoading} />
              ) : (
                <SubmissionSuccess />
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default App;