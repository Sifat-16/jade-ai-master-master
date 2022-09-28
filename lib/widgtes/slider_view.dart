import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jadeais/helper/authhelper.dart';
import 'package:jadeais/screens/loginscreen/loginpage.dart';

import '../mls/profilemodel.dart';

class SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  SliderView({Key? key, this.onItemClick}) : super(key: key);
  FireBase fireBase = FireBase();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 204, 204, 204),
      body: StreamBuilder<Profile>(
        stream: fireBase.myProfileStream(),
        builder: (context, snap) {
          return snap.hasData?SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 60,

                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${snap.data!.username}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'BalsamiqSans'),
                ),
                const SizedBox(
                  height: 20,
                ),
                _SliderMenuItem(
                    title: 'Funding records', iconData: Icons.home, onTap: onItemClick),
                _SliderMenuItem(
                    title: 'Notification',
                    iconData: FontAwesomeIcons.bell,
                    onTap: onItemClick),
                _SliderMenuItem(
                    title: 'Withdrawl method',
                    iconData: FontAwesomeIcons.moneyBill,
                    onTap: onItemClick),
                _SliderMenuItem(
                    title: 'Security', iconData:FontAwesomeIcons.shield, onTap: onItemClick),
                _SliderMenuItem(
                    title: 'Feedback', iconData: FontAwesomeIcons.question, onTap: onItemClick),
                    _SliderMenuItem(
                    title: 'Support', iconData: FontAwesomeIcons.headphones, onTap: onItemClick),
                      _SliderMenuItem(
                    title: 'Settings', iconData: FontAwesomeIcons.gear, onTap: onItemClick),
                GestureDetector(
                  onTap: ()async{
                    await auth.signOut();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                  },
                  child: _SliderMenuItem(
                      title: 'LogOut',
                      iconData: Icons.arrow_back_ios,
                      onTap: onItemClick,),
                )
              ],
            ),
          ):Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
        leading: Icon(iconData, color: Colors.black),
        );
  }
}


class Data {
  MaterialColor color;
  String name;
  String detail;

  Data(this.color, this.name, this.detail);
}

class ColoursHelper {
  static Color blue() => const Color(0xff5e6ceb);

  static Color blueDark() => const Color(0xff4D5DFB);
}