import 'package:flutter/material.dart';

Future pushPage<T extends Widget>(BuildContext context, T page) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => page));
}
