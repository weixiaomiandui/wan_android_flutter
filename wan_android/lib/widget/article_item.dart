import 'package:flutter/material.dart';
import 'package:wan_android/http/api.dart';
import 'package:wan_android/http/http_util_with_cookie.dart';
import 'package:wan_android/util/StringUtils.dart';
import 'package:wan_android/page/article_detail_page.dart';
import 'package:wan_android/util/DataUtils.dart';
import 'package:wan_android/page/login_page.dart';
class ArticleItem extends StatefulWidget{
  var itemData;

  //是否来自搜索列表
  bool isSearch;

  //搜索列表的id
  String id;

  ArticleItem(var itemData) {
    this.itemData = itemData;
    this.isSearch = false;
  }

  //命名构造函数,搜索列表的item和普通的item有些不一样
  ArticleItem.isFromSearch(var itemData, String id) {
    this.itemData = itemData;
    this.isSearch = true;
    this.id = id;
  }
  @override
  ArticleItemState createState()=>ArticleItemState();

}
class  ArticleItemState extends State<ArticleItem>{
  void _handleOnItemCollect(itemData) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        _login();
      } else {
        _itemCollect(itemData);
      }
    });
  }
  _login() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }
  //收藏/取消收藏
  void _itemCollect(var itemData) {
    String url;
    if (itemData['collect']) {
      url = Api.UNCOLLECT_ORIGINID;
    } else {
      url = Api.COLLECT;
    }
    url += '${itemData["id"]}/json';
    HttpUtil.post(url, (data) {
      setState(() {
        itemData['collect'] = !itemData['collect'];
      });
    });
  }
  void _itemClick(itemData) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        title: itemData['title'],
        url: itemData['link'],
      );
    }));
  }
  @override
  Widget build(BuildContext context) {
    bool isCollect = widget.itemData["collect"];

    Row author = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Row(
              children: <Widget>[
                Text('作者:  '),
                Text(
                  widget.itemData['author'],
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ],
            )),
        Text(widget.itemData['niceDate'],
          style: TextStyle(color: Theme.of(context).accentColor),)
      ],
    );
    Row title = Row(
      children: <Widget>[
        Expanded(
          child: Text.rich(
            widget.isSearch
                ? StringUtils.getTextSpan(widget.itemData['title'], widget.id)
                : TextSpan(text: widget.itemData['title']),
            softWrap: true,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Row chapterName = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.isSearch ? '' : widget.itemData['chapterName'],
            softWrap: true,
            style: TextStyle(color: Theme.of(context).accentColor),
            textAlign: TextAlign.left,
          ),
        ),
        IconButton(
          icon: Icon(
            isCollect ? Icons.favorite : Icons.favorite_border,
            color: isCollect ? Colors.red : null,
          ),
          onPressed: () {
            _handleOnItemCollect(widget.itemData);
          },
        )
      ],
    );
    // TODO: implement build
    Column column = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: author,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
          child: title,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: chapterName,
        ),
      ],
    );
    return Card(
      elevation: 4.0,
      child:InkWell(
        child: column,
        onTap: (){
          _itemClick(widget.itemData);
        },
      ),
    );
  }

}