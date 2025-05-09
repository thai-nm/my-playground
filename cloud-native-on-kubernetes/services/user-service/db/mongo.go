package db

import (
	"context"
	"fmt"
	"time"
	"user-service/config"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var Client *mongo.Client

func ConnectDB() error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	client, err := mongo.Connect(ctx, options.Client().ApplyURI(config.GetMongoURI()))
	if err != nil {
		return fmt.Errorf("failed to connect to MongoDB: %w", err)
	}

	// Verify connection
	if err := client.Ping(ctx, nil); err != nil {
		return fmt.Errorf("failed to ping MongoDB: %w", err)
	}

	println("Connected to MongoDB!")

	Client = client
	return nil
}
