import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MyDB{
  static Box? myBox;

  static openBox() async{
    myBox = await Hive.openBox('myBox');
  }

  static writeToBox(String name) {
    myBox?.add(name);
  }
}