package base

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
