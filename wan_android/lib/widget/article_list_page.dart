import 'dart:async';
import 'package:wan_android/constant/constants.dart';
import 'package:wan_android/widget/end_line.dart';
import 'package:wan_android/widget/article_item.dart';
import 'package:wan_android/http/api.dart';
import 'package:wan_android/http/http_util_with_cookie.dart';


import 'package:flutter/material.dart';

class ArticleListPage extends StatefulWidget{
  final String id;

  ArticleListPage(this.id);
  @override
  ArticleListPageState createState ()=>ArticleListPageState();

}

class ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int curPage = 0;
  Map<String, String> map =  Map();
  List listData =  List();
  int listTotalSize = 0;
  ScrollController _controller =  ScrollController();


  void initState() {
    super.initState();
    _getArticleList();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return listData == null ? Center(
      child: CircularProgressIndicator(),
    ) : RefreshIndicator(
      child: ListView.builder(
        key: PageStorageKey(widget.id),
          itemCount: listData.length,
        controller: _controller,
          itemBuilder: (context,i)=>buildItem(i),
      ),
      onRefresh: _pullToRefresh,
    );
  }
  void _getArticleList(){
    String url = Api.ARTICLE_LIST;
    url +="$curPage/json";
    map['cid'] = widget.id;
    HttpUtil.get(
        url,
        (data){
          if(data != null){
            Map<String,dynamic> map =data;
            var _listData = map['datas'];

            listTotalSize = map["total"];

            setState(() {
              List list1 = List();
              if(curPage == 0){
                listData.clear();
              }
              curPage ++;

              list1.addAll(listData);
              list1.addAll(_listData);
              if (list1.length >= listTotalSize) {
                list1.add(Constants.END_LINE_TAG);
              }
              listData = list1;
            });
          }
        },params: map
    );

  }
  Future<Null> _pullToRefresh() async{

  }
  Widget buildItem(int i){
    var itemData = listData[i];
    if(i == listData.length - 1 && itemData.toString() == Constants.END_LINE_TAG){
      return EndLine();
    }
    return  ArticleItem(itemData);
  }
}