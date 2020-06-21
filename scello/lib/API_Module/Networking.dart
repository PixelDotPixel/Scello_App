import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class networkingAPI {
    String baseURL = 'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging';
    String appID = 'app_id=9039d959';
    String key = 'app_key=ef1263b2ad76de5576893c04af86c41c';
    String query;

    //Constructor
    networkingAPI();

    //Query Builder
    String buildURL(String query){
        String prependQuery = 'ingr=';
        String URL = baseURL + "&" + prependQuery + query + "&" + appID + "&" + key ;
        debugPrint(URL);

        return URL;
    }

    //API Call
    Future<http.Response> getJSON(String URL){
        return http.get(URL);
    }

    //API Callback

    //JSON Parse
    buildFoodObj(String foodJSONdata){

    }

    controller(String query) async {
        String URL = buildURL(query);
        http.Response res = await getJSON(URL);
        String temp = res.body;

        debugPrint(temp);
    }

}