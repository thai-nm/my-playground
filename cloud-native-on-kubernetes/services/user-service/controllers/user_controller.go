package controllers

import (
	"context"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"user-service/db"
)

var userCollection *mongo.Collection

// Initialize userCollection after MongoDB connection is established
func InitUserController() {
	if db.Client == nil {
		log.Fatal("MongoDB client is not initialized")
	}
	userCollection = db.Client.Database("notes_app").Collection("users")
}

// Example function using userCollection
func GetProfile(c *gin.Context) {
	if userCollection == nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database not initialized"})
		return
	}

	ctx := context.Background()
	filter := bson.M{"email": "test@example.com"} // Example filter
	var result bson.M

	err := userCollection.FindOne(ctx, filter).Decode(&result)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "User not found"})
		return
	}

	c.JSON(http.StatusOK, result)
}
