import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myresume/const.dart';

class GameStats{
  final String _accountID="75a4a793c0534623aa46ab978d564492";

  Future<Map> getAccountStats() async{
    http.Response response=await http.get(fortniteAPIUrl+"?account=$_accountID",headers: {
      "Authorization":fortniteStatsAPIKey
    });
    if(response.statusCode==200){
      print("OK");
      return jsonDecode(response.body)['global_stats'];
    }
    else{
      print("Not OK");
    }
  }
}