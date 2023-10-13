package tracks_api

import (
	"awesomeProject/base"
	"database/sql"
	"fmt"
	"net/http"
)

func Data(w http.ResponseWriter, r *http.Request) {

	id := r.URL.Query().Get("ID")
	if id == "0" {
		return
	}

	dataType := r.URL.Query().Get("type")

	endl := "|||"

	if id == "" {
		fmt.Fprintf(w, "your error")
		return
	}

	go fmt.Println(base.TimeNow() + "||-->>" + r.RemoteAddr + " GET data for " + id + " track->" + dataType)

	db, err := sql.Open("mysql", DataBaseConn)

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	defer db.Close()
	results, err := db.Query("SELECT * FROM tracks WHERE id = " + "'" + id + "'")

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	var tracks []base.Track
	for results.Next() {
		var trackCur base.Track
		err = results.Scan(&trackCur.ID, &trackCur.Title, &trackCur.Album, &trackCur.Author, &trackCur.Style, &trackCur.Tags, &trackCur.Price, &trackCur.Currency, &trackCur.Duration, &trackCur.RealiseDate, &trackCur.SaleType, &trackCur.BPM, &trackCur.ForSale, &trackCur.KBPS)
		base.Check(err)
		tracks = append(tracks, trackCur)
	}

	if dataType == "" {
		fmt.Fprintf(w, tracks[0].ID+endl)
		fmt.Fprintf(w, tracks[0].Title+endl)
		fmt.Fprintf(w, tracks[0].Author+endl)
		fmt.Fprintf(w, tracks[0].Duration)
	} else if dataType == "title" {
		fmt.Fprintf(w, tracks[0].Title)
	} else if dataType == "author" {
		results, err := db.Query("SELECT name FROM authors where id = " + "'" + tracks[0].Author + "'")
		base.Check(err)

		var authors []base.Author
		for results.Next() {
			var authorCur base.Author
			err = results.Scan(&authorCur.Name)
			base.Check(err)
			authors = append(authors, authorCur)
		}

		fmt.Fprintf(w, authors[0].Name)
	} else if dataType == "album" {
		fmt.Fprintf(w, tracks[0].Album)
	} else if dataType == "duration" {
		fmt.Fprintf(w, tracks[0].Duration)
	} else if dataType == "full" {
		fmt.Fprintf(w, tracks[0].ID+endl+tracks[0].Title+endl+tracks[0].Album+
			endl+tracks[0].Author+endl+tracks[0].Style+endl+tracks[0].Tags+endl+
			tracks[0].Price+endl+tracks[0].Currency+endl+tracks[0].Duration+endl+
			tracks[0].RealiseDate+endl+tracks[0].SaleType+endl+tracks[0].BPM+endl+
			tracks[0].ForSale+endl+tracks[0].KBPS)
	} else {
		fmt.Fprintf(w, "your error 2")
	}

}
