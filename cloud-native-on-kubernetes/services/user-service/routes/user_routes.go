package routes

import (
	"user-service/controllers"
	"user-service/middleware"
	"github.com/gin-gonic/gin"
)

func RegisterRoutes(router *gin.Engine) {
	routes := router.Group("/user")
	{
		routes.POST("/register", controllers.RegisterUser)
		routes.POST("/login", controllers.LoginUser)
		routes.GET("/profile", middleware.AuthMiddleware(), controllers.GetProfile)
	}
}
