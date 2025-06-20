import 'package:flutter/material.dart';
import 'package:flutter_hi_http/model/profile_mo.dart';
import 'package:flutter_hi_http/util/view_util.dart';

class CourseCard extends StatelessWidget {
  final List<Course>? courseList;

  const CourseCard({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          hiSpace(height: 10),
          ..._buildCardList(context),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      child: Row(
        children: [
          Text(
            '职场进阶',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            '带你突破技术瓶颈',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  _buildCardList(BuildContext context) {
    var courseGroup = Map();
    courseList?.forEach((mo) {
      if (!courseGroup.containsKey(mo.group)) {
        courseGroup[mo.group] = [];
      }
      List list = courseGroup[mo.group];
      list.add(mo);
    });

    return courseGroup.entries.map((e) {
      List list = e.value;
      var width =
          (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
          list.length;
      var height = width / 16 * 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...list.map((mo) => _buildCard(mo, width, height)).toSet()],
      );
    });
  }

  _buildCard(Course mo, double width, double height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: cachedImage(mo.cover, height: height, width: width),
        ),
      ),
    );
  }
}
