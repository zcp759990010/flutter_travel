
import 'package:flutter/material.dart';
import 'package:travel_app/Models/home_dao_model.dart';
import 'package:travel_app/pages/webView.dart';

class LocalNav extends StatelessWidget {

  final List<LocalNavList> lists;
  const LocalNav({Key key,@required this.lists}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }


  _items(BuildContext context){
    if(lists == null) return Container();
    List<Widget>list1 = [];
    lists.forEach((model) {
      list1.add(_item(context,model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list1,
    );
  }

  _item(BuildContext context, LocalNavList model){

    return GestureDetector(
      onTap: (){
        print('click me ');
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=>
            WebView(url: model.url,title: model.title,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,),
        )
        );
      },
      child: Column(
        children: [
          Image.network(model.icon,width: 32,height: 32,),
          Text(model.title,style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }
}
