import 'package:flutter/material.dart';
import 'package:wan_android/page/article_detail_page.dart';


class AboutUsPage extends StatefulWidget{
  @override
  AboutUsPageState createState ()=>AboutUsPageState();
}

class AboutUsPageState extends State<AboutUsPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        children: <Widget>[
          Image.asset(
            'assets/images/ic_launcher_round.png',
            width: 100.0,
            height: 100.0,
          ),
          ListTile(
            title: const Text('关于项目'),
            subtitle:  const Text(
                '项目是自己在学习Flutter的时候写的demo,模仿WanAndroid客户端,实现了完整的功能'),
            trailing: Icon(
                Icons.chevron_right,
              color: Theme.of(context).accentColor,
            ),
            onTap: (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return ArticleDetailPage(
                  title: 'WanAndroid_Flutter版',
                  url: 'https://github.com/weixiaomiandui/wan_android_flutter',
                );
              }));
            },
          ),
          ListTile(
              title: const Text('关于我'),
              subtitle: const Text('一个前端程序猿,初学Flutter,博客地址是..'),
              trailing: Icon(Icons.chevron_right,
                  color: Theme.of(context).accentColor),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ArticleDetailPage(
                    title: 'git地址',
                    url: 'https://github.com/weixiaomiandui/wan_android_flutter',
                  );
                }));
              }),
        ],
      ),
    );
  }
}