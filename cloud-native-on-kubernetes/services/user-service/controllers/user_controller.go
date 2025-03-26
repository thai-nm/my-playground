package controllers

import (
	"context"
	"log"
	"net/http"

	"user-service/db"
	"user-service/models"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"golang.org/x/crypto/bcrypt"
)

var userCollection *mongo.Collection

// Initialize userCollection after MongoDB connection is established
func InitUserController() {
	if db.Client == nil {
		log.Fatal("MongoDB client is not initialized")
	}
	userCollection = db.Client.Database("notes_app").Collection("users")
}

func RegisterUser(c *gin.Context) {
	// Create a struct to receive the registration request
	var registrationRequest struct {
		Username string `json:"username"`
		Password string `json:"password"`
		Name     string `json:"name"`
		Email    string `json:"email"`
	}

	if err := c.BindJSON(&registrationRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// Hash the password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(registrationRequest.Password), bcrypt.DefaultCost)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process password"})
		return
	}

	// Create user with hashed password
	user := models.User{
		ID:           primitive.NewObjectID().Hex(),
		Email:        registrationRequest.Email,
		Name:         registrationRequest.Name,
		PasswordHash: string(hashedPassword),
	}

	ctx := context.Background()

	// Check if user already exists
	existingUser := models.User{}
	err = userCollection.FindOne(ctx, bson.M{"email": user.Email}).Decode(&existingUser)
	if err == nil {
		c.JSON(http.StatusConflict, gin.H{"error": "User already exists"})
		return
	} else if err != mongo.ErrNoDocuments {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to check existing user"})
		return
	}

	// Insert the new user
	_, err = userCollection.InsertOne(ctx, user)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create user"})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User registered successfully"})
}

func GetProfile(c *gin.Context) {
	if userCollection == nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database not initialized"})
		return
	}

	ctx := context.Background()
	filter := bson.M{"email": "test@example.com"}
	var result bson.M

	err := userCollection.FindOne(ctx, filter).Decode(&result)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "User not found"})
		return
	}

	c.JSON(http.StatusOK, result)
}
