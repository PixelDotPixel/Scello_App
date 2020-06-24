import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:scello/Data/FoodOBJ.dart';
import 'package:scello/Data/NutritionOBJ.dart';

class networkingAPI {
    String baseURLFood = 'https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging';
    String baseURLNutr = 'https://api.edamam.com/api/food-database/v2/nutrients?';
    String appID = 'app_id=9039d959';
    String key = 'app_key=ef1263b2ad76de5576893c04af86c41c';
    String query;

    //Constructor
    networkingAPI();

    //Query Builder for the initial food object
    String buildFoodURL(String query){
        String prependQuery = 'ingr=';
        String URL = baseURLFood + "&" + prependQuery + query + "&" + appID + "&" + key ;
        debugPrint(URL);
        return URL;
    }

    //API Call to get the food object JSON
    Future<http.Response> getFoodJSON(String URL){
        return http.get(URL);
    }

    //JSON Parse food Response
    FoodOBJs buildFoodObj(String foodJSONdata){
        FoodOBJs foodOBJ = FoodOBJs.fromJson(foodJSONdata);
        return foodOBJ;
    }


    String buildNutritionURL(String query){
        String URL = baseURLNutr + "&" + appID + "&" + key;
        return URL;
    }

    Future<http.Response> getNutritionJSON(String URL, String query){
        return http.post(
            URL,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
                <String, dynamic>
                {
                    "ingredients" : [
                        {
                            "quantity" : 10,
                            "foodId" : query,
                            "measureURI" : "http://www.edamam.com/ontologies/edamam.owl#Measure_gram"
                        }
                    ]
                }
            ),
        );
    }

    //JSON Parse Nutrition Response
    NutritionOBJ buildNutritionObj(String nutritionJSONdata){
        NutritionOBJ nutritionOBJ = NutritionOBJ.fromJson(nutritionJSONdata);
        return nutritionOBJ;
    }

    String formatQuery(String toFormat){
        return toFormat.replaceAll(" ", "%20");
    }

    controller(String unformattedQuery) async {
        String query;

        //Validity check for query
        if(unformattedQuery == ""){
            debugPrint("Empty Query");
            return;
        }

        //Format query to URL standards (replace spaces etc)
        query = formatQuery(unformattedQuery);

        //First query for getting some basic preliminary infromation
        String URL = buildFoodURL(query);
        http.Response res = await getFoodJSON(URL);
        String foodRes = res.body;
        debugPrint(res.body);
        FoodOBJs foodOBJ = buildFoodObj(foodRes);
        debugPrint("FOOD TEXT IN NETWORKING: " + foodOBJ.text);

        //check if the first query came up empty
        if(foodOBJ.text == "EMPTY RESULT"){
            debugPrint("Empty Search Result");
            return;
        }

        //Second query for getting the nutritional information of that food item
        String nutrURL = buildNutritionURL(query);
        http.Response nutres = await getNutritionJSON(nutrURL, foodOBJ.hints[0].food.foodId);
        NutritionOBJ nutritionOBJ = buildNutritionObj(nutres.body);

        //Debugging Code
//        debugPrint("=====NTUR====");
//        for(int i = 0; i < nutritionOBJ.totalNutriants.categoriesOBJS.length; i++){
//            debugPrint(nutritionOBJ.totalNutriants.categories[i] + " : " +  nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]].getString());
//        }

    }
}

class reqBody {

}