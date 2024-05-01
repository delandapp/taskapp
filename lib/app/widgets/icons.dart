import 'package:flutter/material.dart';
import 'package:taskapp/app/core/values/colors.dart';
import 'package:taskapp/app/core/values/icons.dart';

List<Icon> getIcons(){
  return const [
    Icon(IconData(personIcon,fontFamily: 'MaterialIcons'),color: purple,),
    Icon(IconData(worklcon,fontFamily: 'MaterialIcons'),color: pink,),
    Icon(IconData(movieIcon,fontFamily: 'MaterialIcons'),color: deepPink,),
    Icon(IconData(sporticon,fontFamily: 'MaterialIcons'),color: yellow,),
    Icon(IconData(travelIcon,fontFamily: 'MaterialIcons'),color: green,),
    Icon(IconData(shoplcon,fontFamily: 'MaterialIcons'),color: lightBlue,),
  ];
}