
import 'package:flutter/material.dart';
import 'package:travel_app/Models/CommonModel.dart';
import 'package:travel_app/Models/home_dao_model.dart';
import 'package:travel_app/pages/webView.dart';

class SaleBox extends StatelessWidget {

  final SalesBox boxModel;
  const SaleBox({Key key,@required this.boxModel}) :super(key: key);

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

    List <Widget>items = [];
    items.add(_doubleItem(context, boxModel.bigCard1,boxModel.bigCard2,true,false));
    items.add(_doubleItem(context, boxModel.smallCard1,boxModel.smallCard2,false,false));
    items.add(_doubleItem(context, boxModel.smallCard3,boxModel.smallCard4,false,true));

    return Column(
      children: [
        Container(
          height: 44,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border(bottom:  BorderSide(width: 1,color: Colors.white))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(boxModel.icon,height: 18,fit: BoxFit.fill,),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(colors: [Color(0xffff4e63),Color(0xfff6cc9)],begin: Alignment.centerLeft,end: Alignment.centerRight),
                ),
                child: GestureDetector(
                  onTap: (){
                    WebView(url: boxModel.moreUrl,);
                  },
                  child: Text('获取更多福利>>',style: TextStyle(color:  Colors.white),),
                ),
              ),

            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0,1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1,2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2,3),
        ),
      ],
    );
  }

  _item(BuildContext context, dynamic model,bool left,bool last ,bool big){

    return GestureDetector(
      onTap: (){
        print('click me ');
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>
                WebView(url: model.url,title: model.title,hideAppBar: model.hideAppBar,),
            )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(right: left ? BorderSide(width: 1,color: Colors.grey):BorderSide.none,bottom: last? BorderSide(width: 1,color: Colors.grey):BorderSide.none)
        ),
        child: Image.network(model.icon,width: MediaQuery.of(context).size.width/2-10,height: big ?128: 80,fit: BoxFit.fill,),
      )
      );
  }

  _doubleItem(BuildContext context, dynamic leftCard,dynamic rightCard,bool big,bool last){
         return Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             _item(context, leftCard, true, last,big),
             _item(context, rightCard, false, last,big),
           ],
         );
  }
}
