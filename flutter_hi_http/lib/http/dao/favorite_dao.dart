import 'package:flutter_hi_http/http/core/hi_net.dart';
import 'package:flutter_hi_http/http/request/base_request.dart';
import 'package:flutter_hi_http/http/request/cancel_favorite_request.dart';
import 'package:flutter_hi_http/http/request/favorite_list_request.dart';
import 'package:flutter_hi_http/http/request/favorite_request.dart';
import 'package:flutter_hi_http/model/ranking_mo.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    BaseRequest request =
        favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }

  static favoriteList({int pageIndex = 1, int pageSize = 10}) async {
    FavoriteListRequest request = FavoriteListRequest();
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return RankingMo.fromJson(result['data']);
  }
}
