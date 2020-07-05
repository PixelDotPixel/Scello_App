import 'package:flutter/material.dart';
import 'package:scello/API_Module/Networking.dart';
import 'package:scello/Data/NutritionOBJ.dart';

import 'package:scello/Navigator/NavigatorDrawer.dart';

class UserSearch extends StatefulWidget {

  UserSearch();

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final routeName = '/UserSearch';
  final myController = TextEditingController();
  NutritionOBJ nutritionOBJ;

  _UserSearchState();

  void _apiCall() async {
    String term;
    networkingAPI networking = new networkingAPI();
    nutritionOBJ = await networking.controller(myController.text);
    setState(() {

    });
  }

  List<Widget> getNewBody(NutritionOBJ nutritionOBJ){
    String toPrint = nutritionOBJ.foodName;
    List<Widget> bodyToReturn = [];

    Widget search = new TextField(
        controller: myController,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Search a food term'
        )
    );

    bodyToReturn.add(search);

    Widget text = new Text(
        toPrint,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold)
    );
    bodyToReturn.add(text);

    for(int i = 0; i < nutritionOBJ.totalNutriants.categories.length; i++){
      if(nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]] != null){
        String nutritionalTextFormatted = nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]].label
            + " : "
            + nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]].quantity.toString()
            + " "
            + nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]].unit;

        Widget nutritionTile = new Container(
            child: new Card(
              child: new Material(
                child: new InkWell(
                  //onTap: () => _onTileClicked(),
                  //onLongPress: () => _onTileLongClicked(),
                  splashColor: Colors.grey,
                  child: Center (
                    child: Text(
                        nutritionalTextFormatted,
                        textAlign: TextAlign.center,
                    ),
                  ),
                )
              )
            ),
          );
        bodyToReturn.add(nutritionTile);

        //        toPrint = toPrint + "\n"
//            + nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]].label
//            + " : "
//            + nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]].quantity.toString()
//            + nutritionOBJ.totalNutriants.categoriesOBJS[nutritionOBJ.totalNutriants.categories[i]].unit;
      }
    }
    
    return bodyToReturn;
  }

  @override
  Widget build(BuildContext context) {
    if(nutritionOBJ != null){
      return Scaffold(
        drawer: Drawer(
            child: NavigatorDrawer(routeName)
        ),
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: Center(
          child: ListView(
            children: getNewBody(nutritionOBJ),
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _apiCall,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Search a food term'
                  )
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _apiCall,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }
}
