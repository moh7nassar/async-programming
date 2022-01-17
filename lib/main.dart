import 'dart:convert';
import 'dart:async';
import 'package:aync_programming/post.dart';
import 'package:aync_programming/postService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

int info(int x) {
  return x;
}

Stream getData() {
  Stream myStream = Stream.periodic(Duration(seconds: 1), (value) => value);
  return myStream;
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  int i = 0;
  var _start=0;
  Future FetchData() async {
    var res = await http.get("https://jsonplaceholder.typicode.com/photos");
    if (res.statusCode == 200) {
      // 200 means that the operation is successful.
      var obj = json.decode(res.body);
      return obj;
    }
  }
  start(int i){
    if(_timer!=null){
      _timer.cancel();
    }
    setState(() {
      _start=i;
    });
    _timer=Timer.periodic(Duration(milliseconds: 700), (timer)=>setState((){
      _start<1? _timer.cancel():_start-=1;
    }));
  }
  pause(){
    if(_timer!=null){
      _timer.cancel();
    }
  }
  continueCount(){
    start(_start);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TimerApp"),
      ),
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_start", style:TextStyle(fontSize: 72)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(onPressed: ()=> start(10), icon: Icon(Icons.replay), label: Text("Restart")),
                FlatButton.icon(onPressed: pause, icon: Icon(Icons.pause), label: Text("Pause")),
                FlatButton.icon(onPressed: continueCount, icon: Icon(Icons.play_arrow), label: Text("Continue")),
              ],
            ),
          ],

        ),
      )
    );
  }
}
/*
return Scaffold(
      appBar: AppBar(title: Text("Api")),
      body: Center(
        child: null,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var p = PostApi();
          List<Post> data = await p.fetchData();

          for (final i in data) {
            print("${i.id}");
            print("${i.userId}");
            print(i.title);
            print(i.body);
          }
        },
      ),
    );
*/
/*
return Scaffold(
      appBar: AppBar(title: Text("Demo")),
      body: Center(
        child: FutureBuilder(
          future: FetchData(),
          builder: (_, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(snapShot.data[index]['title']),
                    leading: CircleAvatar(backgroundImage: NetworkImage(snapShot.data[index]["thumbnailUrl"]),),
                    subtitle: Text('${snapShot.data[index]['id']}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
*/

/*
return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1), (a) => a),
      builder: (ctx, snapShot) {
        return Scaffold(
          appBar: AppBar(
            // snapShot.hasData tells us if the stream has data or not.
            // data from stream is perceived through snapShot.data.
            // ConnectionState.waiting indicates to the amount of delay the stream would take.
            title: Text((snapShot.hasData && snapShot.data<10 && snapShot.data>0 ) ? "${snapShot.data}" : "Demo"),
          ),
          body: Column(
            children: [snapShot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Text("Done!"),
              RaisedButton(onPressed:() async {
                await for(final item in getData()){
                  if(item>10) break;
                  setState(() {
                    i = item;
                  });
                }
              }),
              Text("${i}"),
            ]
          ),
        );
      },
    );
*/

/*
return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2), () => info(3)),
      builder: (ctx, snapShot) {
        return Scaffold(
          appBar: AppBar(
            // snapShot.hasData tells us if the future has data or not.
            // data from Future is perceived through snapShot.data.
            // ConnectionState.waiting indicates to the amount of delay the future would take.
            title: Text(snapShot.hasData ? "${snapShot.data}" : "Demo"),
          ),
          body: Center(
            child: snapShot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Text("Done!"),
          ),
        );
      },
    );
*/
