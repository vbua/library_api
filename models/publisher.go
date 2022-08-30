package models

type Publisher struct {
	ID   uint   `json:"id" gorm:"primary_key"`
	Name string `json:"publisher_name"`
}
