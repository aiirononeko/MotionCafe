import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'view_model/home_view_model.dart';
import '/service/login.dart';

void main() async {
  // firebase初期化処理
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // アプリ起動時自動ログイン
  await authenticationUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: MaterialApp(
        title: "Motion Cafe",
        home: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
