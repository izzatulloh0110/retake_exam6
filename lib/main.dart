import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:retake_exam6/pages/detail_page.dart';
import 'package:retake_exam6/pages/home_page.dart';
import 'package:retake_exam6/services/hive_service.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        HomePage.id: (context)=> HomePage(),
        DetailPage.id: (context)=> DetailPage()
      },
    );
  }
}
