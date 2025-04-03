package routes

import (
	"github.com/gin-gonic/gin"
	"user-service/controllers"
	// "user-service/middleware"
)

func RegisterRoutes(router *gin.Engine) {
	routes := router.Group("/user")
	{
		routes.POST("/register", controllers.RegisterUser)
		routes.GET("/profile", controllers.GetProfile)
		// routes.GET("/profile", middleware.AuthMiddleware(), controllers.GetProfile)
	}
}