import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../firstpage.dart';
import '../home.dart';
import '../../../model/user_model.dart' as user_model;

class LoginPage extends StatefulWidget {
  LoginPage({this.signIncallback});
  final VoidCallback signIncallback;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _emkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwkey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String em, pw = "";
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context, SlideRightRoute(page: FirstPage()));
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        child: Container(
                          // margin:  EdgeInsets.only(top: MediaQuery.of(context).size.width*0.1),
                          child: Image.asset(
                            "assets/img/Logo.png",
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        width: ScreenUtil.screenWidthDp,
                        decoration: new BoxDecoration(
                          color: Color(0xffdff7fd).withOpacity(.9),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(15.0)),
                          boxShadow: [
                            BoxShadow(
                              color: cTextNavy.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              "Login",
                              textDirection: TextDirection.ltr,
                              style: new TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Archivo',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Divider(
                              color: cTextNavy,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            AutoSizeText(
                              "Email",
                              textDirection: TextDirection.ltr,
                              style: new TextStyle(
                                  color: cTextNavy,
                                  fontFamily: 'Archivo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Form(
                              key: _emkey,
                              autovalidate: _autoValidate,
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                validator: _validateEmail,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfffffff3),
                                  focusColor: cTextNavy.withOpacity(0.1),
                                  hoverColor: cTextNavy.withOpacity(0.1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "xxxxxx@mail.com",
                                ),
                                onSaved: (value) => {em = value.trim()},
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20.0),
                            ),
                            AutoSizeText(
                              "Password",
                              textDirection: TextDirection.ltr,
                              style: new TextStyle(
                                  color: cTextNavy,
                                  fontFamily: 'Archivo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5.0),
                            ),
                            Form(
                              key: _pwkey,
                              autovalidate: _autoValidate,
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String pw) {
                                  if (pw.trim().length < 0) {
                                    return "insert your password";
                                  } else if (pw.trim().length > 0 &&
                                      pw.trim().length < 6) {
                                    return "your password should have at least 6 digit.";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfffffff3),
                                  focusColor: cTextNavy.withOpacity(0.1),
                                  hoverColor: cTextNavy.withOpacity(0.1),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "**********",
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: _toggle),
                                ),
                                onSaved: (value) => {pw = value.trim()},
                                obscureText: _obscureText,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20.0),
                            ),
                            bottomButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: new ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonHeight: 40,
        buttonMinWidth: 120,
        children: <Widget>[
          new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              try {
                _validateSignInForm();
                signIn().then((val) {
                  (user_model.checkSignIn)
                      ? Navigator.push(
                          context, SlideRightRoute(page: HomePage()))
                      : Future.delayed(
                          Duration(seconds: 1),
                          () => Navigator.push(
                              context, SlideRightRoute(page: HomePage())));
                });
              } catch (err) {
                print(err);
              }
            },
            child: Text('Log in',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Archivo-Regular',
                  fontWeight: FontWeight.w500,
                )),
            color: cTextNavy,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }

  String _validateEmail(String email) {
    String pattern =
        r'^[0-9A-Za-z]+([\d_-]*[0-9A-Za-z]+)*@[a-z]{2,}(\.)[a-z]{2,}(\.[a-z]{2})?$';
    RegExp reg = new RegExp(pattern);
    if (!reg.hasMatch(email.trim())) {
      return "insert your email";
    } else {
      return null;
    }
  }

  Future<void> signIn() async {
    try {
      await user_model.handleSignIn(em, pw).then((val) {
        if (user_model.checkSignIn == true) {
          widget.signIncallback();
        }
      });
    } catch (err) {
      print(err);
    }
  }

  void _validateSignInForm() {
    if (_emkey.currentState.validate() && _pwkey.currentState.validate()) {
      _emkey.currentState.save();
      _pwkey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
