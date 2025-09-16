import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 页面状态异常管理
abstract class HiState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print('hiState 页面已销毁，本次setState 不执行：${toString()}');
    }
  }
}
