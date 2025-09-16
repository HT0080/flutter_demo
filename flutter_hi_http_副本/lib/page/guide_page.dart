import 'package:flutter/material.dart';
import 'package:flutter_hi_http/http/dao/login_dao.dart';
import 'package:flutter_hi_http/provider/splash_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GuidePage extends ConsumerWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLogin = LoginDao.getBoadingPass() != null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authStatusProvider.notifier).state =
          hasLogin ? AuthStatus.authenticated : AuthStatus.unauthenticated;
      // .updateState(
      //   hasLogin ? AuthStatus.authenticated : AuthStatus.unauthenticated,
      // );
    });

    return Scaffold(
      body: Center(
        child: Icon(Icons.flutter_dash_outlined, color: Colors.blue, size: 50),
      ),
    );
  }
}
