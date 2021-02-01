
class Profile {
  final String id;
  final List<String> photos;
  final String name;
  final String age;
  final String gender;
  final String games;
  final String country;
  final String bio;
  final String dp;
  final String server;
  final bool liked;
  final bool disliked;




  Profile({
    this.photos,
    this.name,
    this.bio,
    this.id,
    this.dp,
    this.liked,
    this.gender,
    this.country,
    this.age,
    this.games,
    this.disliked,
    this.server
  });


  Profile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        photos = json['photos'],
        id = json['id'],
        bio = json['bio'],
        dp=json['dp'],
        liked=json['liked'],
        disliked=json['disliked'],
  games=json['games'],
  country=json['country'],
  age=json['age'],
  gender=json['gender'],
        server=json['server']
  ;

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'photos': photos,
        'bio':bio,
        'id':id,
        'dp':dp,
        'liked':liked,
        'server':server

      };



}
