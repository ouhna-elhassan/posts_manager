class Location{
  final String street;
  final String city;
  final String state;
  final String country;
  final String timezone;

  const Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      street:json['street'],
      city:json['city'],
      state:json['state'],
      country:json['country'],
      timezone:json['timezon'],
    );
  }

}

class User{
  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;

  const User({
    required  this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
 

  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id:json['id'],
      title:json['title'],
      firstName:json['firstName'],
      lastName:json['lastName'],
      picture:json['picture'],

    );
  }

}

class Post{
  final String id;
  final String text;
  final String image;
  final int likes;
  final List<dynamic> tags;
  final String publishDate;
  final User owner;

  const Post({
    required  this.id,
    required this.text,
    required this.image,
    required  this.likes,
    required  this.tags,
    required this.publishDate,
    required this.owner,
  });

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id:json['id'] as String,
      text:json['text'] as String,
      image:json['image'] as String,
      likes:json['likes'] as int,
      tags:json['tags'] as List<dynamic>,
      publishDate:json['publishDate'] as String,
      owner:User.fromJson(json['owner']),
    );
  }

}