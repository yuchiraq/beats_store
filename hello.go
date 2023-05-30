package main

import (
	"database/sql"
	"fmt"
	_ "github.com/bobertlo/go-mpg123/mpg123"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/gordonklaus/portaudio"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

type Track struct {
	ID          uint64 `json:"id"`
	Title       string `json:"title"`
	Album       uint64 `json:"album_id"`
	Author      uint64 `json:"author_id"`
	Style       uint   `json:"music_style"`
	Tags        string `json:"tags"`
	Price       uint   `json:"price"`
	Currency    string `json:"price_currency"`
	Duration    int    `json:"duration"`
	RealiseDate string `json:"realise_date"`
	SaleType    uint   `json:"sale_type"`
	BPM         uint   `json:"bpm"`
	ForSale     bool   `json:"for_sale"`
	KBPS        uint   `json:"kbps"`
}

func main() {

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")
		if err != nil {
			fmt.Fprintf(w, "unavailable database Tracks")
			return
		}
		go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " check connection")
		fmt.Fprintf(w, "availible")
	}) // each request calls handler
	http.HandleFunc("/notify", func(w http.ResponseWriter, r *http.Request) {
		_, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")
		if err != nil {
			fmt.Fprintf(w, "unavailable database Tracks")
			return
		}
		fmt.Fprintf(w, "All is good, bro")
	})
	http.HandleFunc("/tracks/all", allTracks)
	http.HandleFunc("/tracks/lastRealises", lastTracks)
	http.HandleFunc("/tracks/random", randomTracks)
	http.HandleFunc("/tracks/getData", getDataTrack)
	http.HandleFunc("/tracks/search", searchTrack)
	http.HandleFunc("/stream", func(w http.ResponseWriter, r *http.Request) {
		trackID := r.URL.Query().Get("ID")

		go fmt.Println(timeNow() + "||-->>" + r.RemoteAddr + " STREAM > " + trackID)

		file, err := os.Open("55.mp3")
		if err != nil {
			panic(err)
			return
		}

		defer file.Close()

		addr, err := net.ResolveUDPAddr("udp", "127.0.0.1:1234")
		if err != nil {
			panic(err)
			return
		}

		err = streamAudioUDP(file, addr)
		if err != nil {
			panic(err)
			return
		}
	})

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

	db, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")

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
		fmt.Fprintf(w, strconv.FormatUint(tracks[i].ID, 10))
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

	db, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")

	if err != nil {
		fmt.Println("Err > ", err.Error())
		return
	}

	defer db.Close()

	var DBrequest = ""

	if style == "" || style == "0" {
		DBrequest = "SELECT id FROM tracks ORDER BY RAND() LIMIT " + quantity
	} else {
		DBrequest = "SELECT id FROM tracks WHERE music_style = " + style + " ORDER BY RAND() LIMIT " + quantity
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
		fmt.Fprintf(w, strconv.FormatUint(tracks[i].ID, 10))
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

	db, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")

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
			DBrequest = "SELECT id FROM tracks LIMIT " + quantity
		} else {
			DBrequest = "SELECT id FROM tracks WHERE music_style = " + style + " LIMIT " + quantity
		}
	} else {
		if style == "" || style == "0" {
			DBrequest = "SELECT id FROM tracks"
		} else {
			DBrequest = "SELECT id FROM tracks WHERE music_style = " + style
		}
	}

	DBrequest += " ORDER BY realise_date DESC"

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
		fmt.Fprintf(w, strconv.FormatUint(tracks[i].ID, 10))
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

	db, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")

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
		fmt.Fprintf(w, strconv.FormatUint(tracks[0].ID, 10)+endl)
		fmt.Fprintf(w, tracks[0].Title+endl)
		fmt.Fprintf(w, strconv.FormatUint(tracks[0].Author, 10)+endl)
		fmt.Fprintf(w, strconv.FormatInt(int64(tracks[0].Duration), 10))
	} else if dataType == "title" {
		fmt.Fprintf(w, tracks[0].Title)
	} else if dataType == "author" {
		fmt.Fprintf(w, strconv.FormatUint(tracks[0].Author, 10))
	} else if dataType == "album" {
		fmt.Fprintf(w, strconv.FormatUint(tracks[0].Album, 10))
	} else if dataType == "duration" {
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[0].Duration), 10))
	} else if dataType == "full" {
		fmt.Fprintf(w, strconv.FormatUint(tracks[0].ID, 10)+endl+tracks[0].Title+endl+strconv.FormatUint(tracks[0].Album, 10)+
			endl+strconv.FormatUint(tracks[0].Author, 10)+endl+strconv.FormatUint(uint64(tracks[0].Style), 10)+endl+tracks[0].Tags+endl+
			strconv.FormatUint(uint64(tracks[0].Price), 10)+endl+tracks[0].Currency+endl+strconv.FormatUint(uint64(tracks[0].Duration), 10)+endl+
			tracks[0].RealiseDate+endl+strconv.FormatUint(uint64(tracks[0].SaleType), 10)+endl+strconv.FormatUint(uint64(tracks[0].BPM), 10)+endl+
			strconv.FormatBool(tracks[0].ForSale)+endl+strconv.FormatUint(uint64(tracks[0].KBPS), 10))
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

	db, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")

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
		fmt.Fprintf(w, strconv.FormatUint(tracks[i].ID, 10))
		if i != len(tracks)-1 {
			fmt.Fprintf(w, endl)
		}
	}
}

func streamAudioUDP(audioFile io.Reader, addr *net.UDPAddr) error {
	conn, err := net.DialUDP("udp", nil, addr)
	chk(err)

	defer conn.Close()

	buf := make([]byte, 1024)

	for {
		n, err := audioFile.Read(buf)
		if err != nil {
			if err != io.EOF {
				panic(err)
				return err
			}
			break
		}

		_, err = conn.Write(buf[:n])
		chk(err)

	}

	return nil
}
