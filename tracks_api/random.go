package tracks_api

import (
	"awesomeProject/base"
	_ "awesomeProject/base"
	"database/sql"
	"fmt"
	_ "github.com/bobertlo/go-mpg123/mpg123"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/gordonklaus/portaudio"
	"net/http"
)

func Random(w http.ResponseWriter, r *http.Request) {
	go fmt.Println(base.TimeNow() + "||-->>" + r.RemoteAddr + " GET RandomTracks")
	endl := "|||"
	//code := r.URL.Query().Get("code")

	style := r.URL.Query().Get("style")
	quantity := r.URL.Query().Get("quantity")

	if quantity == "" {
		fmt.Fprintf(w, "empty arg")
		return
	}

	db, err := sql.Open("mysql", DataBaseConn)

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	defer db.Close()

	var DBrequest = ""

	if quantity != "0" {
		if style == "" || style == "0" {
			DBrequest = "SELECT id FROM tracks ORDER BY RAND() LIMIT " + quantity
		} else {
			DBrequest = "SELECT id FROM tracks WHERE music_style = " + style + " ORDER BY RAND() LIMIT " + quantity
		}
	} else {
		if style == "" || style == "0" {
			DBrequest = "SELECT id FROM tracks ORDER BY RAND()"
		} else {
			DBrequest = "SELECT id FROM tracks WHERE music_style = " + style + " ORDER BY RAND()"
		}
	}

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
