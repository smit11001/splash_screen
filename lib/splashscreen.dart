import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboardscreen.dart';
import 'loginpage.dart';
import 'skipscreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.network(
          'https://hotpot.ai/designs/thumbnails/splash-screen/9.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void checklogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? islogedin = pref.getBool('Login');
    bool? isfirsttime = pref.getBool('isfirsttime');
    if (isfirsttime != null && !isfirsttime) {
      if (islogedin != null && islogedin) {
        Future.delayed(Duration(seconds: 5)).then((value) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    title: 'DashBoard',
                  )),
                  (route) => false);
        });
      } else {
        Future.delayed(Duration(seconds: 5)).then((value) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
        });
      }
    } else {
      Future.delayed(Duration(seconds: 5)).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CustomPageView()),
                (route) => false);
      });
    }
  }
}
