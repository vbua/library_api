package models

type BookCopy struct {
	ID         uint     `json:"id" gorm:"primary_key"`
	BookId     uint     `json:"book_id"`
	ShelfId    uint     `json:"shelf_id"`
	BookcaseId uint     `json:"bookcase_id"`
	IsOccupied bool     `json:"is_occupied"`
	BorrowedBy *uint    `json:"borrowed_by"`
	Book       Book     `gorm:"foreignKey:BookId" json:"book"`
	User       *User    `gorm:"foreignKey:BorrowedBy" json:"user"`
	Shelf      Shelf    `gorm:"foreignKey:ShelfId" json:"shelf"`
	Bookcase   Bookcase `gorm:"foreignKey:BookcaseId" json:"bookcase"`
}
