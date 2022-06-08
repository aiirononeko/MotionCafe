import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'view_model/home_view_model.dart';
import '/service/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase初期化処理
  await Firebase.initializeApp();

  if (FirebaseAuth.instance.currentUser == null) {
    // 自動ログイン
    await authenticationUser();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Motion Cafe",
        home: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
