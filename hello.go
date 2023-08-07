package main

import (
	"database/sql"
	"fmt"
	_ "github.com/bobertlo/go-mpg123/mpg123"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/gordonklaus/portaudio"
	"io"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

type Track struct {
	ID          string `json:"id"`
	Title       string `json:"title"`
	Album       string `json:"album_id"`
	Author      string `json:"author_id"`
	Style       string `json:"music_style"`
	Tags        string `json:"tags"`
	Price       string `json:"price"`
	Currency    string `json:"price_currency"`
	Duration    string `json:"duration"`
	RealiseDate string `json:"realise_date"`
	SaleType    string `json:"sale_type"`
	BPM         string `json:"bpm"`
	ForSale     string `json:"for_sale"`
	KBPS        string `json:"kbps"`
}

type Author struct {
	ID        string `json:"id"`
	Name      string `json:"name"`
	Style     string `json:"music_style"`
	AboutInfo string `json:"about_info"`
}

type Album struct {
	ID          string `json:"id"`
	Title       string `json:"title"`
	Author      string `json:"author_id"`
	Quantity    string `json:"quantity"`
	Style       string `json:"music_style"`
	AboutInfo   string `json:"tags"`
	Price       string `json:"price"`
	Currency    string `json:"price_currency"`
	Duration    string `json:"duration"`
	RealiseDate string `json:"realise_date"`
	SaleType    string `json:"sale_type"`
	ForSale     string `json:"for_sale"`
	Preview     string `json:"preview"`
}

/*tcp(34.69.28.110)*/
var DataBaseConn = "beat_user:p@ssword123Beats_User@/beats"

func main() {

	http.HandleFunc("/check", func(w http.ResponseWriter, r *http.Request) {
		go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " CHECK")
		db, err := sql.Open("mysql", DataBaseConn)
		if err != nil {
			fmt.Fprintf(w, "unavailable database beats")
			return
		}
		defer db.Close()
		results, err := db.Query("SELECT * from tracks LIMIT 1")
		if err != nil {
			fmt.Fprintf(w, "unavailable database beats")
			return
		}
		err = results.Close()
		if err != nil {
			return
		}
		fmt.Fprintf(w, "availible")
	})
	http.HandleFunc("/notify", func(w http.ResponseWriter, r *http.Request) {
		go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " GET notify")
		db, err := sql.Open("mysql", DataBaseConn)
		if err != nil {
			fmt.Fprintf(w, "unavailable database Tracks")
			return
		}
		defer db.Close()
		fmt.Fprintf(w, "All is good, bro")
	})
	http.HandleFunc("/tracks/all", allTracks)
	http.HandleFunc("/tracks/lastRealises", lastTracks)
	http.HandleFunc("/tracks/random", randomTracks)
	http.HandleFunc("/tracks/getData", getDataTrack)
	http.HandleFunc("/tracks/search", searchTrack)
	http.HandleFunc("/stream", streamAudio)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func timeNow() string {
	str := strings.Split(time.Now().String(), " ")[0] + " " + strings.Split(time.Now().String(), " ")[1]
	for len(str) < 30 {
		str += " "
	}
	return str
}

func chk(err error) {
	if err != nil {
		panic(err)
	}
}

func allTracks(w http.ResponseWriter, r *http.Request) {

	go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " GET allTracks")
	endl := "|||"
	//code := r.URL.Query().Get("code")

	db, err := sql.Open("mysql", DataBaseConn)

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	defer db.Close()
	results, err := db.Query("SELECT id FROM tracks")

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	var tracks []Track
	for results.Next() {
		var trackCur Track
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

func randomTracks(w http.ResponseWriter, r *http.Request) {
	go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " GET randomTracks")
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

	var tracks []Track
	for results.Next() {
		var trackCur Track
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

func lastTracks(w http.ResponseWriter, r *http.Request) {
	go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " GET lastTracks")
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

	var tracks []Track
	for results.Next() {
		var trackCur Track
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

func getDataTrack(w http.ResponseWriter, r *http.Request) {

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

	go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " GET data for " + id + " track->" + dataType)

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

	var tracks []Track
	for results.Next() {
		var trackCur Track
		err = results.Scan(&trackCur.ID, &trackCur.Title, &trackCur.Album, &trackCur.Author, &trackCur.Style, &trackCur.Tags, &trackCur.Price, &trackCur.Currency, &trackCur.Duration, &trackCur.RealiseDate, &trackCur.SaleType, &trackCur.BPM, &trackCur.ForSale, &trackCur.KBPS)
		chk(err)
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
		chk(err)

		var authors []Author
		for results.Next() {
			var authorCur Author
			err = results.Scan(&authorCur.Name)
			chk(err)
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

func searchTrack(w http.ResponseWriter, r *http.Request) {

	clientRequest := r.URL.Query().Get("request")
	typeSearching := r.URL.Query().Get("type")

	go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " GET track search by " + typeSearching + " >" + clientRequest)

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

	var tracks []Track
	for results.Next() {
		var trackCur Track
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

func streamAudio(w http.ResponseWriter, r *http.Request) {
	filePath := "55.mp3" // Замените на путь к вашему аудио файлу

	file, err := os.Open(filePath)
	if err != nil {
		log.Fatal(err)
	}

	defer file.Close()

	fileHeader := make([]byte, 512)
	file.Read(fileHeader)
	fileStat, _ := file.Stat()
	fileSize := int64(fileStat.Size())

	w.Header().Set("Content-Type", "audio/mpeg")
	w.Header().Set("Content-Length", fmt.Sprintf("%d", fileSize))

	buffer := make([]byte, 512)
	writtenSize := int64(0)

	for {
		if writtenSize >= fileSize {
			break
		}

		bytesRead, err := file.Read(buffer)
		if err != nil && err != io.EOF {
			log.Fatal(err)
		}

		w.Write(buffer[:bytesRead])
		//w.Flush()

		writtenSize += int64(bytesRead)
	}

}
