import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:travel_app/Dao/home_dao.dart';
import 'package:travel_app/Models/home_dao_model.dart';
import 'package:travel_app/widgets/local_nav.dart';
import 'package:travel_app/widgets/gridNav.dart';
import 'package:travel_app/widgets/salesBix.dart';
import 'package:travel_app/widgets/sub_nav.dart';

const APP_SCROLL_OFFSET = 100;
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}


class HomePageState extends State<HomePage> {
  double appbaralpha = 0;
  String restltStr = '';
  Home_daoModel homeModel;
  List _imageUrls = ["http://www.devio.org/img/avatar.png","http://gimg.xiaoxigeek.com/FnEeL_fm5HkVLp0jXj4OmyoXfJeX","http://gimg.xiaoxigeek.com/Fk-Dmrmo5XCEaVCQ8hc60CvyB5Io"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f4),
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                  _scorll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: [
                  Container(
                    height: 180,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context,int index){
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fitWidth,
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                  child: LocalNav(lists: homeModel.localNavList),),
                 // Padding(padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                   // child: GrudNavWidget(GridNavModel: homeModel.gridNav),),
                  Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                  child: SubNav(lists: homeModel.subNavList),),
                  Padding(padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: SaleBox(boxModel: homeModel.salesBox),),
                  Container(
                    height: 800,
                    child: ListTile(title: Text(restltStr),),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appbaralpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('home'),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  void _scorll(offset) {
   double alpha = offset/APP_SCROLL_OFFSET;
   if(alpha < 0 ){
     alpha = 0;
   }else if (alpha > 1){
     alpha = 1;
   }
   setState(() {
     appbaralpha = alpha;
   });
  }
@override
  void initState(){
    super.initState();
    _loadData();
  }

  _loadData() async{
    try{
      Home_daoModel model = await HomeDao.fetch();
      setState(() {
        restltStr = model.config.searchUrl;
        homeModel = model;
      });
    }catch (e){
      setState(() {
        restltStr = e.toString();
      });
    }
  }

}


