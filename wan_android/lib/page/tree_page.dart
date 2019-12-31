import 'package:flutter/material.dart';
import 'package:wan_android/page/articles_page.dart';
import 'package:wan_android/http/api.dart';
import 'package:wan_android/http/http_util_with_cookie.dart';
class TreePage extends StatefulWidget{
  @override
  TreePageState createState ()=>TreePageState();
}

class TreePageState extends State<TreePage>{
  var listData;
  @override
  void initState() {
    super.initState();
    _getTree();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return listData != null
        ?
    ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, i)=>buildItem(i),
    )
        :Center(
      child: CircularProgressIndicator(),
    );
  }
  _getTree() async {
    HttpUtil.get(Api.TREE, (data) {
      print(data);
      setState(() {
        listData = data;
      });
    });
  }
  Widget buildItem(i){
    var itemData = listData[i];
    Text name = Text(
      itemData['name'],
      softWrap: true,
      style: TextStyle(
          fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
    List list = itemData['children'];

    String strContent = '';

    for (var value in list) {
      strContent += '${value["name"]}   ';
    }

    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          _handOnItemClick(itemData);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: name
                    ),
                    Text(
                      strContent,
                      softWrap: true,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
  void _handOnItemClick(itemData) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticlesPage(itemData);
    }));
  }
}