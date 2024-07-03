package middleware

import (
	"web/controller"

	"github.com/gin-gonic/gin"
)

func Router(router *gin.Engine) *gin.Engine {

	router.Use(gin.Logger())
	router.Use(gin.Recovery())
	router.Use(SecurityHeaders())

	router.POST("/", controller.NotBadRequest)
	return router
}
