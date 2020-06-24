import 'dart:convert' show jsonDecode;
import 'dart:core';

import 'package:flutter/cupertino.dart';

class NutritionOBJ {
    int yield;
    int calories;
    int glycemicIndex;
    int totalWeight;
    List<String> dietLabels;
    List<String> healthLabels;
    List<String> cautions;
    TotalNutriants totalNutriants;
    TotalDaily totalDaily;

    NutritionOBJ.fromJson(String jsonString){
        final _map = jsonDecode(jsonString);
        this.totalNutriants = TotalNutriants.fromJson(_map['totalNutrients']);
    }
}

class TotalNutriants {
    List<String> categories = ['ENERC_KCAL','FAT','FASAT','FAMS','FAPU','CHOCDF','FIBTG','SUGAR','PROCNT','CHOLE','NA','CA','MG','K','FE','ZN','P','VITA_RAE','VITC','THIA','RIBF','NIA','VITB6A','FOLDFE','FOLFD','FOLAC','VITB12','VITD','TOCPHA','VITK1','WATER'];
    Map<String, LQUBlock> categoriesOBJS = Map<String, LQUBlock>();
//    LQUBlock ENERC_KCAL;
//    LQUBlock FAT;
//    LQUBlock FASAT;
//    LQUBlock FAMS;
//    LQUBlock FAPU;
//    LQUBlock CHOCDF;
//    LQUBlock FIBTG;
//    LQUBlock SUGAR;
//    LQUBlock PROCNT;
//    LQUBlock CHOLE;
//    LQUBlock NA;
//    LQUBlock CA;
//    LQUBlock MG;
//    LQUBlock K;
//    LQUBlock FE;
//    LQUBlock ZN;
//    LQUBlock P;
//    LQUBlock VITA_RAE;
//    LQUBlock VITC;
//    LQUBlock THIA;
//    LQUBlock RIBF;
//    LQUBlock NIA;
//    LQUBlock VITB6A;
//    LQUBlock FOLDFE;
//    LQUBlock FOLFD;
//    LQUBlock FOLAC;
//    LQUBlock VITB12;
//    LQUBlock VITD;
//    LQUBlock TOCPHA;
//    LQUBlock VITK1;
//    LQUBlock WATER;

    TotalNutriants.fromJson(Map<String, dynamic> mapJson){
        for(int i = 0; i < categories.length; i++){
            categoriesOBJS[categories[i]] = LQUBlock.fromJson(mapJson[categories[i]]);
        }
    }
}

class TotalDaily {

}

//Label Quantity Unit block
class LQUBlock{
    String label;
    double quantity;
    String unit;

    LQUBlock.fromJson(Map<String, dynamic> mapJson){
        this.label = mapJson['label'];
        this.quantity = mapJson['quantity'];
        this.unit = mapJson['unit'];
    }

    String getString(){
        String LQUString = '\n label : ' + label + '\n quantity : ' + quantity.toString() + '\n unit : ' + unit;
        return LQUString;
    }
}