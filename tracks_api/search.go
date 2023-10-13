package tracks_api

import (
	"awesomeProject/base"
	"database/sql"
	"fmt"
	"net/http"
)

func Search(w http.ResponseWriter, r *http.Request) {

	clientRequest := r.URL.Query().Get("request")
	typeSearching := r.URL.Query().Get("type")

	go fmt.Println(base.TimeNow() + "||-->>" + r.RemoteAddr + " GET track search by " + typeSearching + " >" + clientRequest)

	if clientRequest == "" {
		fmt.Fprintf(w, "empty arg")
		return
	}

	endl := "|||"

	db, err := sql.Open("mysql", DataBaseConn)

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	defer db.Close()

	var DBrequest = string("")

	if typeSearching == "title" || typeSearching == "" {
		DBrequest = "SELECT id FROM tracks WHERE title LIKE '%" + clientRequest + "%'"
	} else if typeSearching == "tags" {
		DBrequest = "SELECT id FROM tracks WHERE tags LIKE '%" + clientRequest + "%'"
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
