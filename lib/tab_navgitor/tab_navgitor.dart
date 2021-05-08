import 'package:flutter/material.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/pages/me_page.dart';
import 'package:travel_app/pages/search_page.dart';
import 'package:travel_app/pages/travel_page.dart';

class TabbarNavgitor extends StatefulWidget {
  @override
  _TabbarNavgitorState createState() => new _TabbarNavgitorState();
}

class _TabbarNavgitorState extends State<TabbarNavgitor> {
  final PageController controller = PageController();
  final _selectCorlor = Colors.blue;
  final _defultCorlor = Colors.grey;
  int _seletIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          HomePage(),
          SearchPage(),
          TravelPage(),
          MePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: _defultCorlor,),
            activeIcon: Icon(Icons.home,color: _selectCorlor,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: _defultCorlor,),
            activeIcon: Icon(Icons.search,color: _selectCorlor,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel,color: _defultCorlor,),
            activeIcon: Icon(Icons.card_travel,color: _selectCorlor,),
            label: 'travel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake,color: _defultCorlor,),
            activeIcon: Icon(Icons.card_travel,color: _selectCorlor,),
            label: 'me',
          ),
        ],
        currentIndex: _seletIndex,
        onTap: (index){
          setState(() {
            controller.jumpToPage(index);
            _seletIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: Colors.red),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}