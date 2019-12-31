import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_android/constant/constants.dart';
import 'package:wan_android/widget/slide_view.dart';
import 'package:wan_android/http/api.dart';
import 'package:wan_android/widget/end_line.dart';
import 'package:wan_android/widget/article_item.dart';
import 'package:wan_android/http/http_util_with_cookie.dart';
class HomeListPage extends StatefulWidget{
  @override
  HomeListPageState createState ()=> HomeListPageState();
}

class HomeListPageState extends State<HomeListPage>{
  List listData = List();
  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;
  ScrollController _contraller = ScrollController();

  Future<Null> _pullToRefresh() async {

    return null;
  }
  @override
  void initState() {
    super.initState();
    getBanner();
    getHomeArticlelist();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return listData == null
        ? Center(
      child: CircularProgressIndicator(),
    )
        : RefreshIndicator(
      child: ListView.builder(
        itemCount: listData.length + 1,
          itemBuilder: (context,i)=>buildItem(i),
        controller: _contraller,
      ),
        onRefresh: _pullToRefresh

    );
  }
  SlideView _bannerView;

  void getBanner() {
    String bannerUrl = Api.BANNER;
   // print(bannerUrl);
    HttpUtil.get(bannerUrl, (data) {
      //print(data);
      if (data != null) {
        setState(() {
          bannerData = data;
          _bannerView = SlideView(bannerData);
        });
      }
    });
  }
  void getHomeArticlelist() {
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";

    HttpUtil.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;

        var _listData = map['datas'];

        listTotalSize = map["total"];

        setState(() {
          List list1 = List();
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;

          list1.addAll(listData);
          list1.addAll(_listData);
          if (list1.length >= listTotalSize) {
            list1.add(Constants.END_LINE_TAG);
          }
          listData = list1;
        });
      }
    });
  }
  Widget buildItem(int i){
    if(i == 0){
      return Container(
        height: 180.0,
        child: _bannerView,
      );
    }
    i-=1;
    var itemData = listData[i];
    print(itemData);
    if(itemData is String && itemData == Constants.END_LINE_TAG){
      return EndLine();
    }
    return ArticleItem(itemData);
  }
}