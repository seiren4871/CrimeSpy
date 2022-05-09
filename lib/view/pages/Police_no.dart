import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../elements/drawer.dart';

class PolicenoPage extends StatefulWidget {
  @override
  _PolicenoPageState createState() => _PolicenoPageState();
}

class _PolicenoPageState extends State<PolicenoPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1600, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: cTextNavy));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffFFFFF3),
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF012148),
        title: Text("Police Number"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            //Tag on Top
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: cTextBlack.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 1)
                  ),
                ],
              ),
              padding: EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/Police_icon.png',
                    height: 70.0,
                    width: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  AutoSizeText(
                      'Thailand National Police\nPhone Number for Bangkok',
                      maxFontSize: 20.0,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Color(0xff012148),
                        fontFamily: 'Archivo-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Second Tag
            Container(
              decoration: BoxDecoration(
                color: Color(0xffDFF7FD),
                boxShadow: [
                  BoxShadow(
                    color: cTextBlack.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 4)
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                      'Tourist Police Emergency Number:1155\nPolice Emergency Number: 191',
                      maxFontSize: 18.0,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Archivo-Semibold',
                        fontSize: 16.0,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            _ListofPoliceNo(
                text: 'North Bangkok Police Station',
                number: '02-3080946-7',
                onPressed: () => launch("tel://0230809467")),
            SizedBox(
              height: 10.0,
            ),
            _ListofPoliceNo(
                text: 'South Bangkok Police Station',
                number: '02-3080948-9',
                onPressed: () => launch("tel://0230809489")),
            SizedBox(
              height: 10.0,
            ),
            _ListofPoliceNo(
                text: 'Thonburi Bangkok Police Station',
                number: '02-3080950-1',
                onPressed: () => launch("tel://0230809501")),
            SizedBox(
              height: 10.0,
            ),
            _ListofPoliceNo(
                text: 'Suwannaphumi Airport',
                number: '02-1321155',
                onPressed: () => launch("tel://021321155")),
            SizedBox(
              height: 10.0,
            ),
            //Last one but different textAlign
            Container(
              decoration: BoxDecoration(
                color: Color(0xffDFF7FD),
                boxShadow: [
                  BoxShadow(
                    color: cTextBlack.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 4)
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: <Widget>[
                        AutoSizeText('Police Radio Dispatch',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: cTextNavy,
                              fontFamily: 'Archivo-Bold',
                              fontSize: 18.0,
                            )),
                        AutoSizeText(
                            'PhoneNumber: 02-3080333\n02-3080865\n02-3080867',
                            textAlign: TextAlign.end,
                            style: new TextStyle(
                              color: cTextNavy,
                              fontFamily: 'Archivo-Regular',
                              fontSize: 18.0,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        color: Colors.green,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () => launch("tel://023080333"),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ListofPoliceNo(
      {String text, String number, GestureTapCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffDFF7FD),
        boxShadow: [
          BoxShadow(
            color: cTextBlack.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 4)
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              children: <Widget>[
                AutoSizeText(text,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: cTextNavy,
                      fontFamily: 'Archivo-Bold',
                      fontSize: 18.0,
                    )),
                AutoSizeText('Phone Number: ' + number,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: cTextNavy,
                      fontFamily: 'Archivo-Regular',
                      fontSize: 18.0,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                color: Colors.green,
              ),
              child: IconButton(
                icon: Icon(Icons.call),
                onPressed: onPressed,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
