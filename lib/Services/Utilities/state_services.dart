import 'dart:convert';

import 'package:covid19tracker/Models/WorldStatesModel.dart';
import 'package:covid19tracker/Services/Utilities/app_url.dart';
import 'package:covid19tracker/View/world_states.dart';
import 'package:http/http.dart' as http;

class StateServices{


  Future<WorldStatesModel> fectWorkedStatesReords () async {

    final response  = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode==200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }
    else
       {
         throw Exception('error');
       }

  }
  Future<List<dynamic>> countriesListApi () async {
    final response  = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode==200){
      var data = jsonDecode(response.body);
      return data;
    }
    else
    {
      throw Exception('error');
    }

  }
}