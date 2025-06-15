import 'package:flutter/material.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/dao/login_dao.dart';
import 'package:flutter_hi_http/navigator/hi_navigator.dart';
import 'package:flutter_hi_http/provider/theme_provider.dart';
import 'package:flutter_hi_http/util/string_util.dart';
import 'package:flutter_hi_http/util/toast.dart';
import 'package:flutter_hi_http/widget/appbar.dart';
import 'package:flutter_hi_http/widget/login_button.dart';
import 'package:flutter_hi_http/widget/login_effect.dart';
import 'package:flutter_hi_http/widget/login_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;

  String userName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("密码登录", "注册", () {
        context.read<ThemeProvider>().setTheme(ThemeMode.dark);
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }),
      body: Container(
        child: ListView(
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
              hint: "请输入用户密码",
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                '登录',
                enable: loginEnable,
                onPressed: () {
                  send();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var request = await LoginDao.login(userName, password);
      // var request = await LoginDao.login(userName, );
      print(request);
      if (request['code'] == 0) {
        print("登录请求");
        // widget.onJumpToLogin();
        showToast("登录成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        print(request['message']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }
}
