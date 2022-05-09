import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'authentication/login.dart';
import 'authentication/signup.dart';
import '../elements/transition.dart';
import 'package:crimespy/model/user_model.dart' as user_model;
import 'home.dart';

enum Root {
  Not_Determined,
  Logged_In,
  Not_LoggedIn
}

class FirstPage extends StatefulWidget {
  FirstPage({this.storage});
  final FirebaseStorage storage;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  Root root = Root.Not_Determined;

  void initState() {
    super.initState();
    user_model.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          user_model.user_id = user?.uid;
        }
        root =
        user?.uid == null ? Root.Not_LoggedIn : Root.Logged_In;
      });
    });
  }

  void signOutCallback() {
    if (user_model.user_id == "") {
      setState(() {
        root = Root.Not_LoggedIn;
        user_model.checkSignIn = false;
        user_model.checkSignUp = false;
      });
    }
  }

  void signInCallback() {
    setState(() {
      root = Root.Logged_In;
    });
  }

  Widget waitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));
    try{
      switch (root) {
        case Root.Not_Determined: return waitingScreen();
          break;
        case Root.Not_LoggedIn:
          //firstpage
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
            colors: [Color(0xff3ebce1), Color(0xff012148)],
                  begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(top: 100.0),
                        child: Image.asset(
                          "assets/img/Logo.png",
                          // scale: 2.0,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.height * 0.35,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: double.infinity,

                      child: Column(
                        children: <Widget>[
                         AutoSizeText(
                             "Stay Safe and",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'Archivo-Regular',
                                fontSize: 30.0,
                                fontWeight: FontWeight.w500),
                          ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                AutoSizeText(
                            "Keep Campus Clean",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'Archivo-Regular',
                                fontSize: 30.0,
                                fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomElement(),
                ],
              ),
            ),
          );
          break;
        case Root.Logged_In:
          if (user_model.user_id.length > 0
              && user_model.user_id.length != null) {
            user_model.getUserInformation(user_model.user_id);
            return new HomePage(
            );
          } else
            return FirstPage(
            );
          break;
        default:
          return FirstPage();
      }
    }catch(err){
      print(err);
    }

  }
    Widget bottomElement() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.push(context, SlideRightRoute(page: SignupPage( signinCallback: signInCallback,                 )));
              },
              child: const Text('Sign up',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Archivo-Regular',
                    decoration: TextDecoration.underline,
                  )),
              color: Colors.transparent,
              textColor: Colors.white,
            ),
            Text(
              "/",
              style: new TextStyle(
                  color: Colors.white,
                  fontFamily: 'Archivo-Regular',
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.push(context, SlideRightRoute(page: LoginPage(signIncallback: signInCallback,
                )));
              },
              child: const Text('Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Archivo-Regular',
                    decoration: TextDecoration.underline,
                  )),
              color: Colors.transparent,
              textColor: Colors.white,
            ),
          ],
        ),
      );
    }

}
