import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:scello/Data/FoodOBJ.dart';

class networkingAPI {
    String baseURL = 'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging';
    String appID = 'app_id=9039d959';
    String key = 'app_key=ef1263b2ad76de5576893c04af86c41c';
    String query;

    //Constructor
    networkingAPI();

    //Query Builder
    String buildFoodURL(String query){
        String prependQuery = 'ingr=';
        String URL = baseURL + "&" + prependQuery + query + "&" + appID + "&" + key ;
        debugPrint(URL);
        return URL;
    }

    //API Call
    Future<http.Response> getFoodJSON(String URL){
        return http.get(URL);
    }

    //API Callback

    //JSON Parse food Response
    buildFoodObj(String foodJSONdata){

    }

    //JSON Parse Nutrition Response
    buildNutritionObj(String nutritionJSONdata){

    }

    controller(String query) async {
        String URL = buildFoodURL(query);
        http.Response res = await getFoodJSON(URL);
        String temp = res.body;
        //debugPrint(temp);
        FoodOBJs tempOBJ = FoodOBJs.fromJson(res.body);
    }

}