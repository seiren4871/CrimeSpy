//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:crimespy/view/demo/demo_values.dart';
//import 'package:crimespy/view/elements/themes.dart';
//import 'package:crimespy/view/elements/transition.dart';
//import 'package:crimespy/view/pages/crimeReport/post_comment.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:crimespy/model/post_model.dart' as post_crime;
//
//
////class PostCard extends StatelessWidget {
////
////  PostCard({Key key, DocumentSnapshot doc  }) : super(key: key);
////  DocumentSnapshot doc;
////Widget CommentStream() {
////  return StreamBuilder<QuerySnapshot>(
////    stream: Firestore.instance.collection("Comment")
////.where("crime_post_id", isEqualTo: post_crime.post_id)
////.snapshots(includeMetadataChanges:  true),
////builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnap ) {
////      querySnap.data.documents.map((e) => null).toList()
////},
////    );
////}
//
//bool _prepared;
//  @override
//  Widget PostCard(BuildContext context ,  DocumentSnapshot postcrime,
//      List<DocumentSnapshot> comment, List<DocumentSnapshot> users ) {
//
////    print("post_id = " + post_crime.post_id);
////    print( doc.data["detail"]);
//    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
//    return AspectRatio(
//      // height: MediaQuery.of(context).size.height / 3,
//      aspectRatio: 4 / 3,
//      child: Card(
//        color: Color(0xffdff7fd).withOpacity(.9),
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(12.0),
//        ),
//        elevation: 2,
//        child: Container(
//          margin: EdgeInsets.all(ScreenUtil().setWidth(2.0)),
//          child: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              // _Post(),
////              _PostDetails(context),
//          Row(
//          children: <Widget>[
////        _UserImage(context),
//            Expanded(
//            flex: 1,
//            child: Row(
//              children: <Widget>[
//                ClipRRect(
//                  borderRadius: new BorderRadius.circular(100.0),
//                  child: Image(
//                    image: AssetImage('assets/img/profile_anonymous.jpg'),
//                    width: MediaQuery.of(context).size.width * 0.08,
//                    fit: BoxFit.fill,
//                  ),
//                ),
//              ],
//            ),
//          ),
//
////        _UserName(context),
//          Expanded(
//            flex: 5,
//            child: Padding(
//              padding: const EdgeInsets.all(4.0),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
////                    "Anonymous",
//                    post_crime.getUserEmailFromStream(users, postcrime.data["reporter"] ),
//                    style: TextStyle(
//                      fontFamily: 'Archivo-SemiBold',
//                      fontSize: 18.0,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
////        _PostTimeStamp(context),
//          Expanded(
//            flex: 4,
//            child: Text(DemoValues.postTime, style: TextThemes.dateStyle),
//          ),
//          ],
//        ),
//              SizedBox(height: ScreenUtil().setHeight(5.0)),
////              _PostInformation(context, doc.data["detail"].toString()
//          Expanded(
//            flex: 4,
//            child: Padding(
//              padding: const EdgeInsets.only(left: 4.0),
//              child: SingleChildScrollView(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
////                  information,
////              post_crime.detail,
//                        postcrime.data["detail"],
//                        style: TextThemes.info
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
////              ),
//              SizedBox(height: ScreenUtil().setHeight(5.0)),
////              _PostImage(context ),
//              Divider(color: Colors.grey),
////              _BottomCard(context ),
//              Expanded(
//                flex: 3,
//                child: Row(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    //truth button
//                    FlatButton(
//                      onPressed: () {
//
//                        post_crime.vote(postcrime.documentID,
//                            postcrime.data["unreliability"] +0, postcrime.data["trustworthy"] + 1 );
//                      },
//                      child: Row(
//                        children: <Widget>[
//                          Icon(
//                            Icons.check_circle,
//                            color: Colors.green,
//                          ),
//                          SizedBox(width: 5.0),
//
//                          Text(
//                            postcrime.data["trustworthy"].toString(),
//                            style: TextStyle(
//                                fontSize: 14,
//                                fontFamily: 'Archivo-SemiBold',
//                                color: Colors.green),
//                          ),
//                          // SizedBox(width: 2.0),
//                          // AutoSizeText(
//                          //   'True',
//                          //   style: TextStyle(
//                          //       fontSize: 12,
//                          //       fontFamily: 'Archivo-Regular',
//                          //       color: Colors.green),
//                          // ),
//                        ],
//                      ),
//                    ),
//
//                    VerticalDivider(width: 2.0),
//                    //Rumor button
//                    FlatButton(
//                      onPressed: () {
//                        post_crime.vote(postcrime.documentID,
//                            postcrime.data["unreliability"] +1, postcrime.data["trustworthy"] + 0);
//                      },
//                      child: Row(
//                        children: <Widget>[
//                          Icon(
//                            Icons.cancel,
//                            color: Colors.red,
//                          ),
//                          SizedBox(width: 5.0),
//                          Text(
//                            postcrime.data["unreliability"].toString(),
//                            style: TextStyle(
//                                fontSize: 14,
//                                fontFamily: 'Archivo-SemiBold',
//                                color: Colors.red),
//                          ),
//                          // SizedBox(width: ScreenUtil().setWidth(3)),
//                          // AutoSizeText(
//                          //   'Lie',
//                          //   style: TextStyle(
//                          //       fontSize: 12,
//                          //       fontFamily: 'Archivo-Regular',
//                          //       color: Colors.red),
//                          // ),
//                        ],
//                      ),
//                    ),
//                    VerticalDivider(width: 2.0),
//                    //comment button
//                    new FlatButton(
//                      onPressed: () {
//                        post_crime.post_id = postcrime.documentID;
//                        post_crime.crimedetail = postcrime.data["detail"];
//                        post_crime.useremail = post_crime.getUserEmailFromStream(users, postcrime.data["reporter"] );
//                        Navigator.push(context, SlideRightRoute(page: CommentPage()));
//                        },
//                      child: Row(
//                        children: <Widget>[
//                          Icon(
//                            Icons.comment,
//                            color: Color(0xFFffa62b),
//                          ),
//                          SizedBox(width: 5.0),
//                          Text(
//                            post_crime.getAmountOfComment(comment, postcrime.documentID.toString() ).toString(),
//                            style: TextStyle(
//                                fontSize: 14,
//                                fontFamily: 'Archivo-SemiBold',
//                                color: Color(0xFFffa62b)),
//                          ),
//                          // SizedBox(width: 2.0),
//                          // AutoSizeText(
//                          //   'Comment',
//                          //   maxFontSize: 12.0,
//                          //   style: TextStyle(
//                          //       fontSize: 10,
//                          //       fontFamily: 'Archivo-Regular',
//                          //       color: Color(0xFFffa62b)),
//                          // ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
////               bottomElement(),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
////}
//
//// truth rumor comment button
////class _BottomCard extends StatelessWidget {
//
////  @override
//  Widget _BottomCard(BuildContext context) {
//    return Expanded(
//      flex: 3,
//      child: Row(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          //truth button
//          FlatButton(
//            onPressed: () {},
//            child: Row(
//              children: <Widget>[
//                Icon(
//                  Icons.check_circle,
//                  color: Colors.green,
//                ),
//                SizedBox(width: 5.0),
//
//                Text(
//                  '9',
//                  style: TextStyle(
//                      fontSize: 14,
//                      fontFamily: 'Archivo-SemiBold',
//                      color: Colors.green),
//                ),
//                // SizedBox(width: 2.0),
//                // AutoSizeText(
//                //   'True',
//                //   style: TextStyle(
//                //       fontSize: 12,
//                //       fontFamily: 'Archivo-Regular',
//                //       color: Colors.green),
//                // ),
//              ],
//            ),
//          ),
//
//          VerticalDivider(width: 2.0),
//          //Rumor button
//          FlatButton(
//            onPressed: () {},
//            child: Row(
//              children: <Widget>[
//                Icon(
//                  Icons.cancel,
//                  color: Colors.red,
//                ),
//                SizedBox(width: 5.0),
//                Text(
//                  '2',
//                  style: TextStyle(
//                      fontSize: 14,
//                      fontFamily: 'Archivo-SemiBold',
//                      color: Colors.red),
//                ),
//                // SizedBox(width: ScreenUtil().setWidth(3)),
//                // AutoSizeText(
//                //   'Lie',
//                //   style: TextStyle(
//                //       fontSize: 12,
//                //       fontFamily: 'Archivo-Regular',
//                //       color: Colors.red),
//                // ),
//              ],
//            ),
//          ),
//          VerticalDivider(width: 2.0),
//          //comment button
//          new FlatButton(
//            onPressed: () {
//              Navigator.push(context, SlideRightRoute(page: CommentPage()));
//            },
//            child: Row(
//              children: <Widget>[
//                Icon(
//                  Icons.comment,
//                  color: Color(0xFFffa62b),
//                ),
//                SizedBox(width: 5.0),
//                Text(
//                  '4',
//                  style: TextStyle(
//                      fontSize: 14,
//                      fontFamily: 'Archivo-SemiBold',
//                      color: Color(0xFFffa62b)),
//                ),
//                // SizedBox(width: 2.0),
//                // AutoSizeText(
//                //   'Comment',
//                //   maxFontSize: 12.0,
//                //   style: TextStyle(
//                //       fontSize: 10,
//                //       fontFamily: 'Archivo-Regular',
//                //       color: Color(0xFFffa62b)),
//                // ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
////}
//
////class _PostInformation extends StatelessWidget {
////  const _PostInformation({Key key}) : super(key: key);
////  _PostInformation({Key key, }) : super(key: key);
//
//
////  @override
//  Widget _PostInformation(BuildContext context, String detail) {
//    final TextStyle informationTheme = TextThemes.info;
//    final String information = DemoValues.postInformation;
//    print("detail = " + detail );
//    return Expanded(
//      flex: 4,
//      child: Padding(
//        padding: const EdgeInsets.only(left: 4.0),
//        child: SingleChildScrollView(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Text(
////                  information,
////              post_crime.detail,
//              detail,
//
//                  style: informationTheme
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
////}
//
////class _PostImage extends StatelessWidget {
////  const _PostImage({Key key}) : super(key: key);
//
////  @override
//  Widget _PostImage(BuildContext context) {
//    return Expanded(
//      flex: 6,
//      child: ListView(
//        scrollDirection: Axis.horizontal,
//        padding: EdgeInsets.all(2.0),
//        children: <Widget>[
//          Image.asset('assets/img/pickpocket.jpg'),
//          SizedBox(width: 5.0),
//          Image.asset('assets/img/pickpocket.jpg'),
//          SizedBox(width: 5.0),
//          Image.asset('assets/img/pickpocket.jpg'),
//        ],
//      ),
//    );
//  }
////}
////
//////class _UserImage extends StatelessWidget {
//////  const _UserImage({Key key}) : super(key: key);
////
//////  @override
//  Widget _UserImage(BuildContext context) {
//    return Expanded(
//        flex: 1,
//        child: Row(
//          children: <Widget>[
//            ClipRRect(
//              borderRadius: new BorderRadius.circular(100.0),
//              child: Image(
//                image: AssetImage('assets/img/profile_anonymous.jpg'),
//                width: MediaQuery.of(context).size.width * 0.08,
//                fit: BoxFit.fill,
//              ),
//            ),
//          ],
//        ));
//  }
//////}
////
//////class _PostDetails extends StatelessWidget {
//////  const _PostDetails({Key key}) : super(key: key);
////
//////  @override
//  Widget _PostDetails(BuildContext context) {
//    return Row(
//      children: <Widget>[
////        _UserImage(context),
//    Expanded(
//        flex: 1,
//        child: Row(
//          children: <Widget>[
//            ClipRRect(
//              borderRadius: new BorderRadius.circular(100.0),
//              child: Image(
//                image: AssetImage('assets/img/profile_anonymous.jpg'),
//                width: MediaQuery.of(context).size.width * 0.08,
//                fit: BoxFit.fill,
//              ),
//            ),
//          ],
//        ),
//    ),
//
////        _UserName(context),
//    Expanded(
//    flex: 5,
//    child: Padding(
//    padding: const EdgeInsets.all(4.0),
//    child: Column(
//    mainAxisAlignment: MainAxisAlignment.start,
//    crossAxisAlignment: CrossAxisAlignment.start,
//    children: <Widget>[
//    Text(
//    "Anonymous",
//    style: TextStyle(
//    fontFamily: 'Archivo-SemiBold',
//    fontSize: 18.0,
//    ),
//    ),
//    ],
//    ),
//    ),
//    ),
////        _PostTimeStamp(context),
//    Expanded(
//    flex: 4,
//    child: Text(DemoValues.postTime, style: TextThemes.dateStyle),
//    ),
//      ],
//    );
//  }
//////}
////
//////class _UserName extends StatelessWidget {
//////  const _UserName({Key key}) : super(key: key);
////
//////  @override
//  Widget _UserName(BuildContext context) {
//    return Expanded(
//      flex: 5,
//      child: Padding(
//        padding: const EdgeInsets.all(4.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              "Anonymous",
//              style: TextStyle(
//                fontFamily: 'Archivo-SemiBold',
//                fontSize: 18.0,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//////}
////
//////class _PostTimeStamp extends StatelessWidget {
//////  const _PostTimeStamp({Key key}) : super(key: key);
////
//////  @override
//  Widget  _PostTimeStamp(BuildContext context) {
//    final TextStyle timeTheme = TextThemes.dateStyle;
//    return Expanded(
//      flex: 4,
//      child: Text(DemoValues.postTime, style: timeTheme),
//    );
//  }
//////}
//
//Future<void> prepareCommentPage() async {
//  _prepared = false;
//  await post_crime.getUserEmailFromCrimeId( post_crime.post_id );
//  await post_crime.getCrimeDetail(post_crime.post_id);
//
//  while(post_crime.crimedetail == ""
//      && post_crime.useremail == "" ) {
//    print("loading");
//  }
//
//  if(post_crime.crimedetail != ""
//      && post_crime.useremail != "" ) {
//    _prepared = true;
//  }
//  _prepared;
//}
