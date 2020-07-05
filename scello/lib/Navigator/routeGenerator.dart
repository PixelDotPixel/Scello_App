import 'package:flutter/material.dart';
import 'package:scello/main.dart';
import 'package:scello/Page_Nutrition/UserSearch.dart';

class RouteGenerator {
    static Route<dynamic> generateRoute(RouteSettings settings){
        var args;

        switch (settings.name){
            case '/': return MaterialPageRoute(builder: (_) => HomePage());
                break;
            case '/UserSearch': return MaterialPageRoute(builder: (_) => UserSearch());
                break;
        }
    }
}