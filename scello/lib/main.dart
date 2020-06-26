import 'package:flutter/material.dart';
import 'package:scello/API_Module/Networking.dart';
import 'package:scello/Data/NutritionOBJ.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  NutritionOBJ nutritionOBJ;

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
        appBar: AppBar(
          title: Text(widget.title),
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
          title: Text(widget.title),
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
