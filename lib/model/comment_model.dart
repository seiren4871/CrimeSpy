import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  int postId;
  int id;
  String name;
  String email;
  String detail;
  // String body;

  Comment({this.postId, this.id, this.name, this.email, this.detail});

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    // body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    // data['body'] = this.body;
    return data;
  }

}

Future<void> addComment(String detail, String user_id, String postid, String email) async {
  try{
    await Firestore.instance.collection("Comment").add({
      "detail": detail,
      "userid": user_id,
      "crime_post_id": postid,
      "email": email,
    }).then((value) => print("add comment successfully"));
  }catch(err){
    print("Error on add comment = " + err );
  }
}

