import 'package:flutter/material.dart';
import 'package:wan_android/util/DataUtils.dart';
import 'package:wan_android/constant/constants.dart';
import 'package:wan_android/event/login_event.dart';
import 'package:wan_android/page/collect_list_page.dart';
import 'package:wan_android/page/collect_list_page.dart';
import 'package:wan_android/page/about_us_page.dart';
import 'package:wan_android/page/login_page.dart';

class MyinfoPage extends StatefulWidget{
  @override
  MyinfoPageState createState ()=>MyinfoPageState();
}

class MyinfoPageState extends State<MyinfoPage>{
  String userName;
  @override
  void initState() {
    super.initState();

    _getName();

    Constants.eventBus.on<LoginEvent>().listen((event) {
      _getName();
    });
  }
  void _getName() async {
    DataUtils.getUserName().then((username) {
      setState(() {
        userName = username;
        print('name:' + userName.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      children: <Widget>[
        Image.asset(
          'assets/images/ic_launcher_round.png',
          width: 100.0,
          height: 100.0,
        ),
        RaisedButton(
          child: Text(
              userName == null ? '请登录':userName,
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            //登录

            await DataUtils.isLogin().then((isLogin) {
              if (!isLogin) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              } else {
                print('已登录!');
              }
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('喜欢的文章'),
          trailing: Icon(Icons.chevron_right),
          onTap: () async {
            await DataUtils.isLogin().then((isLogion){
              if(isLogion){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return CollectPage();
                }));
              }else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                 // return LoginPage();
                }));
              }
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('关于我们 '),
          trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AboutUsPage();
              }));
            }
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('推出登录'),
            trailing:
            Icon(Icons.chevron_right, color: Theme.of(context).accentColor),
            onTap: () async {
              DataUtils.clearLoginInfo();
              setState(() {
                userName = null;
              });
            }
        )
      ],
    );
  }
}