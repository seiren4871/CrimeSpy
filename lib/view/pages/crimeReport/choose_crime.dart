import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/drawer.dart';
import 'package:crimespy/view/elements/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:crimespy/model/post_model.dart' as post_crime;
import 'crime_post.dart';

class ChoosecrimePage extends StatefulWidget {

  @override
  _ChoosecrimePageState createState() => _ChoosecrimePageState();
}

class _ChoosecrimePageState extends State<ChoosecrimePage> {

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffdff7fd),
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF012148),
        title: Text("Category"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 60.0,
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
            padding: EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText('Choose Crime Type',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'Archivo-Regular',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      button(text: 'Burglary'),
                      button(text: 'Fraud'),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      button(text: 'Robbery'),
                      button(text: 'Murder'),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      button(text: 'Sexual Assault'),
                      button(text: 'Stalking'),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      button(text: 'Other'),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget button({String text}) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          setState(() {
            post_crime.crimeType = text;
            print("crimtype = " + post_crime.crimeType );
          });
          Navigator.push(context, SlideRightRoute(page: CrimepostPage()));
        },
        splashColor: cTextNavy,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cTextNavy, Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            padding: EdgeInsets.all(5.0),
            constraints: BoxConstraints(maxWidth: 130.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: AutoSizeText(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'Archivo-Regular'),
            ),
          ),
        ),
      ),
    );
  }
}
