import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_example/themeModel.dart';

import 'login.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: const LoginPage(),
    );
  }
}
