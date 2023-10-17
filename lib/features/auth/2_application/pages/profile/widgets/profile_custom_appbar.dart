import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';

class ProfileCustomAppbar extends SliverPersistentHeaderDelegate {
  final bool isProfile;

  ProfileCustomAppbar({required this.isProfile});
  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomLeft,
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/profile_bg.png', fit: BoxFit.cover),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.topLeft,
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(
                horizontal: 32, vertical: kToolbarHeight / 2),
            child: IconTheme(
              data: theme.iconTheme,
              child: isProfile
                  ? InkWell(
                      onTap: () {},
                      child: Material(
                        shape: const CircleBorder(side: BorderSide.none),
                        elevation: 10.0,
                        child: CircleAvatar(
                          backgroundColor: ColorConstants.kPrimary,
                          radius: 2,
                          child: const Icon(
                            Icons.create,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: Material(
                        shape: const CircleBorder(side: BorderSide.none),
                        elevation: 10.0,
                        child: CircleAvatar(
                          backgroundColor: ColorConstants.kPrimary,
                          radius: 2,
                          child: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                      )),
            ),
          ),
        ),
        Positioned.fill(
          child: Transform.translate(
            offset: const Offset(0, kToolbarHeight),
            child: Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    alignment: Alignment.center,
                    scale: 1.0,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/avatars/Avatar-1.png'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
