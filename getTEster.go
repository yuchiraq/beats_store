package main

import (
	"fmt"
	"net"
	"net/http"
	"strconv"
	"time"
)

var count = 0

func main() {

	for {
		go test()
	}
}

func test() {
	t := &http.Transport{
		Dial: (&net.Dialer{
			Timeout:   60 * time.Second,
			KeepAlive: 30 * time.Second,
		}).Dial,
		// We use ABSURDLY large keys, and should probably not.
		TLSHandshakeTimeout: 60 * time.Second,
	}
	c := &http.Client{
		Transport: t,
	}
	r, err := c.Get("https://beatsuscentral1-fad3fyv2pa-uc.a.run.app/notify")

	if err != nil {
		fmt.Println("error >>> " + err.Error())
		count++
		fmt.Println(strconv.Itoa(count))
		return
	}
	defer r.Body.Close()

	bs := make([]byte, 1014)
	n, err := r.Body.Read(bs)

	fmt.Println(string((bs[:n])))
	count++
	fmt.Println(strconv.Itoa(count))
}
