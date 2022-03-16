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

Future<List<Post>> getAllPosts() async {
  DatabaseEvent databaseEvent = await databaseReference.child('posts/').once();
  DataSnapshot dataSnapshot = databaseEvent.snapshot;
  List<Post> posts = [];

  if (dataSnapshot.value != null) {
    Map<String, dynamic> postmap =
        Map<String, dynamic>.from(dataSnapshot.value as Map);

    postmap.forEach((key, value) {
      Post post = createPost(value);
      post.setId(databaseReference.child('posts/' + key));
      posts.add(post);
    });
  }

  return posts;
}
