import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:xnextion_task_app/utils/constants.dart';

class ApiManager {

   static dynamic getData (String endPoint,Map<String,dynamic>data)async{

    Uri url = Uri.https(Constants.baseURL,endPoint,data);

    http.Response response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    return jsonData;

  }



}