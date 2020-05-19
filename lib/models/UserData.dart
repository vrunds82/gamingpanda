class UserData {

  String userId;
  String aboutUs;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String userName;
  String biography;
  String gender;
  String location;
  String country;
  String game1;
  String game2;
  String server;
  String rank;
  String profilePicture;
  String filterGame;
  String filterServer;
  String filterRank;
  String filterCountry;
  int filterAgeStart;
  int filterAgeEnd;
  String filterGender;
  String email;
  int day;
  int month;
  int year;

  UserData(
      {
        this.userId,
        this.aboutUs,

        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.image5,
        this.image6,
        this.userName,
        this.biography,
        this.gender,
        this.location,
        this.country,
        this.game1,
        this.game2,
        this.server,
        this.rank,
        this.profilePicture,
        this.filterGame,
        this.filterServer,
        this.filterRank,
        this.filterCountry,
        this.filterAgeStart,
        this.filterAgeEnd,
        this.filterGender,
        this.email,
        this.day,
        this.month,
        this.year});

  UserData.fromJson(Map<String, dynamic> json) {

    userId = json['userId'];
    aboutUs = json['aboutUs'];

    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    image5 = json['image5'];
    image6 = json['image6'];
    userName = json['userName'];
    biography = json['biography'];
    gender = json['gender'];
    location = json['location'];
    country = json['country'];
    game1 = json['game1'];
    game2 = json['game2'];
    server = json['server'];
    rank = json['rank'];
    profilePicture = json['profilePicture'];
    filterGame = json['filterGame'];
    filterServer = json['filterServer'];
    filterRank = json['filterRank'];
    filterCountry = json['filterCountry'];
    filterAgeStart = json['filterAgeStart'];
    filterAgeEnd = json['filterAgeEnd'];
    filterGender = json['filterGender'];
    email = json['email'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userId'] = this.userId;
    data['aboutUs'] = this.aboutUs;

    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['image5'] = this.image5;
    data['image6'] = this.image6;
    data['userName'] = this.userName;
    data['biography'] = this.biography;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['country'] = this.country;
    data['game1'] = this.game1;
    data['game2'] = this.game2;
    data['server'] = this.server;
    data['rank'] = this.rank;
    data['profilePicture'] = this.profilePicture;
    data['filterGame'] = this.filterGame;
    data['filterServer'] = this.filterServer;
    data['filterRank'] = this.filterRank;
    data['filterCountry'] = this.filterCountry;
    data['filterAgeStart'] = this.filterAgeStart;
    data['filterAgeEnd'] = this.filterAgeEnd;
    data['filterGender'] = this.filterGender;
    data['email'] = this.email;
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}