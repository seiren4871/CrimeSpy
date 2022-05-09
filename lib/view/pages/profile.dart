import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_bar/rating_bar.dart';
import '../../model/user_model.dart' as user_model;
import '../elements/drawer.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String newNumber = "";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffdff7fd),
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF012148),
        title: Text("Profile"),
      ),
      body: Stack(
        children: <Widget>[
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(100.0),
                child: Image(
                  image: AssetImage('assets/img/profile_anonymous.jpg'),
                  width: MediaQuery.of(context).size.width * 0.45,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    (user_model.firstname != "")
                        ? user_model.firstname
                        : 'John',
                    textDirection: TextDirection.ltr,
                    style: new TextStyle(
                        color: cTextNavy,
                        fontFamily: 'Archivo-Regular',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    (user_model.lastname != "") ? user_model.lastname : 'Doe',
                    textDirection: TextDirection.ltr,
                    style: new TextStyle(
                        color: cTextNavy,
                        fontFamily: 'Archivo-Regular',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                width: double.infinity,
                decoration: new BoxDecoration(
                  color: Color(0xff012148).withOpacity(.9),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: cTextNavy.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.0),
                        AutoSizeText(
                          (user_model.email != "")
                              ? user_model.email
                              : 'john.doe123@gmail.com',
                          textDirection: TextDirection.ltr,
                          style: new TextStyle(
                              color: Colors.white,
                              fontFamily: 'Archivo-Regular',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.0),
                              AutoSizeText(
                                (user_model.phone != "")
                                    ? user_model.phone
                                    : '0812345678',
                                textDirection: TextDirection.ltr,
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Archivo-Regular',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: FlatButton(
                              onPressed: () {
                                _changeNumberAlert();
                              },
                              child: AutoSizeText(
                                'Change',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.end,
                                style: new TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFFffa62b),
                                  fontFamily: 'Archivo-Regular',
                                  fontSize: 14.0,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),

          bottomElement(),
        ],
      ),
    );
  }

  Widget bottomElement() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: new ButtonBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          new FlatButton(
            onPressed: () {
              _showAlert();
            },
            child: const Text('Feedback',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Archivo-Regular',
                  decoration: TextDecoration.underline,
                )),
            color: Colors.transparent,
            textColor: cTextNavy,
          ),
        ],
      ),
    );
  }

  double _rating = 3.0;
  String comment = "";
  void _showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 280.0,
        height: 230.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: new Column(
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: AutoSizeText(
                      'How Would You Rate Our App?',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Archivo-Regular',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RatingBar(
                        onRatingChanged: (rating) =>
                            setState(() => _rating = rating),
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        halfFilledIcon: Icons.star_half,
                        isHalfAllowed: true,
                        filledColor: Colors.amberAccent,
                        emptyColor: cTextNavy,
                        size: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // dialog centre
            Expanded(
              child: new Container(
                  child: new TextField(
                maxLines: 5,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: new EdgeInsets.only(
                      left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                  hintText: 'Add review',
                  hintStyle: new TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14.0,
                    fontFamily: 'Archivo-Regular',
                  ),
                ),
                onChanged: (value) => comment = value,
              )),
              flex: 3,
            ),

            // dialog bottom

            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 65.0,
                          padding: new EdgeInsets.all(5.0),
                          decoration: new BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: cTextNavy,
                              fontSize: 16.0,
                              fontFamily: 'Archivo-Regular',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          user_model.sendFeedback(
                              _rating, comment, user_model.user_id);
                          Navigator.of(context).pop();
                        },
                        child: new Container(
                          width: 70.0,
                          padding: new EdgeInsets.all(7.0),
                          decoration: new BoxDecoration(
                            color: const Color(0xFF012148),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: new Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Archivo-Regular',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _changeNumberAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 280.0,
        height: 150.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: new Column(
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: AutoSizeText(
                      'Change your number',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Archivo-Regular',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // dialog centre
            Expanded(
              child: new Container(
                  child: new TextField(
                    onChanged: (value) {
                      if(value.trim().length < 10 || value.trim().length > 10 ) {
                        return "phone number should have 10 digits";
                      }else{
                        return newNumber = value.trim();
                      }
                      },
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    decoration: new InputDecoration(
                      contentPadding: new EdgeInsets.only(
                          left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: BorderSide(
                          color: cTextNavy,
                          width: 1.0,
                        ),
                      ),
                      border: InputBorder.none,
                      filled: false,
                      hintText: '0812345678',
                      hintStyle: new TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14.0,
                        fontFamily: 'Archivo-Regular',
                      ),
                    ),
                  )),
              flex: 3,
            ),

            // dialog bottom
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBar(
                    buttonPadding: EdgeInsets.all(5.0),
                    layoutBehavior: ButtonBarLayoutBehavior.constrained,
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 65.0,
                          padding: new EdgeInsets.all(5.0),
                          decoration: new BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: cTextNavy,
                              fontSize: 16.0,
                              fontFamily: 'Archivo-Regular',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          print(newNumber);
                          user_model.updatePhoneNumber(user_model.user_id, newNumber );
                          Navigator.of(context).pop();
                        },
                        child: new Container(
                          width: 70.0,
                          padding: new EdgeInsets.all(5.0),
                          decoration: new BoxDecoration(
                            color: const Color(0xFF012148),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AutoSizeText(
                            'Change',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Archivo-Regular',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }
}
