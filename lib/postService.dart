import 'dart:convert';

import 'package:aync_programming/post.dart';
import 'package:http/http.dart' as http;


class PostApi {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts/2";


  Future<List<Post>> fetchData() async {
    http.Response res = await http.get(apiUrl);

    //if (res.statusCode == 200) {
    //String data = res.body;
    //var jsonData = jsonDecode(data);
    Posts posts = Posts.fromJson({"postList":[
      {
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
      },
      {
        "userId": 1,
        "id": 2,
        "title": "qui est esse",
        "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
      },
    ]});
    List<Post> pList = posts.postList.map((e) => Post.fromJson(e)).toList();
    return pList;

    //} else {
    //print("statusCode= ${res.statusCode}");
    //}
  }
}
