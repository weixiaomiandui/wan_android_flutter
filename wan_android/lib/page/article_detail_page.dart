import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class ArticleDetailPage extends StatefulWidget{
  final String title;
  final String url;

  ArticleDetailPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);
  @override
  ArticleDetailPageState createState()=>ArticleDetailPageState();
}

class ArticleDetailPageState extends State<ArticleDetailPage>{
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebViewPlugin.onDestroy.listen((_){

      Navigator.of(context).pop();
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }

}