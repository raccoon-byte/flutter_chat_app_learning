import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Post {
  String body;
  String author;
  Set usersLiked = {};
  late DatabaseReference _id;

  Post(this.body, this.author);

  void likePost(User user) {
    if (usersLiked.contains(user.uid)) {
      usersLiked.remove(user.uid);
    } else {
      usersLiked.add(user.uid);
    }
  }

  void setId(DatabaseReference id) {
    _id = id;
  }

  Map<String, dynamic> toJSON() {
    return {'author': author, 'usersLiked': usersLiked.toList(), 'body': body};
  }
}
