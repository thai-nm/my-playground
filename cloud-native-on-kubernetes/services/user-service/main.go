package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"user-service/config"
	"user-service/controllers"
	"user-service/db"
	"user-service/routes"
)

func main() {
	config.LoadEnv()

	// Connect to MongoDB
	if err := db.ConnectDB(); err != nil {
		log.Fatalf("MongoDB connection error: %v", err)
	}

	// Initialize controllers that depend on the database
	controllers.InitUserController()

	r := gin.Default()
	routes.UserRoutes(r)

	r.Run(":8080")
}
