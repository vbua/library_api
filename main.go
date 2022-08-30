package main

import (
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"github.com/vbua/library/models"
	"log"
	"net/http"
	"strconv"
)

func getBookItems(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		http.Error(w, "Id is not a valid number", http.StatusBadRequest)
		return
	}

	var bookCopies []models.BookCopy
	if err := models.DB.Where("book_id = ?", id).Preload("Book").Preload("User").Find(&bookCopies).Error; err != nil {
		fmt.Println(err)
		http.Error(w, "Error finding book items", http.StatusInternalServerError)
		return
	}
	w.Header().Add("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(bookCopies); err != nil {
		fmt.Println(err)
		http.Error(w, "Error encoding response object", http.StatusInternalServerError)
	}
}

func getBook(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		http.Error(w, "Id is not a valid number", http.StatusBadRequest)
		return
	}

	var book models.Book

	if result := models.DB.Preload("Publisher").First(&book, id); result.Error != nil {
		fmt.Println(result.Error)
		http.Error(w, "Book wasn't found", http.StatusNotFound)
		return
	}
	w.Header().Add("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(book); err != nil {
		fmt.Println(err)
		http.Error(w, "Error encoding response object", http.StatusInternalServerError)
	}
}

func getBooks(w http.ResponseWriter, r *http.Request) {
	var books []models.Book
	var err error

	queryLimit := r.URL.Query().Get("size")
	limit := -1
	if queryLimit != "" {
		limit, err = strconv.Atoi(queryLimit)
		if err != nil || limit < -1 {
			http.Error(w, "Size is not a valid number", http.StatusBadRequest)
			return
		}
	}

	queryOffset := r.URL.Query().Get("page")
	offset := -1
	if queryOffset != "" {
		offset, err = strconv.Atoi(queryOffset)
		if err != nil || offset < -1 {
			http.Error(w, "Page is not a valid number", http.StatusBadRequest)
			return
		}
	}

	if err := models.DB.Preload("Publisher").Limit(limit).Offset(offset).Find(&books).Error; err != nil {
		fmt.Println(err)
		http.Error(w, "Error finding books", http.StatusInternalServerError)
		return
	}
	w.Header().Add("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(books); err != nil {
		fmt.Println(err)
		http.Error(w, "Error encoding response object", http.StatusInternalServerError)
	}
}

func main() {
	models.InitDbConnection()

	r := mux.NewRouter()
	booksR := r.PathPrefix("/api/book").Subrouter()
	booksR.HandleFunc("", getBooks).Methods(http.MethodGet)
	booksR.HandleFunc("/{id}", getBook).Methods(http.MethodGet)
	booksR.HandleFunc("/{id}/items", getBookItems).Methods(http.MethodGet)

	log.Fatal(http.ListenAndServe(":5000", r))
}
