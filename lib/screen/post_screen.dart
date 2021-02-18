import 'package:flutter/material.dart';
import 'package:t_flutter_app/models/post.dart';

class PostScreen extends StatelessWidget{
  final Post post;
  PostScreen(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/${post.img}"),
                  FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                        post.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,),
                        textAlign: TextAlign.center),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Text(
                        "Author "+post.userId.toString(),
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),),
                      onTap: (){
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text("Message"),
                            content: Text("Will be ready in no time"),
                          )
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Text(post.body, style: TextStyle(fontSize: 22),textAlign: TextAlign.start),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}