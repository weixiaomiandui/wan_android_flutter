import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:wan_android/widget/article_list_page.dart';
class ArticlesPage extends StatefulWidget{
  final data;

  ArticlesPage(this.data);
  @override
  ArticlesPageState createState()=>ArticlesPageState();

}


class ArticlesPageState extends State<ArticlesPage> with SingleTickerProviderStateMixin{
  TabController _tabContro;
  List<Tab> tabs = List();
  List<dynamic> list;
  void initState() {
    super.initState();
    list = widget.data['children'];

    for (var value in list) {
      tabs.add(Tab(text: value['name']));
    }

    _tabContro = TabController(length: list.length, vsync: this);
  }
  @override
  void dispose() {
    _tabContro.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['name']),
      ),
      body: DefaultTabController(
          length: list.length,
          child: Scaffold(
            appBar: TabBar(
              isScrollable: true,
                controller: _tabContro,
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Colors.black,
                indicatorColor: Theme.of(context).accentColor,
                tabs: tabs
            ),
            body: TabBarView(
              controller: _tabContro,
                children: list.map((dynamic itemData){
                  return  ArticleListPage(itemData['id'].toString());
                }).toList(),
            ),
          )
      ),
    );
  }

}