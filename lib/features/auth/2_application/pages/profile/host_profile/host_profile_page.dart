import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/models/apart_model.dart';
import 'package:real_estate_app/features/auth/2_application/pages/profile/models/profile_data.dart';
import 'package:real_estate_app/features/auth/2_application/pages/profile/review/review_page.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';

import '../widgets/profile_custom_appbar.dart';

class HostProfilePage extends StatefulWidget {
  const HostProfilePage({Key? key}) : super(key: key);

  static const String path = '/host-profile';

  @override
  State<HostProfilePage> createState() => _HostProfilePageState();
}

class _HostProfilePageState extends State<HostProfilePage>
    with SingleTickerProviderStateMixin {
  late ProfileData hostProfile;
  late PageController pageCtrl;
  late List<String> pageChoices;
  late int currPage;

  final List<ApartModel> apartList = [
    // const ApartModel(
    //     apartName: 'Suny Apartment',
    //     isLiked: false,
    //     fullAddress: 'Jalan Conch',
    //     location: 'Los Angeles',
    //     pricePerDay: 233,
    //     rating: 9.1,
    //     targetedMiles: 2.7),
    // const ApartModel(
    //     apartName: 'Cloudy Apartment',
    //     isLiked: false,
    //     fullAddress: 'Jalan Coral',
    //     location: 'Arizona',
    //     pricePerDay: 187,
    //     rating: 7.2,
    //     targetedMiles: 3.3),
    // const ApartModel(
    //     apartName: 'Rainy Apartment',
    //     isLiked: true,
    //     fullAddress: 'Jalan Muster',
    //     location: 'Washington',
    //     pricePerDay: 365,
    //     rating: 9.5,
    //     targetedMiles: 0.8),
    // const ApartModel(
    //     apartName: 'Fine Apartment',
    //     isLiked: false,
    //     fullAddress: 'Jalan Raino',
    //     location: 'Talladega',
    //     pricePerDay: 153,
    //     rating: 8.7,
    //     targetedMiles: 4.4)
  ];

  @override
  void initState() {
    currPage = 0;

    hostProfile = const ProfileData(
        name: 'Jack Nicholson',
        location: 'Los Angeles',
        description:
            'I am a Jack and I have 6 apartments for rent short and long term, I invite tenants who appreciate the convenience of use and nice aesthetic interiors');
    pageCtrl = PageController(initialPage: currPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      primary: true,
      toolbarHeight: 0,
      elevation: 0,
    );
  }

  _buildBody() {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        NestedScrollView(
          floatHeaderSlivers: true,
          body: _buildBodyContent(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                delegate: ProfileCustomAppbar(isProfile: false),
                pinned: false,
                floating: true,
              )
            ];
          },
        ),
      ],
    );
  }

  _buildBodyContent() {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hostProfile.name,
            style: textTheme.headlineLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svg/location.svg',
                height: 18,
                alignment: AlignmentDirectional.bottomCenter,
              ),
              hSpaceTiny,
              Text(
                hostProfile.location,
                style: textTheme.displayMedium!.copyWith(
                    color: ColorConstants.kGrey, fontSize: 15, height: 1.5),
              ),
            ],
          ),
          vSpaceSmall,
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(Icons.star, color: Colors.yellow.shade700),
                ),
              ),
              hSpaceSmall,
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ReviewPage.path);
                },
                child: Text(
                  '433 Reviews',
                  style: textTheme.displayMedium!.copyWith(
                    color: ColorConstants.kGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          vSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.messenger_outline_sharp,
                color: ColorConstants.kGrey,
              ),
              hSpaceSmall,
              Text(
                'Speaks in Deutsch, English, Russian',
                style: textTheme.displayMedium!
                    .copyWith(height: 1.25, color: ColorConstants.kGrey),
              ),
            ],
          ),
          Divider(
            endIndent: screenWidthPercentage(context, percentage: .7),
            height: screenHeightPercentage(context, percentage: .05),
            thickness: 1.2,
          ),
          Text(
            hostProfile.description,
            style:
                textTheme.displayMedium!.copyWith(color: ColorConstants.kGrey),
          ),
          vSpaceMedium,
          Text(
            'My apartments for rent',
            style: textTheme.headlineMedium,
          ),
          vSpaceRegular,
          Expanded(
            child: _buildRentHistory(),
          )
        ],
      ),
    );
  }

  _buildRentHistory() {
    final textTheme = Theme.of(context).textTheme;
    final cardResponsiveHeight =
        screenHeightPercentage(context, percentage: .31);
    final imageResponsiveHeight =
        screenHeightPercentage(context, percentage: .2);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemExtent: cardResponsiveHeight,
      itemBuilder: (context, index) {
        final obj = apartList[index];
        return Card(
          color: Colors.transparent,
          elevation: 0.0,
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: screenWidth(context),
                height: imageResponsiveHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(obj.image),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Icon(
                        Icons.favorite,
                        color: ColorConstants.kError800,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Transform.translate(
                        offset: const Offset(0, -8.0),
                        child: Chip(
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -3),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: const BeveledRectangleBorder(),
                          label: Text(
                            '${obj.targetedMiles} miles',
                            style: textTheme.displayMedium!.copyWith(
                                height: 1.3,
                                fontSize: 15,
                                color: ColorConstants.kWhite),
                          ),
                          backgroundColor: ColorConstants.kError,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    obj.apartName,
                    style: textTheme.headlineMedium!.copyWith(
                      height: 1.3,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: obj.currency,
                          style: textTheme.headlineMedium!.copyWith(
                              height: 1.3, color: ColorConstants.kPrimary),
                        ),
                        TextSpan(
                          text: '${obj.pricePerDay}',
                          style: textTheme.headlineMedium!.copyWith(
                              height: 1.3, color: ColorConstants.kPrimary),
                        ),
                        TextSpan(
                          text: ' /per day',
                          style: textTheme.displayMedium!.copyWith(
                            height: 1.3,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/location.svg',
                      height: 18,
                      alignment: AlignmentDirectional.bottomCenter,
                    ),
                    hSpaceTiny,
                    Text(
                      obj.location,
                      style: textTheme.displayMedium!.copyWith(
                          color: ColorConstants.kGrey,
                          fontSize: 15,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: apartList.length,
    );
  }

  _buildSettings() {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          tileColor: ColorConstants.kLightGrey,
          title: Text(
            'Account',
            style: theme.textTheme.bodyLarge,
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
          ),
          trailing: IconTheme(
            data: theme.iconTheme,
            child: Container(
              padding: const EdgeInsets.all(4),
              // margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: ColorConstants.kPrimary, shape: BoxShape.circle),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ),
        ),
        vSpaceRegular,
        ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          tileColor: ColorConstants.kLightGrey,
          title: Text(
            'Payment Settings',
            style: theme.textTheme.bodyLarge,
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.credit_card,
              color: Colors.black,
            ),
          ),
          trailing: IconTheme(
            data: theme.iconTheme,
            child: Container(
              padding: const EdgeInsets.all(4),
              // margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: ColorConstants.kPrimary, shape: BoxShape.circle),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ),
        ),
        vSpaceRegular,
        ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          tileColor: ColorConstants.kLightGrey,
          title: Text(
            'Notifications',
            style: theme.textTheme.bodyLarge,
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
          ),
          trailing: IconTheme(
            data: theme.iconTheme,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: ColorConstants.kPrimary, shape: BoxShape.circle),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
