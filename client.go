package main

import (
	"bufio"
	"bytes"
	"fmt"
	"github.com/faiface/beep"
	"github.com/faiface/beep/speaker"
	"github.com/faiface/beep/wav"
	"net"
)

const (
	udpAddress = "localhost:9000"
)

/*
	func main() {
		addr, err := net.ResolveUDPAddr("udp", udpAddress)
		if err != nil {
			fmt.Println("Error resolving address:", err)
			os.Exit(1)
		}

		conn, err := net.ListenUDP("udp", addr)
		if err != nil {
			fmt.Println("Error listening on UDP:", err)
			os.Exit(1)
		}
		defer conn.Close()

		buffer := make([]byte, 1024)
		//streamer := beep.Streamer{}
		// Инициализация спикера
		speaker.Init(48000, 512)

		for {
			// Чтение данных из UDP
			n, _, err := conn.ReadFromUDP(buffer)
			if err != nil {
				fmt.Println("Error reading from UDP:", err)
				continue
			}

			if n == 0 {
				continue
			}

			// Создание декодера WAV из полученных данных
			decoder, err, _ := wav.Decode(bufio.NewReader(bytes.NewReader(buffer[:n])))
			if err != nil {
				fmt.Println("Error creating WAV decoder:", err)
				continue
			}

			//streamer = beep.Append(decoder)

			//if !speaker.IsPlaying() {
			speaker.Play(beep.Seq(beep.Streamer(decoder), beep.Callback(func() {
				//streamer = beep.Streamer{}
			})))
			//}

			time.Sleep(10 * time.Millisecond)
		}
	}
*/
func main( /*addr *net.UDPAddr*/ ) {
	addr, _ := net.ResolveUDPAddr("udp", "localhost:9000")
	conn, err := net.ListenUDP("udp", addr)
	if err != nil {
		panic(err)
	}
	defer conn.Close()

	buf := make([]byte, 1024)
	speaker.Init(48000, 512)
	i := 1
	for {
		n, _, err := conn.ReadFromUDP(buf)
		if err != nil {
			panic(err)
		}
		buffer := make([]byte, 1024)
		decoder, _, err := wav.Decode(bufio.NewReader(bytes.NewReader(buffer[:n])))
		if err != nil {
			fmt.Println("Error creating WAV decoder:", err)
			continue
		}

		speaker.Play(beep.Seq(beep.Streamer(decoder), beep.Callback(func() {
			//streamer = beep.Streamer{}
		})))
		// Обработка пришедших данных аудиопотока
		// ...
		fmt.Println("get pocket %1", i, n)
		i++
	}
}
