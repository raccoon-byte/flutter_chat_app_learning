import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_testing1/database.dart';

class Post {
  String body;
  String author;
  Set usersLiked = {};
  late DatabaseReference _id;

  Post(this.body, this.author);

  void likePost(User user) {
    if (this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJSON() {
    return {'author': author, 'usersLiked': usersLiked.toList(), 'body': body};
  }
}
