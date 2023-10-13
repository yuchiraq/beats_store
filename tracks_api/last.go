package tracks_api

import (
	"awesomeProject/base"
	"database/sql"
	"fmt"
	"net/http"
)

func Last(w http.ResponseWriter, r *http.Request) {
	go fmt.Println(base.TimeNow() + "||-->>" + r.RemoteAddr + " GET lastTracks")
	endl := "|||"
	//code := r.URL.Query().Get("code")

	style := r.URL.Query().Get("style")
	quantity := r.URL.Query().Get("quantity")

	db, err := sql.Open("mysql", DataBaseConn)

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	defer db.Close()

	var DBrequest = ""

	/*if quantity == "" {
		fmt.Fprintf(w, "empty arg")
		return
	}*/
	if quantity != "" {
		if style == "" || style == "0" {
			DBrequest = "SELECT id FROM tracks ORDER BY realise_date DESC LIMIT " + quantity
		} else {
			DBrequest = "SELECT id FROM tracks ORDER BY realise_date DESC WHERE music_style = " + style + " LIMIT " + quantity
		}
	} else {
		if style == "" || style == "0" {
			DBrequest = "SELECT id FROM tracks ORDER BY realise_date DESC"
		} else {
			DBrequest = "SELECT id FROM tracks WHERE music_style = " + style + " ORDER BY realise_date DESC "
		}
	}

	//DBrequest += " ORDER BY realise_date DESC"

	results, err := db.Query(DBrequest)

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	var tracks []base.Track
	for results.Next() {
		var trackCur base.Track
		err = results.Scan(&trackCur.ID)
		if err != nil {
			panic(err.Error())
		}
		tracks = append(tracks, trackCur)
	}

	for i := 0; i < len(tracks); i++ {
		fmt.Fprintf(w, tracks[i].ID)
		if i != len(tracks)-1 {
			fmt.Fprintf(w, endl)
		}
	}
}
