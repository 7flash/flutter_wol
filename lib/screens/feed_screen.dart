import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wol/customColors.dart';
import 'package:wol/screens/camera_screen.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CameraScreen(),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Icon(Icons.camera_alt),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  CustomColors.GreenLight,
                  CustomColors.GreenDark
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.GreenShadow,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(0.0, 0.0),
                ),
              ]),
        ),
      ),
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        leading: new Icon(Icons.camera_alt),
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
            future: Firestore.instance.collection("activities").getDocuments(),
            builder: (context, snapshot) {
              return Flexible(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                                  ),
                                ),
                                new SizedBox(
                                  width: 10.0,
                                ),
                                new Text(
                                  "imthpk",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
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
                          "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.heart,
                                ),
                                new SizedBox(
                                  width: 16.0,
                                ),
                                new Icon(
                                  FontAwesomeIcons.comment,
                                ),
                                new SizedBox(
                                  width: 16.0,
                                ),
                                new Icon(FontAwesomeIcons.paperPlane),
                              ],
                            ),
                            new Icon(FontAwesomeIcons.bookmark)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Liked by pawankumar, pk and 528,331 others",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                              ),
                            ),
                            new SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: new TextField(
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Add a comment...",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("1 Day Ago",
                            style: TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
              );
              // return snapshot.hasData ? Center(
              //   child: Text(""+snapshot.data.documents[0].author),
              // )
              // : CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
