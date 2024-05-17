import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:register_app/controller/register_controller.dart';
import 'package:register_app/repository/register_repository.dart';
import 'package:register_app/screen/home/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RegisterController(repository: RegisterRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
