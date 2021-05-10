
import 'package:flutter/material.dart';
import 'package:travel_app/Models/home_dao_model.dart';
import 'package:travel_app/pages/webView.dart';

class SubNav extends StatelessWidget {

  final List<SubNavList> lists;
  const SubNav({Key key,@required this.lists}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(1),
        child: _items(context),
      ),
    );
  }


  _items(BuildContext context){
    int pages = (lists.length/2+0.5).toInt();
    if(lists == null) return Container();
    List<Widget>list1 = [];
    lists.forEach((model) {
      list1.add(_item(context,model));
    });
    return Column(
       children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list1.sublist(0,pages),
    ),
    Padding(
      padding: EdgeInsets.only(top: 7),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list1.sublist(pages,lists.length),
    ),
    ),

       ],
    );
  }

  _item(BuildContext context, SubNavList model){

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: (){
          print('click me ');
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>
                  WebView(url: model.url,title: model.title,hideAppBar: model.hideAppBar,),
              )
          );
        },
        child: Column(
          children: [
            Image.network(model.icon,width: 18,height: 18,),
            Padding(padding: EdgeInsets.only(top: 3),
            child: Text(model.title,style: TextStyle(fontSize: 12),),)
          ],
        ),
      ),
    );
  }
}
