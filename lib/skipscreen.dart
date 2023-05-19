import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({Key? key}) : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildPage(
                color: Colors.green.shade100,
                urlImage: 'assets/img1.png',
                title: 'REDUCE',
                subtitle:
                'Buy only what you need because a better way to reduce waste is by not creating it.'),
            buildPage(
                color: Colors.green.shade100,
                urlImage: 'assets/img2.png',
                title: 'RECYCLE',
                subtitle:
                'When discarding your waste, find ways to recycle it instead of letting it go to landfill.'),
            buildPage(
                color: Colors.green.shade100,
                urlImage: 'assets/img3.jpeg',
                title: 'REUSE',
                subtitle:
                'If you have to acquire goods, try getting used ones or obtaining substitutes.'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
        color: Colors.green.shade100,
        child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.teal.shade700,
              minimumSize: Size.fromHeight(80)),
          onPressed: () async {
            SharedPreferences pref =
            await SharedPreferences.getInstance();
            await pref.setBool('isfirsttime', false);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
          },
          child: Text(
            'FINISH',
            style: TextStyle(fontSize: 24),
          ),
        ),
      )
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () => controller.jumpToPage(2),
                child: Text('SKIP')),
            TextButton(
                onPressed: () => controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
                child: Text('NEXT'))
          ],
        ),
      ),
    );
  }

  buildPage(
      {required Color color,
        required String urlImage,
        required String title,
        required String subtitle}) {
    return Container(
      color: color,
      child: Column(
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SizedBox(
            height: 64,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 64,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(subtitle, style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
}
