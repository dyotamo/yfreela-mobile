import 'package:simple_gravatar/simple_gravatar.dart';

class Freela {
  String name, city, bio, email, phone, category;
  int id, likes, dislikes;
  bool liked, disliked;

  String get image => Gravatar(email).imageUrl(
      size: 150,
      defaultImage: GravatarImage.retro,
      rating: GravatarRating.pg,
      fileExtension: true);

  Freela.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    bio = json['bio'];
    email = json['email'];
    phone = json['phone'];
    category = json['category'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    liked = json['liked'];
    disliked = json['disliked'];
  }
}
