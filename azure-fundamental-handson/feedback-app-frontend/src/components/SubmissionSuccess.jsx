// components/SubmissionSuccess.jsx
import React from 'react';

const SubmissionSuccess = () => {
  return (
    <div className="text-center animate-fade-in py-8">
      <div className="mb-8 relative">
        <div className="absolute inset-0 bg-gradient-to-br from-green-400 to-emerald-500 rounded-full blur-lg opacity-50 animate-pulse"></div>
        <div className="relative w-32 h-32 mx-auto bg-gradient-to-br from-green-400 to-emerald-500 rounded-full flex items-center justify-center shadow-lg animate-float">
          <svg
            className="w-20 h-20 text-white"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
            />
          </svg>
        </div>
      </div>

      <h2 className="text-4xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-green-400 to-emerald-600 mb-6">
        Thank You for Your Feedback!
      </h2>

      <p className="text-gray-600 text-lg mb-8 max-w-md mx-auto">
        Your insights are invaluable to us. We're committed to creating a better workplace based on your feedback.
      </p>

      <div className="flex items-center justify-center space-x-4">
        <div className="flex items-center text-sm text-gray-500 bg-gray-50 px-4 py-2 rounded-full">
          <svg className="w-5 h-5 mr-2 text-green-500" fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
          </svg>
          Response Recorded Successfully
        </div>
      </div>
    </div>
  );
};

export default SubmissionSuccess;