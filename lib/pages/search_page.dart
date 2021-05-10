import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_app/Models/CommonModel.dart';


class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('111111'),
      ),
      body: FutureBuilder<CommonModel>(
        future: fetchData(),
         builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot){
           switch(snapshot.connectionState){
             case ConnectionState.none:
               return Text('input a url');
             case ConnectionState.waiting:
               return CircularProgressIndicator();
             case ConnectionState.active:
               return Text('active');
             case ConnectionState.done:
               if(snapshot.hasError){
                 return Text(
                   '${snapshot.error}',
                   style: TextStyle(color:Colors.red),
                 );
               }else{
                 return new Column(children: <Widget>[
                   Text('icon:${snapshot.data.icon}'),
                   Text('statusBarColor:${snapshot.data.statusBarColor}'),
                   Text('title:${snapshot.data.title}'),
                   Text('url:${snapshot.data.url}')
                 ]);
               }
           }
         },
      ),
    );

  }

  // Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [
  // InkWell(
  // onTap: (){
  // fetchData().then((CommonModel value){
  // setState(() {
  // result =
  // '请求结果：\nhideAppBar：${value.hideAppBar}\nicon：${value.icon}';
  // });
  // });
  // },
  // child: Text('click',style: TextStyle(color: Colors.red),),
  // ),
  // Text(result,style: TextStyle(color: Colors.red),),
  // ],
  // );
  Future<CommonModel> fetchData() async {
     final response  = await http.get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final result = json.decode(response.body);
    print(response.body);
    return new CommonModel.fromJson(result);
  }
}


