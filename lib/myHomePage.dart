// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing1/database.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';

class MyHomePage extends StatefulWidget {
  final User user;

  MyHomePage(this.user);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    var post = Post(text, widget.user.displayName);
    post.setId(savePost(post));
    setState(() {
      posts.add(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Posts")),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user)),
          TextInputWidget(this.newPost)
        ]));
  }
}
