import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motion_cafe/view_model/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: HexColor("DADADA"),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.camera),
        ),
        body: _paymentWidget(context),
      ),
    );
  }

  Widget _paymentWidget(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.2,
        vertical: height * 0.2,
      ),
      width: width * 0.8,
      height: height * 0.8,
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
                        const Icon(Icons.account_circle),
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
                      "shunya.saitama@gmail.com",
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
                        const Icon(
                          Icons.attach_money,
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          "BILL",
                          style: TextStyle(
                            fontSize: width * 0.015,
                          ),
                        ),
                        Text("${Provider.of<HomeViewModel>(context).sum}"),
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
                              Provider.of<HomeViewModel>(context)
                                  .setSum(int.parse(value));
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.015,
                        ),
                        Text(
                          "yen",
                          style: TextStyle(fontSize: width * 0.02),
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
                          const Icon(
                            Icons.credit_card_outlined,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          const Text(
                            "TICKETS",
                          ),
                          SizedBox(
                            width: width * 0.08,
                          ),
                          // Providerを使って状態管理をしたい
                          DropdownButton(
                            items: const [
                              DropdownMenuItem(
                                child: Text("1"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("2"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("3"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("4"),
                                value: 4,
                              ),
                            ],
                            onChanged: (_) {},
                            value: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.208,
                    height: height * 0.18,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: SvgPicture.asset(
                        "assets/MotionLogoMain.svg",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
