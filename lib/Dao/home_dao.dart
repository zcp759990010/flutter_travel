
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Models/home_dao_model.dart';


const home_url = 'http://www.devio.org/io/flutter_app/json/home_page.json';


class HomeDao{
  static Future<Home_daoModel> fetch() async{
    final response = await http.get(home_url);
    if(response.statusCode == 200){
      Utf8Decoder dec = new Utf8Decoder();
      var result = json.decode(dec.convert(response.bodyBytes));
      return Home_daoModel.fromJson(result);
    }else{
      throw Exception('fail');
    }
}
}