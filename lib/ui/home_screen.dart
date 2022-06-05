import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motion_cafe/view_model/home_view_model.dart';
import './qr_code_screen.dart';
import '../utils/widget_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("DADADA"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("FC2951"),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QRCodeScreen(),
            ),
          );
        },
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
      body: _paymentWidget(context),
    );
  }

  Widget _paymentWidget(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        SizedBox(
          child: SvgPicture.asset("assets/MotionLogoMain.svg"),
          width: width * 0.2,
          height: height * 0.2,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.2,
          ),
          width: width * 0.8,
          height: height * 0.6,
          decoration: BoxDecoration(
            color: HexColor("FFFFFF"),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.025,
            ),
            width: width * 0.6,
            height: height * 0.6,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width,
                  height: height * 0.184,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: width * 0.15,
                        height: height * 0.2,
                        margin: EdgeInsets.fromLTRB(
                          width * 0.05,
                          height * 0.02,
                          width * 0.01,
                          height * 0.02,
                        ),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/user_id.svg",
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              "USER ID",
                              style: TextStyle(
                                fontSize: width * 0.015,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.2,
                        height: height * 0.2,
                        margin: EdgeInsets.symmetric(
                          vertical: height * 0.02,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Provider.of<HomeViewModel>(context).uid,
                          style: TextStyle(
                            fontSize: width * 0.015,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.183,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: width * 0.15,
                        height: height * 0.2,
                        margin: EdgeInsets.fromLTRB(
                          width * 0.05,
                          height * 0.02,
                          width * 0.01,
                          height * 0.02,
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              child: SvgPicture.asset(
                                "assets/bill.svg",
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              "BILLING",
                              style: TextStyle(
                                fontSize: width * 0.015,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.2,
                        height: height * 0.2,
                        margin: EdgeInsets.symmetric(
                          vertical: height * 0.02,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.15,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: width * 0.03),
                                decoration: InputDecoration(
                                  hintText: "金額を入力してください",
                                  hintStyle: TextStyle(
                                    fontSize: width * 0.01,
                                  ),
                                ),
                                onChanged: (value) {
                                  Provider.of<HomeViewModel>(
                                    context,
                                    listen: false,
                                  ).setOriginalAmount(value.toString());
                                },
                                initialValue:
                                    Provider.of<HomeViewModel>(context)
                                        .originalAmount
                                        .toString(),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.015,
                            ),
                            Text(
                              "yen",
                              style: TextStyle(fontSize: width * 0.015),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.18,
                  decoration: const BoxDecoration(),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: width * 0.35,
                        height: height * 0.18,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: Container(
                          width: width * 0.35,
                          height: height * 0.18,
                          margin: EdgeInsets.fromLTRB(
                            width * 0.05,
                            height * 0.02,
                            width * 0.01,
                            height * 0.02,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/ticket.svg",
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "TICKETS",
                                style: TextStyle(
                                  fontSize: width * 0.015,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              DropdownButton(
                                items: Provider.of<HomeViewModel>(context)
                                    .dropDownButtonList(),
                                onChanged: (value) => {
                                  Provider.of<HomeViewModel>(
                                    context,
                                    listen: false,
                                  ).setSelectedTicketsNum(value.toString())
                                },
                                value: Provider.of<HomeViewModel>(context)
                                    .selectedTicketsNum,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.208,
                        height: height * 0.18,
                        child: Container(
                          padding: EdgeInsets.all(width * 0.042),
                          child: ElevatedButton(
                            child: const Text(
                              "Check out",
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Provider.of<HomeViewModel>(context)
                                  .checkIsPremiumCardColor(),
                              textStyle: TextStyle(
                                fontSize: width * 0.02,
                              ),
                            ),
                            onPressed: () async {
                              Provider.of<HomeViewModel>(
                                context,
                                listen: false,
                              ).calAmount();
                              Provider.of<HomeViewModel>(
                                context,
                                listen: false,
                              ).checkShowDialog(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
