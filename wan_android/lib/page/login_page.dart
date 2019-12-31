import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android/http/api.dart';
import 'package:wan_android/constant/constants.dart';
import 'package:wan_android/http/http_util_with_cookie.dart';
import 'package:wan_android/util/DataUtils.dart';
import 'package:wan_android/event/login_event.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState ()=>LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  TextEditingController _nameController =
  TextEditingController(text: 'canhuah');
  TextEditingController _passwordContro =
  TextEditingController(text: 'a123456');
  GlobalKey<ScaffoldState> scaffoldKey;
  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Theme.of(context).accentColor,
                  size: 80,
                )
              ],
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: '用户名'
              ),
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: '密码'
              ),
              obscureText: true,
              controller: _passwordContro,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    '登录',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  color: Theme.of(context).accentColor,
                  disabledColor: Colors.blue,
                  textColor: Colors.white,
                  onPressed: (){
                    _login();
                  },
                ),
                RaisedButton(
                  child: Text(
                    '注册',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                  disabledColor: Colors.blue,
                  textColor: Colors.white,
                  onPressed: (){
                    _register();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void _login(){
    String name = _nameController.text;
    String password = _passwordContro.text;
    if(name.length == 0){
      _showMessage('请先输入用户名');
      return;
    }
    if(password.length == 0){
      _showMessage('请先输入密码');
      return;
    }
    Map<String,String> map = Map();
    map['username'] = name;
    map['password'] = password;

    HttpUtil.post(
        Api.LOGIN,
        (data) async{
          DataUtils.saveLoginInfo(name).then((r){
            Constants.eventBus.fire(LoginEvent());
            Navigator.of(context).pop();
          });
        },
      params: map,
      errorCallback: (msg){
        _showMessage(msg);
      }

    );
  }
  void _register(){
    String name = _nameController.text;
    String password = _passwordContro.text;
    if (name.length == 0) {
      _showMessage('请先输入姓名');
      return;
    }
    if (password.length == 0) {
      _showMessage('请先输入密码');
      return;
    }
    Map<String, String> map = Map();
    map['username'] = name;
    map['password'] = password;
    map['repassword'] = password;
    HttpUtil.post(
        Api.REGISTER,
            (data) async {
          DataUtils.saveLoginInfo(name).then((r) {
            Constants.eventBus.fire(LoginEvent());
            Navigator.of(context).pop();
          });
        },
        params: map,
        errorCallback: (msg) {
          _showMessage(msg);
        });
  }
  void _showMessage(String msg){
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }
}