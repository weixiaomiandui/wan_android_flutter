import 'package:flutter/material.dart';
import 'package:wan_android/constant/colors.dart';
import 'package:wan_android/page/home_list_page.dart';
import 'package:wan_android/page/tree_page.dart';
import 'package:wan_android/page/myInfo_page.dart';
class TabNavigator extends StatefulWidget{
  @override
  _TabNavigatorState createState ()=>_TabNavigatorState();

}

class _TabNavigatorState extends State<TabNavigator> with TickerProviderStateMixin{
  int _tabIndex = 0;
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  var appBarTitles = ['首页', '发现', '我的'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor:AppColors.colorPrimary, accentColor: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitles[_tabIndex],
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){

              },
            )
          ],
        ),
        body: PageView(
          controller: _controller,
          children: <Widget>[
            HomeListPage(),
            TreePage(),
            MyinfoPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _tabIndex,
            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _tabIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomItem(appBarTitles[0], Icons.home, 0),
              _bottomItem(appBarTitles[1], Icons.widgets, 1),
              _bottomItem(appBarTitles[2], Icons.person, 2),
            ]
        ),
      ),
    );
  }
  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _tabIndex != index ? _defaultColor : _activeColor),
        ));
  }
}