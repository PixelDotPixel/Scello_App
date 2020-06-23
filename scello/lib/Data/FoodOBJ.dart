import 'dart:convert' show jsonDecode;

import 'package:flutter/cupertino.dart';

class FoodOBJs {
    String text;
    List<hintsOBJ> parsed;
    List<hintsOBJ> hints;

    FoodOBJs.fromJson(String jsonString) {
        final _map = jsonDecode(jsonString);
        this.text = _map['text'];
        //this.parsed = _map[''];
        final _parsedList = _map['hints'];
        hintsOBJ temp = hintsOBJ.fromJson(_parsedList[0]);

        debugPrint("PRCNT: "+temp.food.nutrients.PROCNT.toString());
    }
}

class hintsOBJ {
    FoodOBJ food;
    List<measureURI> measures = [];

    hintsOBJ.fromJson(Map<String, dynamic> jsonMap){
        int i = 0;
        this.food = FoodOBJ.fromJson(jsonMap['food']);

        final _measureTemp = jsonMap['measures'];

        //TODO - Figure out size range
        while(i < 3){
            measureURI temp = measureURI.fromJson(_measureTemp[i]);
            if(temp != Null) {
                measures.add(temp);
            }
            i++;
        }
    }
}

class FoodOBJ {
    String foodId;
    String label;
    nutrientsOBJ nutrients;
    double servingsPerContainer;
    String image;

    FoodOBJ.fromJson(Map<String, dynamic> jsonMap){
        this.foodId = jsonMap['foodId'];
        this.label = jsonMap['label'];
        this.servingsPerContainer = jsonMap['servingsPerContainer'];
        this.nutrients = nutrientsOBJ.fromJson(jsonMap['nutrients']);
        this.image = jsonMap['image'];
        debugPrint("FOODID: " + foodId);
    }
}

class nutrientsOBJ {
    double ENERC_KCAL;
    double PROCNT;
    double FAT;
    double CHOCDF;
    double FIBTG;

    nutrientsOBJ.fromJson(Map<String, dynamic> jsonMap){
        this.ENERC_KCAL = jsonMap['ENERC_KCAL'];
        this.PROCNT = jsonMap['PROCNT'];
        this.FAT = jsonMap['FAT'];
        this.CHOCDF = jsonMap['CHOCDF'];
        this.FIBTG = jsonMap['FIBTG'];
    }
}

class measureURI {
    String uri;
    String label;
    measureURI.fromJson(Map<String, dynamic> jsonMap){
        this.uri = jsonMap['uri'];
        this.label = jsonMap['label'];
    }
}