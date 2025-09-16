import 'dart:convert';

import 'package:flutter_hi_http/http/core/hi_net_adapter.dart';
import 'package:flutter_hi_http/http/request/base_request.dart';

/// 测试适配器，mock数据

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    print(request.path());
    return Future<HiNetResponse<T>>.delayed(Duration(milliseconds: 1000), () {
      if (request.path().contains('/uapi/user/registration')) {
        // 注册
        return HiNetResponse<T>(
          data: {"code": 0, "message": 'success'} as T,
          statusCode: 200,
        );
      } else if (request.path().contains('/uapi/user/login')) {
        // 登录
        return HiNetResponse<T>(
          data:
              {
                    "code": 0,
                    "message": 'login success',
                    "data": "bd56cd46adfalfjdlasfflkdaslfa",
                  }
                  as T,
          statusCode: 200,
        );
      } else if (request.path().contains('/uapi/notice')) {
        // 通知
        Map<String, dynamic> noticeMap = {
          "total": 6,
          "list": [
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
          ],
        };
        return HiNetResponse<T>(
          data: {"code": 0, "message": 'login success', "data": noticeMap} as T,
          statusCode: 200,
        );
      } else if (request.path().contains('uapi/fa/home/')) {
        Map<String, dynamic> list = {
          'bannerList': [
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
            {
              "id": '9',
              "sticky": 1,
              "type": "好课推荐",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
          ],
          "categoryList": [
            {"name": "推荐", "count": 933},
            {"name": "搞笑", "count": 178},
            {"name": "日常", "count": 152},
            {"name": "综合", "count": 95},
            {"name": "鬼畜调教", "count": 42},
            {"name": "MAD-AMV", "count": 39},
            {"name": "手机游戏", "count": 38},
            {"name": "单机游戏", "count": 36},
            {"name": "短片.手记.配音", "count": 42},
            {"name": "动物圈", "count": 42},
            {"name": "美食评测", "count": 42},
          ],
          "videoList": [
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title":
                  "用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc":
                  "视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
          ],
          "msg": "SUCCESS.",
        };
        return HiNetResponse<T>(
          data: {"code": 0, "message": '推荐数据', "data": list} as T,
          statusCode: 200,
        );
      } else if (request.path().contains('uapi/fa/detail/')) {
        Map<String, dynamic> list = {
          "isFavorite": true,
          "isLike": true,
          "videoInfo": {
            "id": '4081',
            "vid": "BN1LW41177e",
            "title": "用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密",
            "tname": "综合",
            "url":
                "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
            "cover":
                "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
            "pubdate": 1519107354,
            "desc":
                "视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈视频类型: 动漫杂谈",
            "view": 664244,
            "duration": 145,
            "owner": {
              "name": "瓶子君152",
              "face":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "fans": 0,
            },
            "reply": 4283,
            "favorite": 7151,
            "like": 20029,
            "coin": 31395,
            "share": 975,
            "createTime": "2020-11-14 21:29:12",
            "size": 8161,
          },
          "videoList": [
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title":
                  "用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc":
                  "视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
          ],
          "msg": "SUCCESS.",
        };
        return HiNetResponse<T>(
          data: {"code": 0, "message": '详情', "data": list} as T,
          statusCode: 200,
        );
      } else if (request.path().contains('uapi/fa/favorite')) {
        if (request.path().contains('uapi/fa/favorites')) {
          Map<String, dynamic> list = {
            "total": 7,
            "list": [
              {
                "id": '4081',
                "vid": "BN1LW41177e",
                "title":
                    "用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密",
                "tname": "综合",
                "url":
                    "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
                "cover":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "pubdate": 1519107354,
                "desc":
                    "视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈视频类型: 动漫杂谈",
                "view": 664244,
                "duration": 145,
                "owner": {
                  "name": "瓶子君152",
                  "face":
                      "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                  "fans": 0,
                },
                "reply": 4283,
                "favorite": 7151,
                "like": 20029,
                "coin": 31395,
                "share": 975,
                "createTime": "2020-11-14 21:29:12",
                "size": 8161,
              },
              {
                "id": '4081',
                "vid": "BN1LW41177e",
                "title": "用爱发电背后不为人知的秘密",
                "tname": "综合",
                "url":
                    "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
                "cover":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "pubdate": 1519107354,
                "desc": "视频类型: 动漫杂谈",
                "view": 664244,
                "duration": 145,
                "owner": {
                  "name": "瓶子君152",
                  "face":
                      "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                  "fans": 0,
                },
                "reply": 4283,
                "favorite": 7151,
                "like": 20029,
                "coin": 31395,
                "share": 975,
                "createTime": "2020-11-14 21:29:12",
                "size": 8161,
              },
              {
                "id": '4081',
                "vid": "BN1LW41177e",
                "title": "用爱发电背后不为人知的秘密",
                "tname": "综合",
                "url":
                    "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
                "cover":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "pubdate": 1519107354,
                "desc": "视频类型: 动漫杂谈",
                "view": 664244,
                "duration": 145,
                "owner": {
                  "name": "瓶子君152",
                  "face":
                      "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                  "fans": 0,
                },
                "reply": 4283,
                "favorite": 7151,
                "like": 20029,
                "coin": 31395,
                "share": 975,
                "createTime": "2020-11-14 21:29:12",
                "size": 8161,
              },
              {
                "id": '4081',
                "vid": "BN1LW41177e",
                "title": "用爱发电背后不为人知的秘密",
                "tname": "综合",
                "url":
                    "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
                "cover":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "pubdate": 1519107354,
                "desc": "视频类型: 动漫杂谈",
                "view": 664244,
                "duration": 145,
                "owner": {
                  "name": "瓶子君152",
                  "face":
                      "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                  "fans": 0,
                },
                "reply": 4283,
                "favorite": 7151,
                "like": 20029,
                "coin": 31395,
                "share": 975,
                "createTime": "2020-11-14 21:29:12",
                "size": 8161,
              },
              {
                "id": '4081',
                "vid": "BN1LW41177e",
                "title": "用爱发电背后不为人知的秘密",
                "tname": "综合",
                "url":
                    "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
                "cover":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "pubdate": 1519107354,
                "desc": "视频类型: 动漫杂谈",
                "view": 664244,
                "duration": 145,
                "owner": {
                  "name": "瓶子君152",
                  "face":
                      "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                  "fans": 0,
                },
                "reply": 4283,
                "favorite": 7151,
                "like": 20029,
                "coin": 31395,
                "share": 975,
                "createTime": "2020-11-14 21:29:12",
                "size": 8161,
              },
              {
                "id": '4081',
                "vid": "BN1LW41177e",
                "title": "用爱发电背后不为人知的秘密",
                "tname": "综合",
                "url":
                    "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
                "cover":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "pubdate": 1519107354,
                "desc": "视频类型: 动漫杂谈",
                "view": 664244,
                "duration": 145,
                "owner": {
                  "name": "瓶子君152",
                  "face":
                      "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                  "fans": 0,
                },
                "reply": 4283,
                "favorite": 7151,
                "like": 20029,
                "coin": 31395,
                "share": 975,
                "createTime": "2020-11-14 21:29:12",
                "size": 8161,
              },
              {
                "id": '4081',
                "vid": "BN1LW41177e",
                "title": "用爱发电背后不为人知的秘密",
                "tname": "综合",
                "url":
                    "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
                "cover":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "pubdate": 1519107354,
                "desc": "视频类型: 动漫杂谈",
                "view": 664244,
                "duration": 145,
                "owner": {
                  "name": "瓶子君152",
                  "face":
                      "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                  "fans": 0,
                },
                "reply": 4283,
                "favorite": 7151,
                "like": 20029,
                "coin": 31395,
                "share": 975,
                "createTime": "2020-11-14 21:29:12",
                "size": 8161,
              },
            ],
          };
          return HiNetResponse<T>(
            data: {"code": 0, "message": '成功', "data": list} as T,
            statusCode: 200,
          );
        }

        return HiNetResponse<T>(
          data: {"code": 0, "message": '成功', "data": null} as T,
          statusCode: 200,
        );
      } else if (request.path().contains('uapi/fa/ranking')) {
        Map<String, dynamic> list = {
          "total": 7,
          "list": [
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title":
                  "用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密,用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc":
                  "视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈，视频类型: 动漫杂谈视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
            {
              "id": '4081',
              "vid": "BN1LW41177e",
              "title": "用爱发电背后不为人知的秘密",
              "tname": "综合",
              "url":
                  "http://1257289155.vod2.myqcloud.com/5d900c2cvodgzp1257289155/140208f9243791577159323097/2PXrKaApt0YA.mp4",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "pubdate": 1519107354,
              "desc": "视频类型: 动漫杂谈",
              "view": 664244,
              "duration": 145,
              "owner": {
                "name": "瓶子君152",
                "face":
                    "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
                "fans": 0,
              },
              "reply": 4283,
              "favorite": 7151,
              "like": 20029,
              "coin": 31395,
              "share": 975,
              "createTime": "2020-11-14 21:29:12",
              "size": 8161,
            },
          ],
        };
        return HiNetResponse<T>(
          data: {"code": 0, "message": '成功', "data": list} as T,
          statusCode: 200,
        );
      } else if (request.path().contains("uapi/fa/profile")) {
        Map<String, dynamic> list = {
          "name": "小黄大前端",
          "face":
              "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
          "fans": 20,
          "favorite": 20,
          "like": 20,
          "coin": 30,
          "browsing": 40,
          "bannerList": [
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
            {
              "id": '9',
              "sticky": 1,
              "type": "video",
              "subTitle": "移动端普通工程师架构师全方位蜕变",
              "url": "http://class.imooc.com/sale/mobilearchitect",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "createTime": "2020-12-03 16:39:24",
              "title": "测试1",
              "subtitle": "测试2",
            },
          ],
          "courseList": [
            {
              "name": "课程一",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "url":
                  'http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png',
              "group": 1,
            },
            {
              "name": "课程一",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "url":
                  'http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png',
              "group": 1,
            },
            {
              "name": "课程一",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "url":
                  'http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png',
              "group": 2,
            },
            {
              "name": "课程一",
              "cover":
                  "http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png",
              "url":
                  'http://class.imooc.com/static/module/marketpage2020/img/intro/studyservice4.png',
              "group": 2,
            },
          ],
          "benefitList": [
            {"name": "测试课程", "url": 'www.baidu.com'},
            {"name": "测试课程", "url": 'www.baidu.com'},
            {"name": "测试课程", "url": 'www.baidu.com'},
            {"name": "测试课程", "url": 'www.baidu.com'},
          ],
        };

        return HiNetResponse<T>(
          data: {"code": 0, "message": '成功', "data": list} as T,
          statusCode: 200,
        );
      }

      return HiNetResponse<T>(
        data: {"code": 0, "message": 'success'} as T,
        statusCode: 403,
      );
    });
  }
}
