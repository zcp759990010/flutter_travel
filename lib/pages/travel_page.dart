
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> cityNames = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

class TravelPage extends StatefulWidget {
  @override
  TravelPageState createState() => new TravelPageState();
}

class TravelPageState extends State<TravelPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('collectionview'),
      ),
      body:RefreshIndicator(
        onRefresh: _handelData,
        child: GridView.count(
          crossAxisCount: 2,
          children: _bulidList(),
        ),
      ),
    );
  }

  List<Widget> _bulidList() {
     return cityNames.map((city) => _items(city)).toList();
  }

  Widget _items(String city){
      return  Container(
          height: 80,
         margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.teal),
        child: Text(city,style: TextStyle(color: Colors.white),),
      );
  }

  Future<Null> _handelData() async{
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        cityNames = cityNames.reversed.toList();
      });
  }


}