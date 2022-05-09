import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/themes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crimespy/model/user_model.dart' as user_model;
import 'package:crimespy/model/post_model.dart' as post_model;
import 'package:crimespy/model/comment_model.dart' as comment_model;
import 'package:rxdart/rxdart.dart';

class CommentPage extends StatefulWidget {
  CommentPage({this.storage});
  final FirebaseStorage storage;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Stream<List<QuerySnapshot>> combinationOfCrimeRecordCommentAndUser =
      CombineLatestStream.list([
    Firestore.instance
        .collection("Comment")
        .where("crime_post_id", isEqualTo: post_model.post_id)
        .snapshots(includeMetadataChanges: true),
  ]);

  Widget _ListComment() {
    return StreamBuilder<List<QuerySnapshot>>(
      stream: combinationOfCrimeRecordCommentAndUser,
      builder:
          (BuildContext context, AsyncSnapshot<List<QuerySnapshot>> query) {
        if (query.data == null) {
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
        if (query.hasError) {
          print('Something went wrong');
        }
        if (query.connectionState == ConnectionState.waiting) {
          print("Loading");
        }
        List<DocumentSnapshot> comments = query.data[0].documents;
        return _buildCommentList(comments);
      },
    );
  }

  Widget _buildCommentList(List<DocumentSnapshot> comments) {
    return ListView(
      children: comments.map((comment) {
        return _buildCommentItem(comment);
      }).toList(),
    );
  }

  Widget _buildCommentItem(DocumentSnapshot comment) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: ListTile(
        leading: CircleAvatar(
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(100.0),
            child: Image(
              image: AssetImage('assets/img/profile_anonymous.jpg'),
              width: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(comment.data["email"], style: TextThemes.username),
        subtitle: Text(
          comment.data["detail"],
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Archivo-Regular',
            color: cTextNavy,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffFFFFF3),
      appBar: AppBar(
        backgroundColor: Color(0xFF012148),
        title: Text("Comments"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7.0),
            margin: EdgeInsets.all(10.0),
            child:
                //coloum
                Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Row,
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(100.0),
                      child: Image(
                        image: AssetImage('assets/img/profile_anonymous.jpg'),
                        width: 30.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      post_model.useremail,
                      style: TextThemes.username,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  post_model.crimedetail,
                  maxLines: null,
                  style: TextThemes.info,
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
          Divider(
            height: 2.0,
          ),
          Expanded(child: _ListComment()),
          Container(
              padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 10.0),
              color: Color(0xffdff7fd).withOpacity(.6),
              child: TextField(
                controller: _controller,
                style: TextStyle(
                  fontFamily: 'Archivo-Regular',
                  fontSize: 14.0,
                  color: cTextNavy,
                ),
                onSubmitted: (String str) {
                  try {
                    comment_model.addComment(str, user_model.user_id,
                        post_model.post_id, user_model.email);
                  } catch (err) {
                    print("err on textFiled post comment = " + err.toString());
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(7.0),
                  hintText: 'Comment...',
                  icon: Icon(Icons.add_comment),
                ),
                maxLength: 100,
              )),
        ],
      ),
    );
  }

}
