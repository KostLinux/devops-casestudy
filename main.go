package main

import (
	"log"
	"os"
	"web/middleware"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	if err := godotenv.Load(".env"); err != nil {
		log.Fatalf("error loading .env file")
	}

	if os.Getenv("APP_ENV") != "development" {
		gin.SetMode(gin.ReleaseMode)
	}

	port := os.Getenv("APP_PORT")
	if port == "" {
		log.Printf("APP_PORT is not set. Setting to default port 8089")
		port = "8089"
	}

	routerInit := gin.New()
	router := middleware.Router(routerInit)
	if err := router.Run(":" + port); err != nil {
		log.Printf("failed to start the server: %v", err)
	}
}
