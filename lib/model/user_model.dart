import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class UserModel {

  String name, firstname, lastname, email, phone, user_id = "";
  final databaseReference = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  bool checkSignIn, checkSignUp, getInfo, created = false;
  String error ="";
//sign up

  Future<bool> createUserinfo(String userid, fname, lname, _email, password, phone) async {
    try{
      await databaseReference
          .collection("User").document(userid)
          .setData({
        'FirstName': fname,
        'LastName': lname,
        'email': _email,
        'password': password,
        'phone': phone,
        'role': 'user'
      }).then((value) {
        created = true;
        print("created = " + created.toString());
        return created;
      });
    }catch(e ) {
      print("Error" + e);
    }
    return null;
  }

  Future<bool> signupwithemailandpassword(String email, pw, fname, lname, phone) async {
    error = "";
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pw)
          .then((data) {
        print("userid = " + data.user.uid);
        user_id = data.user.uid;
        checkSignUp = true;
        print("check sign up = " + checkSignUp.toString());
        return checkSignUp;
      });
      await createUserinfo(user_id, fname, lname, email, pw, phone);
//      await handleSignIn(email, pw);
      print("creating user information");
    }catch(err){
      switch (err.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE" :
          print(err.code);
          print("this email already in use");
          checkSignUp = false;
          break;
        case "ERROR_INVALID_EMAIL" :
          print("Thrown if the email address is not valid.");
          checkSignUp = false;
          break;
        case "ERROR_OPERATION_NOT_ALLOWED" :
          print("email/password accounts are not enabled.");
          checkSignUp = false;
          break;
        case "ERROR_WEAK_PASSWORD" :
          print("password is not strong enough.");
          checkSignUp = false;
          break;
        default :
          print("undefined ERROR");
          checkSignUp = false;
      }
    }
      return null;
    }

//sign in

  Future<bool> handleSignIn(_email, password) async {
    error = "";
    checkSignIn = null;
    try{
      await _auth.signInWithEmailAndPassword(email: _email, password: password)
          .then(
              (element) {
            user_id = element.user.uid;
//            checkSignIn = true;
//            print("checkSignIn = " + checkSignIn.toString() );
            return checkSignIn = true;
            });
    }catch(err){
      switch (err.code) {
        case "ERROR_USER_NOT_FOUND" :
          error = "ERROR_USER_NOT_FOUND : this email is not in our system.";
//          print("this email is not in our system.");
          return checkSignIn = false;
          break;
        case "ERROR_WRONG_PASSWORD" :
          error = "ERROR_WRONG_PASSWORD : Is your password correct ?";
           return checkSignIn = false;
          break;
        case "ERROR_USER_DISABLED" :
          error = "ERROR_USER_DISABLED : user corresponding to the given email has been disabled";
          return checkSignIn = false;
          break;
        case "ERROR_INVALID_EMAIL" :
          error = "ERROR_INVALID_EMAIL : check your email Is it correct ?";
          return checkSignIn = false;
          break;
        default : checkSignIn = false;
      }
    }
    return checkSignIn;
  }

//sign out
  void signOut() async {

    try{
      name = ""; firstname = ""; lastname = ""; email = ""; phone =""; error = "";user_id = "";
      checkSignIn = false; checkSignUp = false; getInfo = false; created = false;
      await FirebaseAuth.instance.signOut();
    }catch(err){
      print(err);
    }
  }
 Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;

 }
//retrieve data by user id
  Future<bool> getUserInformation( userid ) async {
    final user =await getCurrentUser();

    if (user != null) {

    final data = Firestore.instance.collection("User")
          .document(user.uid).snapshots( includeMetadataChanges: true );

      await data.forEach((element) {
          print(element.data);
          firstname = element.data["FirstName"];
        lastname = element.data["LastName"];
        email = element.data["email"];
        phone = element.data["phone"];
        name = "$firstname $lastname";
        print("$name  $email ");
          getInfo = true;
          print("getInfo = " + getInfo.toString());
          return getInfo;
        });


    } else {
      print("you have not sign in");
    }
    return null;
  }

  Future<void> sendFeedback(double rating , String comment, String userid ) async {
    try{
      await databaseReference.collection("Feedback").add({
        "rate_level": rating,
        "detail": comment,
        "userid": userid
      });
      print("submit feedback sucessful");
    }catch(err){
      print(err);
    }
  }
Future<void> updatePhoneNumber( userid, newPhoneNumber ) async {
  try {
    await databaseReference.collection("User")
        .document(userid).updateData({ "phone": newPhoneNumber });
//        .then(
//            (value) {
//          databaseReference.collection("User")
//              .document(userid).snapshots(includeMetadataChanges: true)
//              .forEach((element) {
//            phone = element.data["phone"];
//            print("newPhoneNumber has been added");
//
//          });
//        }
//    );
  }catch(err) {
    print("ERROR on editing phone number : " +  err);
  }
}
int sosvalue;
Future<void > getSosFeat(String userid ) async {
    final user = Firestore.instance.collection("User")
        .document(userid).snapshots();

    await user.forEach((element) {
      sosvalue = element.data["SOSfeature"];
      return sosvalue;
      }).then((value) {
        print("sosvalue = " + sosvalue.toString()) ;
        Firestore.instance.collection("User").document(userid).updateData({
        "SOSfeature": sosvalue++,
      });
      });
}
//Future<void> updateSOSFeature(String userid, int oldsos) async {
//if (element.data["SOSfeature"] != null) {
      //   print("sosvalue = " + sosvalue.toString() );
      //   sosvalue = element.data["SOSfeature"];
      //   print("after assigned, sosvalue = " + sosvalue.toString() );
      // }
//
//}

Future<void> updateCheckCrimeFetaure(String userid, int checkcrimefeature ) async {
  await Firestore.instance.collection("User").document(userid).updateData({
    "checkCrimeFeature": checkcrimefeature,
  }).then((value) {print("updated check crime value");});
}
Future<void> updateReportFeature(String userid, int reportFeature ) async {
  await Firestore.instance.collection("User").document(userid).updateData({
    "reportFeature": reportFeature,
  }).then((value) {print("updated report feture value");});
}