package models

type Book struct {
	ID              uint      `json:"id" gorm:"primary_key"`
	Title           string    `json:"title"`
	Description     string    `json:"description"`
	Authors         string    `json:"authors"`
	PublicationYear uint      `json:"publication_year"`
	PublisherId     uint      `json:"publisher_id"`
	Publisher       Publisher `json:"publisher"`
}

func (Book) TableName() string {
	return "book_details"
}
