import 'package:flutter/material.dart';

bool isMobileDevice(BoxConstraints constraints){
  if(constraints.maxWidth<700){
    return true;
  }
  return false;
}