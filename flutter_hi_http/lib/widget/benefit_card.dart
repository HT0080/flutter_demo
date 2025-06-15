import 'package:flutter/material.dart';
import 'package:flutter_hi_http/model/profile_mo.dart';
import 'package:flutter_hi_http/util/view_util.dart';
import 'package:flutter_hi_http/widget/hi_blur.dart';

class BenefitCart extends StatelessWidget {
  final List<Benefit>? benefitList;

  const BenefitCart({super.key, required this.benefitList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [_buildTitle(), hiSpace(height: 10), _buildBenefit(context)],
      ),
    );
  }

  _buildTitle() {
    return Container(
      child: Row(
        children: [
          Text(
            '增值服务',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            '购买后登录慕课网再次点击打开',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // _buildCardList(BuildContext context) {
  //   var courseGroup = Map();
  //   courseList?.forEach((mo) {
  //     if (!courseGroup.containsKey(mo.group)) {
  //       courseGroup[mo.group] = [];
  //     }
  //     List list = courseGroup[mo.group];
  //     list.add(mo);
  //   });

  //   return courseGroup.entries.map((e) {
  //     List list = e.value;
  //     var width =
  //         (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
  //         list.length;
  //     var height = width / 16 * 6;
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [...list.map((mo) => _buildCard(mo, width, height)).toSet()],
  //     );
  //   });
  // }

  _buildCard(BuildContext context, Benefit mo, double width) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60,
            decoration: BoxDecoration(color: Colors.deepOrangeAccent),
            child: Stack(
              children: [
                Positioned.fill(child: HiBlur()),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      mo.name,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBenefit(BuildContext context) {
    var width =
        (MediaQuery.of(context).size.width -
            20 -
            (benefitList!.length - 1) * 5) /
        benefitList!.length;
    return Row(
      children: [
        ...benefitList!.map((e) => _buildCard(context, e, width)).toSet(),
      ],
    );
  }
}
