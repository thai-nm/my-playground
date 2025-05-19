package routes

import (
	"user-service/controllers"
	"user-service/middleware"

	"github.com/gin-gonic/gin"
)

func UserRoutes(router *gin.Engine) {
	publicRoutes := router.Group("/user")
	{
		publicRoutes.POST("/register", controllers.RegisterUser)
		publicRoutes.POST("/login", controllers.LoginUser)
	}

	privateRoutes := router.Group("/user")
	{
		privateRoutes.GET("/profile", middleware.AuthMiddleware(), controllers.GetProfile)
	}
}
