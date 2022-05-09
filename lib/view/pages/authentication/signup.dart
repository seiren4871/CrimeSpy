import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/transition.dart';
import 'package:crimespy/view/pages/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../home.dart';
import '../../../model/user_model.dart' as user_model;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  SignupPage({ this.signinCallback} );
  final VoidCallback signinCallback;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _firstNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _lastNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneNumberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  String fname, lname, phone, email, password = "";
  bool _autoValidate = false;
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      child: Container(
                        child: Image.asset(
                          "assets/img/Logo.png",
                          height: ScreenUtil().setHeight(567.0),
                          width: ScreenUtil().setHeight(559.0),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        color: Color(0xffdff7fd).withOpacity(.9),
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: cTextNavy.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Sign up",
                            textDirection: TextDirection.ltr,
                            style: new TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Archivo',
                                fontSize: 24.0,
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
                          Text(
                            "Firstname",
                            textDirection: TextDirection.ltr,
                            style: new TextStyle(
                                color: cTextNavy,
                                fontFamily: 'Archivo',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),

                          Form(
                            key: _firstNameKey,
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.length < 1) {
                                  return "please insert your first name";
                                } else if (value.length > 10) {
                                  return "The first name is too long";
                                } else {
                                  return null;
                                }
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
                                hintText: "John",
                              ),
                              onSaved: ( String value) {
                                fname = value.trim();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Lastname",
                            textDirection: TextDirection.ltr,
                            style: new TextStyle(
                                color: cTextNavy,
                                fontFamily: 'Archivo',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Form(
                            key: _lastNameKey,
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.length < 1) {
                                  return "please insert your first name";
                                } else if (value.length > 10) {
                                  return "The last name is too long";
                                } else {
                                  return null;
                                }
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
                                hintText: "Doe",
                              ),
                              onSaved: ( String value) {
                                lname = value.trim();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Phone Number",
                            textDirection: TextDirection.ltr,
                            style: new TextStyle(
                                color: cTextNavy,
                                fontFamily: 'Archivo',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Form(
                            key: _phoneNumberKey,
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.phone,
                              validator: (String value) {
                                if (value.trim().length < 0) {
                                  return "pleas fill your phone number.";
                                } else if (value.trim().length > 10) {
                                  return "the phone number is invalid.";
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
                                contentPadding: EdgeInsets.only(
                                  top: 10.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              hintText: "0812345678",
                              ),
                              onSaved: ( String value) {
                                phone = value.trim();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Email",
                            textDirection: TextDirection.ltr,
                            style: new TextStyle(
                                color: cTextNavy,
                                fontFamily: 'Archivo',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Form(
                            key: _emailKey,
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
                              onSaved: ( String value) {
                                email = value.trim();
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Password",
                            textDirection: TextDirection.ltr,
                            style: new TextStyle(
                                color: cTextNavy,
                                fontFamily: 'Archivo',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Form(
                            key: _passwordKey,
                            autovalidate: _autoValidate,
                            child: TextFormField(
                            textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String pw) {
                                if (pw.trim().length < 0) {
                                  return "insert your password";
                                }else if(pw.trim().length > 0 && pw.trim().length < 6 ) {
                                  return "your password should have at least 6 digit.";
                                }else return null;
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
                                  onPressed: _toggle)
                            ),
                            onSaved: ( String value) {
                                password = value.trim();
                              },
                            obscureText: _obscureText,
                          ),
                          ),
                          SizedBox(
                            height: 20.0,
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
    );
  }

  Widget bottomButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: new ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonHeight: 40.0,
        buttonMinWidth: 120.0,
        children: <Widget>[
          new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: ()  {
               _validateForm();
                   signUp().then((value)  {
                 if(user_model.checkSignIn && user_model.checkSignUp ) {
                   Navigator.push(context, SlideRightRoute(page:
                   HomePage()));
                 }else if(user_model.checkSignUp && user_model.checkSignIn == false ){
                       Navigator.push(context, SlideRightRoute(page:
                       LoginPage() ));
                 }else{
                   print("sth wrong");
                 }
               }
               );
            },
            child: const Text('Sign up',
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

  String _validateEmail(String email ) {
    String pattern = r'^[0-9A-Za-z]+([\d_.-]*[0-9A-Za-z]+)*@[a-z]{2,}(\.)[a-z]{2,}(\.[a-z]{2})?$';
    RegExp reg = new RegExp(pattern);
    if (!reg.hasMatch(email.trim())) {
      return "insert your email";
    } else {
      return null;
    }
  }
    Future<void> signUp() async {
      try{
        await user_model.signupwithemailandpassword(email, password , fname, lname, phone);
        await user_model.handleSignIn(email, password)
            .then( (value)  {
                    if( user_model.checkSignIn  ) {
                      widget.signinCallback();
                    }
              });
      }catch(err){
        print(err);
      }
    }
   void _validateForm() {
    if (_emailKey.currentState.validate() && _firstNameKey.currentState.validate()
        && _lastNameKey.currentState.validate() && _phoneNumberKey.currentState.validate()
        && _passwordKey.currentState.validate()) {

      _emailKey.currentState.save(); _firstNameKey.currentState.save();
      _lastNameKey.currentState.save(); _phoneNumberKey.currentState.save();
      _passwordKey.currentState.save();

    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
