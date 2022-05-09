import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/elements/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrimestatPage extends StatefulWidget {
  @override
  _CrimestatPageState createState() => _CrimestatPageState();
}

class _CrimestatPageState extends State<CrimestatPage> {
  @override
  int burglar, fraud, robbery, murder, sexual, stalking, other;

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
        title: Text("Crime Statistics"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            //Show Current Location
            Container(
              height: 100.0,
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
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText('Your Location',
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                              color: Color(0xff012148),
                              fontFamily: 'Archivo-SemiBold',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 8.0),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 30.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.4,
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 10.0),
                              constraints: BoxConstraints(
                                minWidth: 230.0,
                              ),
                              child: AutoSizeText(
                                "126 Pracha Uthit Rd., Bang Mod, Thung Kru, Bangkok",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Archivo-Regular',
                                  fontSize: 18.0,
                                  color: cTextNavy,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //Crime Records From News
            Container(
              decoration: BoxDecoration(
                color: Color(0xff023388),
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
                  AutoSizeText('Crime Report by National Newspaper',
                      maxLines: 1,
                      maxFontSize: 18.0,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Color(0xffDFF7FD),
                        fontFamily: 'Archivo-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: cTextBlack.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
              child: Column(
                children: <Widget>[
                  _CrimeStatFromNews(context, "Burglar", 3),
                  Divider(),
                  _CrimeStatFromNews(context, "Fruad", 10),
                  Divider(),
                  _CrimeStatFromNews(context, "Murder", 1),
                  Divider(),
                  _CrimeStatFromNews(context, "Robbery", 20),
                  Divider(),
                  _CrimeStatFromNews(context, "Sexual Assualt", 11),
                  Divider(),
                  _CrimeStatFromNews(context, "Stalking", 3),
                  Divider(),
                  _CrimeStatFromNews(context, "other", 5),
                  Divider(),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            //Crime Records From Users
            Container(
              decoration: BoxDecoration(
                color: Color(0xff023388),
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
                  AutoSizeText('Crime Report by Users from CrimeSpy',
                      maxLines: 1,
                      maxFontSize: 18.0,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Color(0xffDFF7FD),
                        fontFamily: 'Archivo-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: cTextBlack.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
              child: Column(
                children: [
                  getCrimeAmount(),
                ],
//                  _CrimeStatFromUsers(),
//                  Divider(),
//                  _CrimeStatFromUsers(),
//                  Divider(),
//                  _CrimeStatFromUsers(),
//                  Divider(),
//                  _CrimeStatFromUsers(),
//                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCrimeAmount() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("CrimeRecord")
          .snapshots(includeMetadataChanges: true),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.data == null) {
          return CircularProgressIndicator();
        }
        if (snapshots.hasError) {
          print('Something went wrong');
        }
        if (snapshots.connectionState == ConnectionState.waiting) {
          print("Loading");
        }
        return _CrimeStatFromUsers(context, snapshots.data.documents);
      },
    );
  }

  Widget _CrimeStatFromUsers(
      BuildContext context, List<DocumentSnapshot> listdoc) {
    burglar = 0;
    fraud = 0;
    robbery = 0;
    murder = 0;
    sexual = 0;
    stalking = 0;
    other = 0;

    listdoc.forEach((element) {
      switch (element.data["type"]) {
        case "Murder":
          murder++;
          break;
        case "Burglary":
          burglar++;
          break;
        case "Fraud":
          fraud++;
          break;
        case "Robbery":
          robbery++;
          break;
        case "Sexual Assault":
          sexual++;
          break;
        case "Stalking":
          stalking++;
          break;
        case "Other":
          other++;
          break;
        default:
          break;
      }
    });

    List<CrimeStat> crimes = [
      CrimeStat("Murder", murder),
      CrimeStat("Burglary", burglar),
      CrimeStat("Fraud", fraud),
      CrimeStat("Robbery", robbery),
      CrimeStat("Sexual Assault", sexual),
      CrimeStat("Stalking", stalking),
      CrimeStat("Other", other)
    ];

    return ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListView(
            shrinkWrap: true,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                        (crimes[index] != null)
                            ? crimes[index].crimetype
                            : 'sth wrong', // crimeType,
                        textAlign: TextAlign.start,
                        style: new TextStyle(
                          color: cTextNavy,
                          fontFamily: 'Archivo-Bold',
                          fontSize: 16.0,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                        (crimes[index] != null)
                            ? "${crimes[index].amount}"
                            : 'sth wrong', //crimeAmount,
                        textAlign: TextAlign.end,
                        style: new TextStyle(
                          color: cTextNavy,
                          fontFamily: 'Archivo-Bold',
                          fontSize: 16.0,
                        )),
                  ),
                ],
              ),
              Divider(),
            ],
          );
        });
  }

  Widget _CrimeStatFromNews(BuildContext context, String type, int amount) {
    // final String crimeTypeFromNews = DemoValues.postInformation; can query from DB
    // final String crimeAmountFromNews = DemoValues.postInformation; can query from DB

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(type, // crimeTypeFromNews,
              textAlign: TextAlign.start,
              style: new TextStyle(
                color: cTextNavy,
                fontFamily: 'Archivo-Bold',
                fontSize: 16.0,
              )),
        ),
        Expanded(
          flex: 2,
          child: Text("$amount", //crimeAmountFromNews,
              textAlign: TextAlign.end,
              style: new TextStyle(
                color: cTextNavy,
                fontFamily: 'Archivo-Bold',
                fontSize: 16.0,
              )),
        ),
      ],
    );
  }
}

class CrimeStat {
  String crimetype;
  int amount;

  CrimeStat(this.crimetype, this.amount);
}
