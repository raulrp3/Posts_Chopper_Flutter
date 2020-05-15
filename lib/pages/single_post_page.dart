import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chopper_flutter/services/post_api_service.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  final int id;

  SinglePostPage({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chopper Blog',
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<PostApiService>(context).getPost(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Map post = json.decode(snapshot.data.bodyString);
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Padding _buildPost(Map post) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Text(
            post['title'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            post['body'],
          ),
        ],
      ),
    );
  }
}
