package middleware

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

// SecurityHeaders returns a middleware handler function that sets security-related headers.
func SecurityHeaders() gin.HandlerFunc {
	return func(c *gin.Context) {
		hostHeader := c.Request.Host
		appHost := os.Getenv("APP_HOST")
		if appHost == "" {
			appHost = "localhost"
		}

		// Localhost Host Header is APP_HOST + APP_PORT (e.g., localhost:8000)
		localHostHeader := appHost + ":" + os.Getenv("APP_PORT")
		if hostHeader != localHostHeader && hostHeader != os.Getenv("APP_HOST") {
			c.String(http.StatusBadRequest, "Invalid host")
			c.Abort()
			return
		}

		c.Header("X-Frame-Options", "DENY")
		c.Header("Content-Security-Policy", "default-src 'self'; connect-src *; font-src *; script-src-elem * 'unsafe-inline'; img-src * data:; style-src * 'unsafe-inline';")
		c.Header("X-XSS-Protection", "1; mode=block")
		c.Header("Strict-Transport-Security", "max-age=31536000; includeSubDomains; preload")
		c.Header("Referrer-Policy", "strict-origin")
		c.Header("Permissions-Policy", "geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()")
	}
}
