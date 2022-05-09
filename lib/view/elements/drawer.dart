import 'package:crimespy/view/pages/Hospital_no.dart';
import 'package:crimespy/view/pages/Police_no.dart';
import 'package:crimespy/view/elements/colors.dart';
import 'package:crimespy/view/pages/authentication/login.dart';
import 'package:crimespy/view/pages/crimeRecord/crime_stat.dart';
import 'package:crimespy/view/pages/crimeReport/choose_crime.dart';
import 'package:crimespy/view/pages/profile.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../../model/user_model.dart' as user_model;

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
          ),
          _createDrawerItem(
            icon: Icons.local_taxi,
            text: 'Police Number',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PolicenoPage()));
            },
          ),
          _createDrawerItem(
            icon: Icons.local_hospital,
            text: 'Hospital Number',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HospitalnoPage()));
            },
          ),
          _createDrawerItem(
            icon: Icons.sms,
            text: 'Crime Report',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ChoosecrimePage()));
            },
          ),
          _createDrawerItem(
            icon: Icons.find_in_page,
            text: 'Crime Record',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CrimestatPage()));
            },
          ),
          Divider(),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Archivo-Regular',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage()));
            },
          ),
          _createDrawerItem(
            icon: Icons.exit_to_app,
            text: 'Log out',
            onTap: () {
              try {
                user_model.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              } catch (err) {
                print(err);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff023388), Color(0xff012148)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      accountName: Text((user_model.name != "")
          ? user_model.name
          : "John Doe"), //accountName HERE!
      accountEmail: Text((user_model.email != "")
          ? user_model.email
          : "john.doe123@gmail.com"), //accountEmail HERE!!
      currentAccountPicture: CircleAvatar(
        foregroundColor: Color(0xFFffa62b),
        backgroundColor: cTextNavy,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(100.0),
          child: Image(
            image: AssetImage('assets/img/profile_anonymous.jpg'),
            width: 70.0,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Color(0xFFffa62b),
            size: 30.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Archivo-Regular',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
