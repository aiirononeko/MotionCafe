import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:motion_cafe/service/hex_color.dart';
import 'package:motion_cafe/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../utils/widget_utils.dart';

class QRCodeScreen extends StatelessWidget {
  QRCodeScreen({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor("FC2951"),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios)),
      body: Container(
        child: _buildQrView(context),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    double scanArea = MediaQuery.of(context).size.width * 0.5;
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) {
        Provider.of<HomeViewModel>(
          context,
          listen: false,
        ).setController(controller);
        controller.scannedDataStream.listen((scanData) {
          WidgetUtils().showProgressDialog(context);
          Provider.of<HomeViewModel>(
            context,
            listen: false,
          ).setUidAndTickets(scanData);
          Navigator.popUntil(context, (route) => route.isFirst);
        });
      },
      overlay: QrScannerOverlayShape(
          borderColor: Colors.cyan,
          borderRadius: 5,
          borderLength: 10,
          borderWidth: 5,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
