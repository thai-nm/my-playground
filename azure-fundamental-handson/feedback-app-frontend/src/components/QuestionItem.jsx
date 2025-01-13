// components/QuestionItem.jsx
import React from 'react';

const QuestionItem = ({ question, value, error, onChange, disabled }) => {
  const getInputElement = () => {
    const baseInputClasses = `input-transition mt-2 block w-full rounded-xl border-gray-200 
      bg-white/50 px-4 py-3 text-gray-700 shadow-sm focus:border-purple-500 
      focus:ring-purple-500 ${disabled ? 'opacity-75 cursor-not-allowed' : ''}`;

    switch (question.type) {
      case 'text':
        return (
          <input
            type="text"
            value={value}
            onChange={(e) => onChange(e.target.value)}
            className={baseInputClasses}
            placeholder={question.placeholder}
            disabled={disabled}
          />
        );
      case 'textarea':
        return (
          <textarea
            value={value}
            onChange={(e) => onChange(e.target.value)}
            rows="4"
            className={baseInputClasses}
            placeholder={question.placeholder}
            disabled={disabled}
          />
        );
      case 'rating':
        return (
          <div className="mt-4 flex flex-wrap justify-center gap-4">
            {[1, 2, 3, 4, 5].map((rating) => (
              <button
                key={rating}
                type="button"
                onClick={() => onChange(rating.toString())}
                disabled={disabled}
                className={`input-transition relative w-16 h-16 rounded-2xl flex items-center justify-center 
                  text-lg font-semibold ${disabled ? 'opacity-75 cursor-not-allowed' : ''} ${
                  value === rating.toString()
                    ? 'bg-gradient-to-br from-purple-600 to-pink-600 text-white shadow-lg animate-pulse-purple'
                    : 'bg-white hover:bg-gray-50 text-gray-700 border border-gray-200 hover:border-purple-500'
                }`}
              >
                <span className="relative z-10">{rating}</span>
                {value === rating.toString() && (
                  <div className="absolute inset-0 bg-gradient-to-br from-purple-600 to-pink-600 rounded-2xl opacity-20 blur"></div>
                )}
              </button>
            ))}
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <div className="animate-fade-in mb-8">
      <div className="flex items-center space-x-2 mb-2">
        <label className="block text-lg font-medium text-gray-700">
          {question.text}
        </label>
        {error && (
          <span className="text-red-500 text-sm bg-red-50 px-2 py-1 rounded-full flex items-center">
            <svg className="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
            </svg>
            {error}
          </span>
        )}
      </div>
      {getInputElement()}
    </div>
  );
};

export default QuestionItem;