import 'dart:convert';

import 'package:covid19_tracker/services/utility/appurl.dart';
import 'package:http/http.dart' as http;

import '../models/Worldstats.dart';

class StatServices{

  Future<Worldstats> fetchworldstats ()async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode==200){
      var data=jsonDecode(response.body);
      return Worldstats.fromJson(data);
    }else{
      throw Exception('Error');
    }

  }

  Future<List<dynamic>> CountrieslistApi ()async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode==200){
      data=jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }

  }
}