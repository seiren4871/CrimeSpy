import 'package:auto_size_text/auto_size_text.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../elements/drawer.dart';

class HospitalnoPage extends StatefulWidget {
  @override
  _HospitalnoPageState createState() => _HospitalnoPageState();
}

class _HospitalnoPageState extends State<HospitalnoPage> {
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
        title: Text("Hospital Number"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
                  Image.asset(
                    'assets/img/Ambulance_icon.png',
                    height: 70.0,
                    width: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  AutoSizeText('Nearest Hospital Address',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Color(0xff012148),
                        fontFamily: 'Archivo-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Color(0xffDFF7FD),
                boxShadow: [
                  BoxShadow(
                    color: cTextBlack.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText('Ambulance and Rescue: 1554',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Archivo-SemiBold',
                        fontSize: 18.0,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            _ListofHospitalNo(
              text: 'Samitivej Hospital Thonburi',
              number: '02-438-900',
              address: '337 Somdet Phra Chao Tak Sin Rd,\nSamre, Thon Bangkok',
              onPressed: () => launch("tel://02438900"),
            ),
            SizedBox(
              height: 10.0,
            ),
            _ListofHospitalNo(
              text: 'Bangmod Hospital',
              number: '02-867-0606',
              address: 'Rama 2 Road, Bang Mot,\nChom Thong, Bangkok',
              onPressed: () => launch("tel://028670606"),
            ),
            SizedBox(
              height: 10.0,
            ),
            _ListofHospitalNo(
              text: 'Bangpakok 9 International Hospital',
              number: '02-109-9111',
              address: '362, Rama 2 Road, Bang Mot,\nChom Thong, Bangkok',
              onPressed: () => launch("tel://021099111"),
            ),
            SizedBox(
              height: 10.0,
            ),
            _ListofHospitalNo(
                text: 'Thonburi Bamrungmuang Hospital',
                number: '02-220-7999',
                address:
                    '611 Bamrungmuang Rd, Khlong\nMaha Nak, Pomprapsattruphai, Bangkok',
                onPressed: () => launch("tel://022207999"))
          ],
        ),
      ),
    );
  }

  Widget _ListofHospitalNo(
      {String text,
      String number,
      String address,
      GestureTapCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffDFF7FD),
        boxShadow: [
          BoxShadow(
            color: cTextBlack.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 4), // changes position of shadow
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
                      fontSize: 17.0,
                    )),
                AutoSizeText('Phone: ' + number,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: cTextNavy,
                      fontFamily: 'Archivo-Regular',
                      fontSize: 16.0,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                AutoSizeText('Address: ' + address,
                    maxFontSize: 14.0,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: cTextNavy,
                      fontFamily: 'Archivo-Regular',
                      fontSize: 12.0,
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
                  color: Colors.green),
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
