import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:scello/Navigator/routeGenerator.dart';
import 'package:scello/Navigator/NavigatorDrawer.dart';

void main() => runApp(SCELLO());

class SCELLO extends StatelessWidget {
    @override
    Widget build(BuildContext context){
        return MaterialApp(
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
        );
    }
}

class HomePage extends StatefulWidget {
    HomePage();

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final routeName = '/';

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            drawer: Drawer(
                child: NavigatorDrawer(routeName)
            ),
            appBar: AppBar(
                title: Text("Scello"),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text("Scello")
                    ],
                ),
            ),
        );
    }
}