
class Profile {
  final List<String> photos;
  final String name;
  final String bio;
  final String id;
  final String match;
  final String dp;
  final String index;

  Profile({
    this.photos,
    this.name,
    this.bio,
    this.id,

    this.match,
    this.dp,
    this.index

  });


  Profile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        photos = json['photos'],
        id = json['id'],
        bio = json['bio'],
        match = json['match'],
        dp=json['dp'],
        index=json['index']
  ;

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'photos': photos,
        'bio':bio,
        'id':id,
        'match':match,
        'dp':dp,
        'index':index
      };



}
