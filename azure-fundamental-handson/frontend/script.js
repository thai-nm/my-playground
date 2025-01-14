document.addEventListener("DOMContentLoaded", () => {
  const feedbackForm = document.getElementById("feedback-form");
  const thankYouMessage = document.getElementById("thank-you-message");
  const resetButton = document.getElementById("reset-button");

  feedbackForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    const formData = new FormData(feedbackForm);
    const feedbackData = {
      name: formData.get("name"),
      email: formData.get("email"),
      feedback: formData.get("feedback"),
    };

    try {
      const response = await fetch("http://localhost:3000/feedbacks", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({"message": feedbackData}),
      });

      if (response.ok) {
        // Hide the form and show the thank-you message
        feedbackForm.classList.add("hidden");
        thankYouMessage.classList.remove("hidden");
      } else {
        console.error("Failed to submit feedback");
      }
    } catch (error) {
      console.error("An error occurred while submitting feedback:", error);
    }
  });

  resetButton.addEventListener("click", () => {
    // Reset the form and switch views
    feedbackForm.reset();
    feedbackForm.classList.remove("hidden");
    thankYouMessage.classList.add("hidden");
  });
});
