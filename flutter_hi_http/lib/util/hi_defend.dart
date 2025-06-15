import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class HiDefend {
  run(Widget app) {
    // 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      // 线上环境上报
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    runZonedGuarded(() {
      runApp(app);
    }, (e, s) => _reportError(e, s));
  }

  _reportError(Object e, StackTrace s) {
    print('catch error:$e');
  }
}
