import 'package:firebase_database/firebase_database.dart';
import 'post.dart';

final databaseReference = FirebaseDatabase.instance.ref();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();

  id.set(post.toJSON());
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJSON());
}
