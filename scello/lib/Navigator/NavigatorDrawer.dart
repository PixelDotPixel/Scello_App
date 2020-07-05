import 'package:flutter/material.dart';

class NavigatorDrawer extends StatefulWidget {
    final String currentRoute;

    NavigatorDrawer(this.currentRoute);

    @override
    _NavigatorDrawerState createState() => _NavigatorDrawerState(currentRoute);
}

class _NavigatorDrawerState extends State<NavigatorDrawer> {
    final String currentRoute;

    _NavigatorDrawerState(this.currentRoute);

    @override
    Widget build(BuildContext context) {
        return Container(
            child: new ListView(
                children: <Widget>[
                    new ListTile(
                        title: new Text("Home"),
                        leading: Icon(
                            Icons.home,
                            color: Colors.blue,
                        ),
                        onTap: () {
                            if(currentRoute != '/'){
                                Navigator.pushNamed(
                                    context,
                                    '/'
                                );
                            } else {
                                Navigator.pop(context);
                            }
                        },
                    ),
                    new ListTile(
                        title: new Text("Search"),
                        leading: Icon(
                            Icons.search,
                            color: Colors.blue,
                        ),
                        onTap: () {
                            if(currentRoute != '/UserSearch'){
                                Navigator.pushNamed(
                                    context,
                                    '/UserSearch'
                                );
                            } else {
                                Navigator.pop(context);
                            }
                        },
                    )
                ],
            )
        );
    }

}