import 'package:flutter/material.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/dao/login_dao.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/util/string_util.dart';
import 'package:flutter_hi_http/util/toast.dart';
import 'package:flutter_hi_http/widget/appbar.dart';
import 'package:flutter_hi_http/widget/login_button.dart';
import 'package:flutter_hi_http/widget/login_effect.dart';
import 'package:flutter_hi_http/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;

  String userName = '';
  String password = '';
  String rePassword = '';
  String imoocId = '';
  String orderId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }),
      body: ListView(
        // 自适应键盘
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            title: "用户名",
            hint: "请输入用户名",
            onChanged: (text) {
              userName = text;
              checkInput();
            },
          ),
          LoginInput(
            title: "密码",
            hint: "请输入密码",
            onChanged: (text) {
              print(text);
              password = text;
              checkInput();
            },
            focusChanged: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          LoginInput(
            title: "确认密码",
            hint: "请再次输入密码",
            onChanged: (text) {
              print(text);
              rePassword = text;
              checkInput();
            },
            focusChanged: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          LoginInput(
            title: "慕课网ID",
            hint: "请再次输入慕课网ID",
            onChanged: (text) {
              print(text);
              imoocId = text;
              checkInput();
            },
          ),
          LoginInput(
            title: "慕课网ID",
            hint: "请再次输入慕课网ID",
            keyboardType: TextInputType.number,
            onChanged: (text) {
              print(text);
              imoocId = text;
              checkInput();
            },
          ),
          LoginInput(
            title: "课程订单号",
            hint: "请再次输入课程订单号",
            keyboardType: TextInputType.number,
            lineStretch: true,
            onChanged: (text) {
              print(text);
              orderId = text;
              checkInput();
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: LoginButton(
              "注册",
              enable: loginEnable,
              onPressed: checkParams,
            ),
          ),
        ],
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      child: Text('注册'),
      onTap: () {
        if (loginEnable) {
          checkParams();
        } else {
          print('loginenable is false');
        }
      },
    );
  }

  void send() async {
    try {
      var request = await LoginDao.registration(
        userName,
        password,
        imoocId,
        orderId,
      );
      // var request = await LoginDao.login(userName, );
      print(request);
      if (request['code'] == 0) {
        print("注册成功");
        showToast("注册成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      } else {
        print(request['message']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "两次密码不一致";
    } else if (orderId.length != 4) {
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
