package models

type User struct {
	ID           string `json:"id" bson:"_id,omitempty"`
	Username     string `json:"username" bson:"username"`
	Name		 string `json:"name" bson:"name"`
	Email        string `json:"email" bson:"email"`
	PasswordHash string `json:"password_hash" bson:"password_hash"`
	CreatedAt    int64  `json:"created_at" bson:"created_at"`
}
