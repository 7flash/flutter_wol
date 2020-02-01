import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wol/models/activity_model.dart';
import 'package:wol/screens/camera_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CameraScreen(),
              ),
            );
          },
        ),
        title: Text("NYX Activities"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(Icons.send),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
            future: Firestore.instance
                .collection("activities")
                .orderBy("timestamp", descending: true)
                .getDocuments(),
            builder: (context, snapshot) {
              return Flexible(
                child: snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          var activity = ActivityModel.fromDocument(
                            snapshot.data.documents[index],
                          );

                          final title = activity.title;
                          final image = activity.image;
                          final timestamp = timeago.format(
                            DateTime.now().subtract(
                              Duration(
                                seconds:
                                    (DateTime.now().millisecondsSinceEpoch /
                                                1000 -
                                            activity.timestamp)
                                        .toInt(),
                              ),
                            ),
                          );

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 16.0, 8.0, 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        AutoSizeText(
                                          title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    new IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: null,
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: new Image.network(
                                  image,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "started $timestamp",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
