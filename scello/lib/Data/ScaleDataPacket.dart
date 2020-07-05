import 'dart:convert' show jsonDecode;

import 'package:flutter/cupertino.dart';

class ScaleDataPacket {
    String query;
    int mass;

    ScaleDataPacket.fromJson(String jsonString){
        final _map = jsonDecode(jsonString);
        this.mass = _map['mass'];
        this.query = _map['query'];
    }
}
