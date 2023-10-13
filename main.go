package main

import (
	"awesomeProject/base"
	_ "awesomeProject/base"
	"awesomeProject/tracks_api"
	_ "awesomeProject/tracks_api"
	"database/sql"
	"fmt"
	_ "github.com/bobertlo/go-mpg123/mpg123"
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/gordonklaus/portaudio"
	"io"
	"log"
	"net/http"
	"os"
)

// DataBaseConn /*tcp(34.69.28.110)*/
var DataBaseConn = "beat_user:p@ssword123Beats_User@/beats"

func main() {

	http.HandleFunc("/check", func(w http.ResponseWriter, r *http.Request) {
		go fmt.Println(base.TimeNow() + "||-->>" + r.RemoteAddr + " CHECK")
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
		go fmt.Println(base.TimeNow() + "||-->>" + r.RemoteAddr + " GET notify")
		db, err := sql.Open("mysql", DataBaseConn)
		if err != nil {
			fmt.Fprintf(w, "unavailable database Tracks")
			return
		}
		defer db.Close()
		fmt.Fprintf(w, "All is good, bro")
	})
	http.HandleFunc("/tracks/all", tracks_api.All)
	http.HandleFunc("/tracks/lastRealises", tracks_api.Last)
	http.HandleFunc("/tracks/random", tracks_api.Random)
	http.HandleFunc("/tracks/getData", tracks_api.Data)
	http.HandleFunc("/tracks/search", tracks_api.Search)
	http.HandleFunc("/stream", streamAudio)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func streamAudio(w http.ResponseWriter, r *http.Request) {

	filePath := "files/" + "55.mp3" // Замените на путь к вашему аудио файлу

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
