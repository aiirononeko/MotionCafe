import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/service/hex_color.dart';
import '../ui/home_screen.dart';
import '../utils/widget_utils.dart';

class HomeViewModel with ChangeNotifier {
  int _originalAmount = 0; // 入力時の合計金額
  int _calculateAmount = 0; // 会計時の合計金額
  int _tickets = 0; // 所持しているチケット枚数
  int _selectedTicketsNum = 0; // 使用するチケットの枚数
  int _points = 0; // ポイント数
  bool _premium = false; // プレミアムメンバー
  String _uid = ""; // ユーザーID
  int get originalAmount => _originalAmount;
  int get calculateAmount => _calculateAmount;
  int get tickets => _tickets;
  int get selectedTicketsNum => _selectedTicketsNum;
  bool get premium => _premium;
  String get uid => _uid;
  QRViewController? controller; // QRコードを読み取る時に必要な変数

  // QRCodeを読み取るOSの種類を設定
  void setController(QRViewController ctrl) {
    controller = ctrl;
    notifyListeners();
  }

  Color checkIsPremiumCardColor() {
    if (_premium) {
      // プレミアム会員の場合
      return HexColor("FAFF00");
    } else {
      // ベーシック会員の場合
      return HexColor("FC2951");
    }
  }

  // QRCodeを読み取った結果をセットする
  Future<void> setUidAndTickets(Barcode? res) async {
    _uid = res!.code!;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await firestore.collection('Customers').doc(_uid).get();
    Map<String, dynamic>? customerData =
        snapshot.data() as Map<String, dynamic>?;
    _tickets = customerData!["coffeeTickets"];
    _premium = customerData["isPremium"];
    _points = customerData["points"];
    _selectedTicketsNum = _tickets;
    notifyListeners();
  }

  Future<void> send() async {
    _points += originalAmount ~/ 500; // 500円あたり1ポイント
    _tickets += _points ~/ 10; // 10ポイントあたり1コーヒーチケット

    // ポイントが10を超えないようにする処理
    while (_points >= 10) {
      _points -= 10;
    }

    // firebaseのdbを更新する処理
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('Customers').doc(_uid).update(
      {
        "points": _points,
        "coffeeTickets": (_tickets - selectedTicketsNum),
      },
    );
    notifyListeners();
  }

  // 純粋な合計金額をセットする
  void setOriginalAmount(String value) {
    _originalAmount = value.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  // 選択チケット枚数と会員の種類で合計金額を計算する
  void calAmount() {
    _calculateAmount = _originalAmount;
    _calculateAmount -= premium ? 800 : 0;
    _calculateAmount -= selectedTicketsNum * 800;
    _calculateAmount = _calculateAmount < 0 ? 0 : _calculateAmount;
    notifyListeners();
  }

  // ユーザーの使用できるチケット数をticketsにセットする
  void setTickets(String value) {
    _tickets = value.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  // 会計で使用するチケット数をselectedTicketsNumにセットする
  void setSelectedTicketsNum(String selectedNum) {
    _selectedTicketsNum = int.parse(selectedNum);
    notifyListeners();
  }

  // チケット枚数を選択する時に使うリストをセットする
  List<DropdownMenuItem<int>> dropDownButtonList() {
    List<DropdownMenuItem<int>> list = [];
    for (var i = 0; i <= _tickets; i++) {
      list.add(
        DropdownMenuItem(
          child: Text(
            "$i",
          ),
          value: i,
        ),
      );
    }
    return list;
  }

  Future<void> checkShowDialog(BuildContext context) async {
    if (_uid.isEmpty) {
      await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("QRコードを読み取ってください"),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: checkIsPremiumCardColor(),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(
                    color: checkIsPremiumCardColor(),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else if (_originalAmount == 0) {
      await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("金額を入力してください"),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: checkIsPremiumCardColor(),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(
                    color: checkIsPremiumCardColor(),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("決済確認"),
            content: Text("合計金額 : $_calculateAmount yen"),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: checkIsPremiumCardColor(),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(
                    color: checkIsPremiumCardColor(),
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text("OK"),
                onPressed: () async {
                  WidgetUtils().showProgressDialog(context);
                  // firebase datastoreを更新
                  await send();
                  // 初期化処理
                  doInit();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      child: const HomeScreen(),
                    );
                  }), (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  primary: checkIsPremiumCardColor(),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  /// 初期化処理
  void doInit() {
    _uid = "";
    _originalAmount = 0;
    _calculateAmount = 0;
    _points = 0;
    _tickets = 0;
    _selectedTicketsNum = 0;
    _premium = false;
    notifyListeners();
  }
}
