import 'package:flutter/material.dart';

import '../service/hex_color.dart';

class WidgetUtils {
  /// 全画面プログレスダイアログを表示する
  void showProgressDialog(context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration.zero, // これを入れると遅延を入れなくて
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: CircularProgressIndicator(color: HexColor("FC2951")),
        );
      },
    );
  }
}
