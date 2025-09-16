import 'package:flutter/material.dart';
import 'package:flutter_hi_http/util/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginButton(
    this.title, {
    super.key,
    this.enable = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // 填满父类空间的宽度或者高度
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        onPressed: enable ? onPressed : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        disabledColor: primary[50],
        color: primary,
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
