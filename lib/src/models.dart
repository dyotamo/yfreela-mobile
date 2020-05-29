import 'package:simple_gravatar/simple_gravatar.dart';

class Freela {
  String name, city, bio, email, phone, category;
  double rating;

  String get image => Gravatar(email).imageUrl(
      size: 150,
      defaultImage: GravatarImage.retro,
      rating: GravatarRating.pg,
      fileExtension: true);

  Freela.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    bio = json['bio'];
    email = json['email'];
    phone = json['phone'];
    category = json['category'];
    rating = 3.5;
  }
}

class Login {
  String email, password;
}
