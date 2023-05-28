package main

import (
	"bytes"
	"database/sql"
	"encoding/binary"
	"fmt"
	"github.com/bobertlo/go-mpg123/mpg123"
	_ "github.com/bobertlo/go-mpg123/mpg123"
	_ "github.com/go-sql-driver/mysql"
	"github.com/gordonklaus/portaudio"
	_ "github.com/gordonklaus/portaudio"
	"log"
	"net/http"
	"strconv"
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

	fileName := "55.mp3"

	decoder, err := mpg123.NewDecoder("")

	chk(err)

	chk(decoder.Open(fileName))
	defer decoder.Close()

	rate, channels, _ := decoder.GetFormat()

	decoder.FormatNone()
	decoder.Format(rate, channels, mpg123.ENC_SIGNED_16)

	portaudio.Initialize()
	defer portaudio.Terminate()

	out := make([]int16, 8192)

	stream, err := portaudio.OpenDefaultStream(0, channels, float64(rate), len(out), &out)
	chk(err)

	defer stream.Close()

	chk(stream.Start())

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")
		if err != nil {
			fmt.Fprintf(w, "unavailable database Tracks")
			return
		}
		fmt.Println(time.Now().String() + "||-->>" + r.RemoteAddr + " check connection")
		fmt.Fprintf(w, "availible")
	}) // each request calls handler
	http.HandleFunc("/lastRealises", lastRealises)
	http.HandleFunc("/getDataTrack", getDataTrack)
	http.HandleFunc("/tracks/search", func(w http.ResponseWriter, r *http.Request) {

		fmt.Println(time.Now().String() + "||-->>" + r.RemoteAddr + " GET track search")

		title := r.URL.Query().Get("title")
		if title == "" {
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
		results, err := db.Query("SELECT id FROM tracks WHERE title LIKE '%" + title + "%'")

		if err != nil {
			fmt.Println("Err > ", err.Error())
			return
		}

		tracks := []Track{}
		for results.Next() {
			var trackCur Track
			err = results.Scan(&trackCur.ID)
			if err != nil {
				panic(err.Error())
			}
			tracks = append(tracks, trackCur)
		}

		for i := 0; i < len(tracks); i++ {
			fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[i].ID), 10))
			if i != len(tracks)-1 {
				fmt.Fprintf(w, endl)
			}
		}
	})
	http.HandleFunc("/notify", func(w http.ResponseWriter, r *http.Request) {
		_, err := sql.Open("mysql", "beat_user:p@ssword123Beats_User@/beats")
		if err != nil {
			fmt.Fprintf(w, "unavailable database Tracks")
			return
		}
		fmt.Fprintf(w, "All is good, bro")
	})

	http.HandleFunc("/audio", func(w http.ResponseWriter, r *http.Request) {

		w.Header().Set("Connection", "Keep-Alive")
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("X-Content-Type-Options", "nosniff")
		w.Header().Set("Transfer-Encoding", "chunked")
		w.Header().Set("Content-Type", "audio/wave")
		for {
			audio := make([]byte, 2*len(out))
			_, err = decoder.Read(audio)
			if err == mpg123.EOF {
				return
			}
			chk(err)

			chk(binary.Read(bytes.NewBuffer(audio), binary.LittleEndian, out))
			chk(stream.Write())

			//binary.Write(w, binary.BigEndian, &buffer)
			//flusher.Flush() // Trigger "chunked" encoding and send a chunk...
			//return
		}
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}

func chk(err error) {
	if err != nil {
		panic(err)
	}
}

func lastRealises(w http.ResponseWriter, r *http.Request) {

	fmt.Println(time.Now().String() + "||-->>" + r.RemoteAddr + " GET lastRealises")
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

	tracks := []Track{}
	for results.Next() {
		var trackCur Track
		err = results.Scan(&trackCur.ID)
		if err != nil {
			panic(err.Error())
		}
		tracks = append(tracks, trackCur)
	}

	for i := 0; i < len(tracks); i++ {
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[i].ID), 10))
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

	fmt.Println(time.Now().String() + "||-->>" + r.RemoteAddr + " GET data for " + id + " track->" + dataType)

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

	tracks := []Track{}
	for results.Next() {
		var trackCur Track
		err = results.Scan(&trackCur.ID, &trackCur.Title, &trackCur.Album, &trackCur.Author, &trackCur.Style, &trackCur.Tags, &trackCur.Price, &trackCur.Currency, &trackCur.Duration, &trackCur.RealiseDate, &trackCur.SaleType, &trackCur.BPM, &trackCur.ForSale, &trackCur.KBPS)
		chk(err)
		tracks = append(tracks, trackCur)
	}

	if dataType == "" {
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[0].ID), 10)+endl)
		fmt.Fprintf(w, tracks[0].Title+endl)
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[0].Author), 10)+endl)
		fmt.Fprintf(w, strconv.FormatInt(int64(tracks[0].Duration), 10))
	} else if dataType == "title" {
		fmt.Fprintf(w, tracks[0].Title)
	} else if dataType == "author" {
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[0].Author), 10))
	} else if dataType == "album" {
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[0].Album), 10))
	} else if dataType == "duration" {
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[0].Duration), 10))
	} else if dataType == "full" {
		fmt.Fprintf(w, strconv.FormatUint(uint64(tracks[0].ID), 10)+endl+tracks[0].Title+endl+strconv.FormatUint(uint64(tracks[0].Album), 10)+
			endl+strconv.FormatUint(uint64(tracks[0].Author), 10)+endl+strconv.FormatUint(uint64(tracks[0].Style), 10)+endl+tracks[0].Tags+endl+
			strconv.FormatUint(uint64(tracks[0].Price), 10)+endl+tracks[0].Currency+endl+strconv.FormatUint(uint64(tracks[0].Duration), 10)+endl+
			tracks[0].RealiseDate+endl+strconv.FormatUint(uint64(tracks[0].SaleType), 10)+endl+strconv.FormatUint(uint64(tracks[0].BPM), 10)+endl+
			strconv.FormatBool(tracks[0].ForSale)+endl+strconv.FormatUint(uint64(tracks[0].KBPS), 10))
	} else {
		fmt.Fprintf(w, "your error 2")
	}

}
