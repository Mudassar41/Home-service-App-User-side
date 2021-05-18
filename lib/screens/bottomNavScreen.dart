import 'package:flutter/material.dart';
import 'package:user_side/models/bottomNavItems.dart';

import 'package:user_side/utils/customColors.dart';

import 'bottomNavViews/homeView.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavScreen> {
  List<BottomItems> bottomList = [
    BottomItems('Home', Icons.home_filled),
    BottomItems('Inbox', Icons.mail),
    BottomItems('Settings', Icons.settings)
  ];
  int selectedIndex = 0;
  List<Widget> widgetsList = <Widget>[HomeView(), HomeView(), HomeView()];
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: widgetsList,
        physics: BouncingScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        elevation: 0.0,
        selectedItemColor: CustomColors.lightGreen,
        unselectedItemColor: Colors.grey,
        items: bottomList.map((e) {
          int index = bottomList.indexOf(e);
          return BottomNavigationBarItem(
              icon: Icon(e.iconData), label: e.title);
        }).toList(),
      ),
    ));
  }

  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped(int index) {
    pageController.jumpToPage(index);
  }
}
