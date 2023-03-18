class DetailCoinResponse {
  String? id;
  String? symbol;
  String? name;
  Description? description;
  Image? image;
  String? genesisDate;
  double? sentimentVotesUpPercentage;
  double? sentimentVotesDownPercentage;
  int? marketCapRank;
  int? coingeckoRank;
  double? coingeckoScore;
  double? developerScore;
  double? communityScore;
  double? liquidityScore;
  double? publicInterestScore;
  MarketData? marketData;
  String? lastUpdated;

  DetailCoinResponse(
      {this.id,
      this.symbol,
      this.name,
      this.description,
      this.image,
      this.genesisDate,
      this.sentimentVotesUpPercentage,
      this.sentimentVotesDownPercentage,
      this.marketCapRank,
      this.coingeckoRank,
      this.coingeckoScore,
      this.developerScore,
      this.communityScore,
      this.liquidityScore,
      this.publicInterestScore,
      this.marketData,
      this.lastUpdated});

  DetailCoinResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    description = json['description'] != null ? new Description.fromJson(json['description']) : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    genesisDate = json['genesis_date'];
    sentimentVotesUpPercentage = json['sentiment_votes_up_percentage'];
    sentimentVotesDownPercentage = json['sentiment_votes_down_percentage'];
    marketCapRank = json['market_cap_rank'];
    coingeckoRank = json['coingecko_rank'];
    coingeckoScore = json['coingecko_score'];
    developerScore = json['developer_score'];
    communityScore = json['community_score'];
    liquidityScore = json['liquidity_score'];
    publicInterestScore = json['public_interest_score'];
    marketData = json['market_data'] != null ? new MarketData.fromJson(json['market_data']) : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['genesis_date'] = this.genesisDate;
    data['sentiment_votes_up_percentage'] = this.sentimentVotesUpPercentage;
    data['sentiment_votes_down_percentage'] = this.sentimentVotesDownPercentage;
    data['market_cap_rank'] = this.marketCapRank;
    data['coingecko_rank'] = this.coingeckoRank;
    data['coingecko_score'] = this.coingeckoScore;
    data['developer_score'] = this.developerScore;
    data['community_score'] = this.communityScore;
    data['liquidity_score'] = this.liquidityScore;
    data['public_interest_score'] = this.publicInterestScore;
    if (this.marketData != null) {
      data['market_data'] = this.marketData!.toJson();
    }
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class Description {
  String? en;
  String? ru;
  String? ja;
  String? ko;
  String? id;

  Description({this.en, this.ru, this.ja, this.ko, this.id});

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ru = json['ru'];
    ja = json['ja'];
    ko = json['ko'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ru'] = this.ru;
    data['ja'] = this.ja;
    data['ko'] = this.ko;
    data['id'] = this.id;
    return data;
  }
}

class Image {
  String? thumb;
  String? small;
  String? large;

  Image({this.thumb, this.small, this.large});

  Image.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    small = json['small'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['small'] = this.small;
    data['large'] = this.large;
    return data;
  }
}

class MarketData {
  CurrentPrice? currentPrice;
  double? priceChange24h;
  double? priceChangePercentage24h;
  String? lastUpdated;

  MarketData({this.currentPrice, this.priceChange24h, this.priceChangePercentage24h, this.lastUpdated});

  MarketData.fromJson(Map<String, dynamic> json) {
    currentPrice = json['current_price'] != null ? new CurrentPrice.fromJson(json['current_price']) : null;
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentPrice != null) {
      data['current_price'] = this.currentPrice!.toJson();
    }
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class CurrentPrice {
  double? idr;
  double? sgd;
  double? usd;

  CurrentPrice({this.idr, this.sgd, this.usd});

  CurrentPrice.fromJson(Map<String, dynamic> json) {
    idr = double.parse(json['idr'].toString());
    sgd = double.parse(json['sgd'].toString());
    usd = double.parse(json['usd'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idr'] = this.idr;
    data['sgd'] = this.sgd;
    data['usd'] = this.usd;
    return data;
  }
}
