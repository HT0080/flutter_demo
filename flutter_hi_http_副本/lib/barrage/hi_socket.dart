import 'package:flutter/material.dart';
import 'package:flutter_hi_http/model/barrage_model.dart';

class HiSocket implements ISocket {
  @override
  void close() {
    // TODO: implement close
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callback) {
    // TODO: implement listen
    throw UnimplementedError();
  }

  @override
  ISocket open(String vid) {
    // TODO: implement open
    throw UnimplementedError();
  }

  @override
  ISocket send(String message) {
    // TODO: implement send
    throw UnimplementedError();
  }
}

abstract class ISocket {
  // 和服务器建立连接
  ISocket open(String vid);
  //发送弹幕
  ISocket send(String message);

  /// 关闭连接
  void close();

  /// 接收弹幕
  ISocket listen(ValueChanged<List<BarrageModel>> callback);
}
