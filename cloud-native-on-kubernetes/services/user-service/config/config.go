package config

import (
	"os"
	"github.com/joho/godotenv"
)

func LoadEnv() {
	godotenv.Load()
}

func GetMongoURI() string {
	return os.Getenv("MONGO_URI")
}