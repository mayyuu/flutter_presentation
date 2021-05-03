import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterpresentation/fruits_application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(() {
    runApp(
        MainAppWidget()
    );
  });
}

class MainAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FruitsApplication();
  }
}
