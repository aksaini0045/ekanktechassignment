
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './Storywidgets/mainstorywidget.dart';

void main() {
  runApp(const EkankAssignment());
}

class EkankAssignment extends StatelessWidget {
  const EkankAssignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Ekank', home: Storywidget());
  }
}
