import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/transition.dart';
import 'package:crimespy/view/pages/sos_calling/sos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'Hospital_no.dart';
import 'Police_no.dart';
import '../elements/drawer.dart';
import '../../model/user_model.dart' as user_model;
import 'authentication/login.dart';
import 'crimeRecord/crime_stat.dart';
import 'crimeReport/choose_crime.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));

    return WillPopScope(
      onWillPop: () {
        showAlertDialog();
      },
      child: Scaffold(
        backgroundColor: Color(0xffdff7fd),
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xFF012148),
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          print(user_model.name);
                          Navigator.push(
                              context, SlideRightRoute(page: PolicenoPage()));
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/img/Police_icon.png',
                              height: MediaQuery.of(context).size.height *
                                  0.15, //120
                              width: MediaQuery.of(context).size.height *
                                  0.15, //120
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            AutoSizeText('Police Number',
                                style: new TextStyle(
                                    color: Color(0xff012148),
                                    fontFamily: 'Archivo-Regular',
                                    fontSize: 18.0, //20
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context, SlideRightRoute(page: HospitalnoPage()));
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/img/Ambulance_icon.png',
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            AutoSizeText('Hospital Number',
                                style: new TextStyle(
                                    color: Color(0xff012148),
                                    fontFamily: 'Archivo-Regular',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: ChoosecrimePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/img/CrimeReport_icon.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.15,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        AutoSizeText('Crime Report',
                            style: new TextStyle(
                                color: Color(0xff012148),
                                fontFamily: 'Archivo-Regular',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: CrimestatPage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/img/CrimeHistoryj_icon.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.15,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        AutoSizeText('Crime Record',
                            style: new TextStyle(
                                color: Color(0xff012148),
                                fontFamily: 'Archivo-Regular',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              FlatButton(
                onPressed: () {
//                await user_model.getSosFeat(user_model.user_id );
//                print("user_model.sosvalue.toString()" + user_model.sosvalue.toString()  );
//                await user_model.updateSOSFeature(user_model.user_id, user_model.sosvalue );
                  Navigator.push(context, SlideRightRoute(page: SosPage()));
                },
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/img/SOS_icon.png',
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AutoSizeText('SOS Calling',
                        style: new TextStyle(
                            color: Colors.red,
                            fontFamily: 'Archivo-Regular',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500)),
                  ],
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
    ProgressDialog pr;

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        padding: EdgeInsets.all(5.0),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Archivo-Regular'),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Archivo-Regular'));
    Widget noButton = FlatButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    Widget exitButton = FlatButton(
      child: Text("Log out"),
      onPressed: () {
        pr.show();
        Future.delayed(Duration(seconds: 1)).then((value) {
          pr.hide().whenComplete(() {
            try {
              user_model.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
            } catch (err) {
              print(err);
            }
          });
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log out"),
      content: Text("You will be returned to the login screen."),
      actions: [
        noButton,
        exitButton,
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
