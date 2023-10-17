import 'package:flutter/material.dart';

class SliverTabBar extends SliverPersistentHeaderDelegate {
  SliverTabBar(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverTabBar oldDelegate) {
    return false;
  }
}
