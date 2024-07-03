package controller

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// NotBadRequest checks if the "NotBad" header is set to "true" and responds accordingly
func NotBadRequest(ctx *gin.Context) {
	if ctx.GetHeader("NotBad") == "true" {
		ctx.String(http.StatusOK, "ReallyNotBad")
	}
	ctx.Status(http.StatusBadRequest)

}
