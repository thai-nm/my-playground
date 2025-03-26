package db

import (
	"context"
	"time"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"user-service/config"
)

var Client *mongo.Client

func ConnectDB() error {
    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()

    client, err := mongo.Connect(ctx, options.Client().ApplyURI(config.GetMongoURI()))
    if err != nil {
        return err
    }

    println("Connected to MongoDB!")
    
    Client = client
    return nil
}
