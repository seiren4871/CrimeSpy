import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/drawer.dart';
import 'package:crimespy/view/elements/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crimespy/model/post_model.dart' as post_model;
import 'package:video_player/video_player.dart';
import 'add_new_post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:crimespy/view/elements/themes.dart';
import 'package:crimespy/view/pages/crimeReport/post_comment.dart';
import 'package:flutter/rendering.dart';
import 'package:crimespy/model/post_model.dart' as post_crime;
import 'package:crimespy/model/user_model.dart' as user_model;

class CrimepostPage extends StatefulWidget {
  const CrimepostPage({Key key}) : super(key: key);

  @override
  _CrimepostPage createState() => _CrimepostPage();
}

class _CrimepostPage extends State<CrimepostPage> {
  int count;
  List<String> urls;
  String picurl;
  String pic;

  void setstate(String url) {
    setState(() {
      urls.add(url);
    });
  }

  VideoPlayerController _controller;

  Future<void> _showVideo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          title: null,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.white.withOpacity(.8),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        _controller.play();
                      }),
                  IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: () {
                        _controller.pause();
                      }),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      _controller.pause();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _videoCard(String vidurl, int index) {
    return RaisedButton(
      onPressed: () => initializeandplay(vidurl, index),
      padding: EdgeInsets.all(1.0),
      child: Icon(
        Icons.play_arrow,
        color: cTextNavy,
      ),
    );
  }

  initializeandplay(String vidurl, int index) async {
    final controller = VideoPlayerController.network(vidurl);
    final old = _controller;
    _controller = controller;

    await controller
      ..initialize().then((_) {
        old?.dispose();
        controller.play();
        controller.setLooping(true);
        setState(() {});
      });
    return _showVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF012148),
        title: Text("Crime Report"),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff023388),
              boxShadow: [
                BoxShadow(
                  color: cTextBlack.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/vote.png',
                  height: 70.0,
                  width: MediaQuery.of(context).size.width * 0.15,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 10.0,
                ),
                AutoSizeText('Voting Previous Records',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Color(0xffdff7fd),
                      fontFamily: 'Archivo-Regular',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          Expanded(
            child: _getStream(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(context, SlideRightRoute(page: AddnewpostPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: cTextNavy,
      ),
    );
  }

  Widget _getStream(BuildContext context) {
    Stream<List<QuerySnapshot>> combinedStream = CombineLatestStream.list([
      Firestore.instance
          .collection("Comment")
          .snapshots(includeMetadataChanges: true),
      Firestore.instance
          .collection("CrimeRecord")
          .where("type", isEqualTo: post_model.crimeType)
          .snapshots(includeMetadataChanges: true),
      Firestore.instance
          .collection("User")
          .snapshots(includeMetadataChanges: true),
      Firestore.instance
          .collection("Vote")
          .snapshots(includeMetadataChanges: true),
    ]);

    return StreamBuilder<List<QuerySnapshot>>(
      stream: combinedStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
        if (snapshot.data == null) {
          return Scaffold(
              body: Center(
            child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: const CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red))),
          ));
        }
        if (snapshot.hasError) {
          print('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Loading");
        }

        List<DocumentSnapshot> comment = snapshot.data[0].documents;
        List<DocumentSnapshot> crimerecord = snapshot.data[1].documents;
        List<DocumentSnapshot> user = snapshot.data[2].documents;
        List<DocumentSnapshot> vote = snapshot.data[3].documents;

        if (snapshot.data[1].documents == null) {
          return Text("There is no record on this crime yet.");
        } else {
          return ListView(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            children: crimerecord.map((doc) {
              return PostCard(context, doc, comment, user, vote);
            }).toList(),
          );
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget PostCard(
      BuildContext context,
      DocumentSnapshot postcrime,
      List<DocumentSnapshot> comment,
      List<DocumentSnapshot> users,
      List<DocumentSnapshot> vote) {
    return AspectRatio(
      // height: MediaQuery.of(context).size.height / 3,
      aspectRatio: 4 / 3,
      child: Card(
        color: Color(0xffdff7fd).withOpacity(.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2,
        child: Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(2.0)),
          padding: EdgeInsets.all(3.0),
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: new BorderRadius.circular(100.0),
                          child: Image(
                            image:
                                AssetImage('assets/img/profile_anonymous.jpg'),
                            width: MediaQuery.of(context).size.width * 0.08,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText(
                            post_crime.getUserEmailFromStream(
                                users, postcrime.data["reporter"]),
                            style: TextStyle(
                              fontFamily: 'Archivo-SemiBold',
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
//        _PostTimeStamp(context),
                  // Expanded(
                  //   flex: 4,
                  //   child: Text(
                  //     ( postcrime.data["datetime"] != null) ?
                  //     postcrime.data["datetime"].toString() : "10 July 2020  23:27",
                  //     style: TextThemes.dateStyle),
                  // ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(5.0)),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.1,
                            2.0,
                            5.0,
                            0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          postcrime.data["detail"],
                          style: TextThemes.info,
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
              ),
//              ),
              SizedBox(height: ScreenUtil().setHeight(5.0)),
//              _PostImage(context ),
              Expanded(
                flex: 6,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 8.0,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(2.0),
                  physics: ClampingScrollPhysics(),
                  itemCount: (postcrime.data["amountOfimages"] != null &&
                          postcrime.data["amountOfvideo"] == null)
                      ? postcrime.data["amountOfimages"] + 0
                      : (postcrime.data["amountOfvideo"] != null &&
                              postcrime.data["amountOfimages"] == null)
                          ? postcrime.data["amountOfvideo"] + 0
                          : (postcrime.data["amountOfvideo"] != null &&
                                  postcrime.data["amountOfimages"] != null)
                              ? postcrime.data["amountOfvideo"] +
                                  postcrime.data["amountOfimages"]
                              : 0,
                  itemBuilder: (context, int index) {
                    List<String> allurls = [], vidurls = [], imageurls = [];
                    if (postcrime.data["amountOfvideo"] != null &&
                        postcrime.data["amountOfimages"] != null) {
                      for (int i = 0;
                          i < postcrime.data["amountOfvideo"];
                          i++) {
                        allurls.add(postcrime.data["video$i"]);
                      }
                      for (int i = 0;
                          i < postcrime.data["amountOfimages"];
                          i++) {
                        allurls.add(postcrime.data["picture$i"]);
                      }
                      if (index < postcrime.data["amountOfvideo"]) {
                        return _videoCard(allurls[index], index);
                      } else {
                        return Image.network(allurls[index]);
                      }
                    } else if (postcrime.data["amountOfvideo"] == null &&
                        postcrime.data["amountOfimages"] != null) {
                      for (int i = 0;
                          i < postcrime.data["amountOfimages"];
                          i++) {
                        imageurls.add(postcrime.data["picture$i"]);
                      }
                      return Image.network(imageurls[index]);
                    } else if (postcrime.data["amountOfvideo"] != null &&
                        postcrime.data["amountOfimages"] == null) {
                      for (int i = 0;
                          i < postcrime.data["amountOfvideo"];
                          i++) {
                        vidurls.add(postcrime.data["video$i"]);
                      }
                      return _videoCard(vidurls[index], index);
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Divider(color: Colors.grey),
//              _BottomCard(context ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //truth button
                    FlatButton(
                      onPressed: () async {
                        if (user_model.user_id == postcrime.data["reporter"]) {
                          Scaffold.of(context).showSnackBar(notthesameperson);
                        } else {
                          await post_crime
                              .getVoteValue(user_model.user_id, vote,
                                  postcrime.documentID)
                              .then((value) {
                            print("value = " + value.toString());
                            if (value != null) {
                              // ever vote this crime
                              if (value == "trustworthy") {
                                //snackbar can not vote the same value and crime record
                                Scaffold.of(context)
                                    .showSnackBar(notthesamevalue);
                              } else {
                                //change vote value
                                post_crime.changeVotevalue(
                                    user_model.user_id,
                                    postcrime.documentID,
                                    "trustworthy",
                                    post_crime
                                        .getVoteDocument(user_model.user_id,
                                            postcrime.documentID, vote)
                                        .toString());
                                post_crime.vote(
                                    postcrime.documentID,
                                    postcrime.data["unreliability"] - 1,
                                    postcrime.data["trustworthy"] + 1);
                              }
                            } else {
                              //new voter to this crime record
                              post_crime.newVote(user_model.user_id,
                                  postcrime.documentID, "trustworthy");
                              post_crime.vote(
                                  postcrime.documentID,
                                  postcrime.data["unreliability"] - 0,
                                  postcrime.data["trustworthy"] + 1);
                            }
                          });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            postcrime.data["trustworthy"].toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Archivo-SemiBold',
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),

                    VerticalDivider(width: 2.0),
                    //Rumor button
                    FlatButton(
                      onPressed: () async {
                        if (user_model.user_id == postcrime.data["reporter"]) {
                          // voter = reporter
                          Scaffold.of(context).showSnackBar(notthesameperson);
                        } else {
                          //not their crime report
                          await post_crime
                              .getVoteValue(user_model.user_id, vote,
                                  postcrime.documentID)
                              .then((value) {
                            print("value = " + value.toString());
                            if (value != null) {
                              // ever vote this crime
                              if (value == "unreliability") {
                                //snackbar can not vote the same value and crime record
                                Scaffold.of(context)
                                    .showSnackBar(notthesamevalue);
                              } else {
                                //change vote value
                                post_crime.changeVotevalue(
                                    user_model.user_id,
                                    postcrime.documentID,
                                    "unreliability",
                                    post_crime
                                        .getVoteDocument(user_model.user_id,
                                            postcrime.documentID, vote)
                                        .toString());
                                post_crime.vote(
                                    postcrime.documentID,
                                    postcrime.data["unreliability"] + 1,
                                    postcrime.data["trustworthy"] - 1);
                              }
                            } else {
                              //new voter to this crime record
                              post_crime.newVote(user_model.user_id,
                                  postcrime.documentID, "unreliability");
                              post_crime.vote(
                                  postcrime.documentID,
                                  postcrime.data["unreliability"] + 1,
                                  postcrime.data["trustworthy"] - 0);
                            }
                          });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            postcrime.data["unreliability"].toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Archivo-SemiBold',
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(width: 2.0),
                    //comment button
                    new FlatButton(
                      onPressed: () {
                        post_crime.post_id = postcrime.documentID;
                        post_crime.crimedetail = postcrime.data["detail"];
                        post_crime.useremail =
                            post_crime.getUserEmailFromStream(
                                users, postcrime.data["reporter"]);
                        Navigator.push(
                            context, SlideRightRoute(page: CommentPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            color: Color(0xFFffa62b),
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            post_crime
                                .getAmountOfComment(
                                    comment, postcrime.documentID.toString())
                                .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Archivo-SemiBold',
                                color: Color(0xFFffa62b)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
//           bottomElement(),
            ],
          ),
        ),
      ),
    );
  }

  final notthesameperson = SnackBar(
    content: Text("You can not vote your crime report"),
    duration: Duration(seconds: 3),
  );
  final notthesamevalue = SnackBar(
    content: Text("You can not increase vote value"),
    duration: Duration(seconds: 3),
  );
}
