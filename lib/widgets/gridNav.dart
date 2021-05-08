import 'package:flutter/material.dart';
import 'package:travel_app/Models/home_dao_model.dart';

class GrudNavWidget extends StatelessWidget {
  final GridNav GridNavModel;
  const GrudNavWidget({Key key,@required this.GridNavModel}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavItems(context),
    );
  }

  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(GridNavModel == null) return items;
    if(GridNavModel.travel != null){
      items.add(Expanded(child:  _gridNavItem(context,0,true),flex: 1,));
    }
    if(GridNavModel.flight !=null){
      items.add(Expanded(child:  _gridNavItem(context,1,true),flex: 1,));
    }
    if(GridNavModel.hotel != null){
      items.add(Expanded(child:  _gridNavItem(context,2,true),flex: 1,));
    }
    return  items;
  }

  _gridNavItem(BuildContext context,int index, bool isfrist){
    List<Widget> items = [];
    items.add(_mainItem(context, index));
    items.add(_item(context, index));
    return Container(
      height: 160,
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),),
      child: Row(
        children: items,
      ),
    );
  }

  _mainItem(BuildContext context,int index){
    MainItem mainitem;
    if(index == 0){
      mainitem = GridNavModel.travel.mainItem;
    }
    if(index == 1){
      mainitem = GridNavModel.flight.mainItem;
    }
    if(index == 2){
      mainitem = GridNavModel.hotel.mainItem;
    }
    return GestureDetector(
      onTap: (){

      },
      child: Stack(
        children: [
          Image.network(mainitem.icon,fit: BoxFit.contain,alignment: AlignmentDirectional.bottomEnd,height: 88,width: 121,color: Colors.red,),
          Text(mainitem.title,style: TextStyle(fontSize: 14,color: Colors.white),),
        ],
      ),
    );

  }

  _item(BuildContext context,int indexold){
      List<String> datas = _bulidList(indexold);
      return Container(
        margin: EdgeInsets.all(3),
        width: 100,
        height: 100,
        child: GridView.builder(
            itemCount: datas.length,
            // shrinkWrap: true,
            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 1.0,
                //横轴间距
                crossAxisSpacing: 1.0,
                //子组件宽高长度比例
                childAspectRatio: 1.0),
            itemBuilder: (BuildContext context, int index) {
              //Widget Function(BuildContext context, int index)
              return _items(datas[index]);
            }),
      );

  }
  
  List<String> _bulidList(int index) {
    List<String> items = [];
    if(index == 0){
      items = [];
     items.add(GridNavModel.travel.item1.title);
     items.add(GridNavModel.travel.item2.title);
     items.add(GridNavModel.travel.item3.title);
     items.add(GridNavModel.travel.item4.title);
    }
    if(index == 1){
      items = [];
      items.add(GridNavModel.flight.item1.title);
      items.add(GridNavModel.flight.item2.title);
      items.add(GridNavModel.flight.item3.title);
      items.add(GridNavModel.flight.item4.title);
    }
    if(index == 2){
      items = [];
      items.add(GridNavModel.hotel.item1.title);
      items.add(GridNavModel.hotel.item2.title);
      items.add(GridNavModel.hotel.item3.title);
      items.add(GridNavModel.hotel.item4.title);
    }

    return items;//items.map((city) => _items(city)).toList();
  }

  Widget _items(city){
    return  FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 22,
        margin: EdgeInsets.all(1),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.teal),
        child: Text(city,style: TextStyle(color: Colors.white),),
      ),
    );
  }

}