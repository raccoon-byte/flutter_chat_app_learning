import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Post {
  String body;
  String author;
  int likes = 0;
  bool userLiked = false;

  Post(this.body, this.author);

  void likePost() {
    userLiked = !userLiked;
    if (userLiked) {
      likes += 1;
    } else {
      likes -= 1;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seth\'s TestApp',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    setState(() {
      posts.add(Post(text, "Joseph"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Posts")),
        body: Column(children: <Widget>[
          Expanded(child: PostList(posts)),
          Expanded(child: TextInputWidget(newPost))
        ]));
  }
}

class TextInputWidget extends StatefulWidget {
  late final Function(String) callback;

  TextInputWidget(this.callback);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: "Type a message:",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.orange,
              tooltip: "Post message",
              onPressed: click,
            )));
  }
}

class PostList extends StatefulWidget {
  final List<Post> listItems;
  PostList(this.listItems);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listItems.length,
      itemBuilder: (context, index) {
        var post = widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text(post.body),
            subtitle: Text(post.author),
          )),
          Row(
            children: <Widget>[
              Container(
                child:
                    Text(post.likes.toString(), style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => like(post.likePost),
                  color: post.userLiked ? Colors.green : Colors.black)
            ],
          )
        ]));
      },
    );
  }
}
