import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/app/bindings/bindings.dart';
import 'package:todo_app/app/data/services/db_helper.dart';
import 'package:todo_app/app/data/services/theme_services.dart';
import 'package:todo_app/app/ui/pages/home_page.dart';
import 'package:todo_app/app/ui/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.grey,
  ));
  await DBHelper.initDb();
  GetStorage.init;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeServices().theme,
      defaultTransition: Transition.fade,
      initialBinding: Binding(),
      home: const HomePage(),
    );
  }
}
