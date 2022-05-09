import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/transition.dart';
import 'package:crimespy/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SosPage extends StatefulWidget {
  @override
  _SosPageState createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));

    return new WillPopScope(
      onWillPop: () async {
        showAlertDialog();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xffdff7fd),
        appBar: AppBar(
          backgroundColor: Color(0xFF012148),
          title: Text("Rescue Calling"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.white,
                        splashColor: cTextNavy,
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            side: BorderSide(color: cTextNavy)),
                        onPressed: () => launch("tel://191"),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/img/police-car.png',
                                height: MediaQuery.of(context).size.height *
                                    0.25, //120
                                width: MediaQuery.of(context).size.width *
                                    0.25, //120
                                fit: BoxFit.contain,
                              ),
                              AutoSizeText('Call Police',
                                  maxLines: 1,
                                  maxFontSize: 20.0,
                                  style: new TextStyle(
                                      color: Color(0xff012148),
                                      fontFamily: 'Archivo-SemiBold',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FlatButton(
                        color: Colors.white,
                        splashColor: Colors.redAccent,
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            side: BorderSide(color: Colors.redAccent)),
                        onPressed: () => launch("tel://1669"),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/img/ambulance-car.png',
                                height: MediaQuery.of(context).size.height *
                                    0.25, //120
                                width: MediaQuery.of(context).size.width * 0.25,
                                fit: BoxFit.contain,
                              ),
                              AutoSizeText('Call Ambulance',
                                  maxLines: 1,
                                  style: new TextStyle(
                                      color: Colors.redAccent,
                                      fontFamily: 'Archivo-SemiBold',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xff023388)),
                padding: EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText('Your help are on the way!',
                        maxFontSize: 28.0,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'Archivo-Regular',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(
                color: Colors.white,
                splashColor: Colors.green,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  side: BorderSide(color: Colors.green),
                ),
                onPressed: () {
                  showAlertDialog();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.29,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/img/safe.png',
                        height: MediaQuery.of(context).size.height * 0.25, //120
                        width: MediaQuery.of(context).size.width * 0.25, //120
                        fit: BoxFit.contain,
                      ),
                      AutoSizeText('I am Safe.',
                          maxLines: 1,
                          maxFontSize: 20.0,
                          style: new TextStyle(
                              color: Colors.green,
                              fontFamily: 'Archivo-SemiBold',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500)),
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

  Widget showAlertDialog() {
    // set up the buttons
    Widget nosafeButton = FlatButton(
        child: Text("Not yet"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    Widget safeButton = FlatButton(
      child: Text("Safe"),
      onPressed: () {
        Navigator.push(context, SlideRightRoute(page: HomePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you safe now?"),
      content: Text("You are going to exit from this page."),
      actions: [
        nosafeButton,
        safeButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
