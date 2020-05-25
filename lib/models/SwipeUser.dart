class SwipeUser {
  String userId;
  String aboutUs;
  String images;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String userName;
  String gender;
  String location;
  String country;
  String game1;
  String game2;
  String server;
  String rank;
  String profilePicture;
  bool liked;
  String email;
  int day;
  int month;
  int year;

  SwipeUser(
      {this.userId,
        this.aboutUs,
        this.images,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.image5,
        this.image6,
        this.userName,
        this.gender,
        this.location,
        this.country,
        this.game1,
        this.game2,
        this.server,
        this.rank,
        this.profilePicture,
        this.liked,
        this.email,
        this.day,
        this.month,
        this.year});

  SwipeUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    aboutUs = json['aboutUs']??"";
    images = json['images']??"";
    image1 = json['image1']??"";
    image2 = json['image2']??"";
    image3 = json['image3']??"";
    image4 = json['image4']??"";
    image5 = json['image5']??"";
    image6 = json['image6']??"";
    userName = json['userName']??"";
    gender = json['gender']??"";
    location = json['location']??"";
    country = json['country']??"";
    game1 = json['game1']??"";
    game2 = json['game2']??"";
    server = json['server']??"";
    rank = json['rank']??"";
    profilePicture = json['profilePicture']??"";
    liked = json['liked'];
    email = json['email']??"";
    day = json['day']??0;
    month = json['month']??0;
    year = json['year']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['aboutUs'] = this.aboutUs;
    data['images'] = this.images;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['image5'] = this.image5;
    data['image6'] = this.image6;
    data['userName'] = this.userName;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['country'] = this.country;
    data['game1'] = this.game1;
    data['game2'] = this.game2;
    data['server'] = this.server;
    data['rank'] = this.rank;
    data['profilePicture'] = this.profilePicture;
    data['liked'] = this.liked;
    data['email'] = this.email;
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}
