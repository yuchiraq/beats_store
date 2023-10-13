package base

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
