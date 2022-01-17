import 'package:flutter/foundation.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    @required this.userId,
    @required this.id,
    @required this.title,
    @required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> jsonData) {
    return Post(
      userId: jsonData['userId'],
      id: jsonData['id'],
      title: jsonData['title'],
      body: jsonData['body'],
    );
  }




}

class Posts {
  List<dynamic> postList ;

  Posts({@required this.postList});

  factory Posts.fromJson(Map<String, dynamic> jsonData) {
    return Posts(
      postList: jsonData['postList'],
    );
  }

}
