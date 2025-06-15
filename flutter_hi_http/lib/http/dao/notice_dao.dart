import 'package:flutter_hi_http/http/core/hi_net.dart';
import 'package:flutter_hi_http/http/request/notice_request.dart';
import 'package:flutter_hi_http/model/notice_mo.dart';

class NoticeDao {
  static noticeList({int pageIndex = 1, int pageSize = 10}) async {
    NoticeRequest request = NoticeRequest();
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    return NoticeMo.fromJson(result['data']);
  }
}
