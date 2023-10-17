import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_estate_app/app/network/provider/stream_chat_provider.dart';
import 'package:real_estate_app/core/dependency_injection.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/apartment_detail.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/bloc/home_bloc.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/filter_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/models/apart_model.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/button_list.dart';
import 'package:real_estate_app/shared/widgets/one_liner_text_field.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttonList = [
    '3 Guest',
    'Apartment',
    'Wifi',
    'Restaurant',
    'Bathtub'
  ];

  late List<ApartModel> apartList;
  late List<ApartModel> offersList;
  late StreamChannelListController controller;

  @override
  void initState() {
    context.read<HomeBloc>().add(
          HomeRequestedAparts(),
        );

    final chatProvider = sl.get<StreamChatProvider>();
    // controller = StreamChannelListController(client: chatProvider.client);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  _buildAppBar() {
    final appBarTheme = Theme.of(context).appBarTheme;
    return AppBar(
      toolbarHeight: appBarTheme.toolbarHeight! - 16,
      flexibleSpace: Transform.translate(
        offset: const Offset(0, 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: ColorConstants.kPrimary,
                  child: IconButton(
                    alignment: Alignment.center,
                    iconSize: 28,
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      foregroundColor: ColorConstants.kPrimary800,
                      fixedSize: const Size.fromHeight(48),
                      shape: const RoundedRectangleBorder(),
                    ),
                    color: ColorConstants.kPrimary400,
                    hoverColor: ColorConstants.kPrimary600,
                    onPressed: () {
                      Navigator.of(context).pushNamed(FilterPage.path);
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: ColorConstants.kWhite,
                    ),
                  ),
                ),
              ),
              hSpaceRegular,
              Expanded(
                child: OneLinerTextField(
                  affinity: ControlAffinity.leading,
                  needValidation: false,
                  hintText: 'Search via City',
                  onChanged: (p0) {},
                ),
              )
            ],
          ),
        ),
      ),
      primary: false,
      titleTextStyle: appBarTheme.titleTextStyle,
      backgroundColor: ColorConstants.kWhite,
      elevation: appBarTheme.elevation,
    );
  }

  _buildBody() {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: context.read<HomeBloc>(),
      listener: (context, state) async {
        if (state is HomeInitial) {
          debugPrint('masukk');
          context.read<HomeBloc>().add(
                HomeRequestedAparts(),
              );
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeCompletedState) {
          apartList = state.apartList;
          offersList = state.offersList;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildChipList(),
                    vSpaceRegular,
                    _buildApartList(),
                    _buildOtherOffers()
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildApartList() {
    final textTheme = Theme.of(context).textTheme;
    final cardResponsiveHeight =
        screenHeightPercentage(context, percentage: .35);
    final imageResponsiveHeight =
        screenHeightPercentage(context, percentage: .24);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemExtent: cardResponsiveHeight,
      itemBuilder: (context, index) {
        final obj = apartList[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ApartmentDetailPage.path,
            );
          },
          child: Card(
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
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -3),
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
          ),
        );
      },
      itemCount: apartList.length,
    );
  }

  _buildChipList() {
    return ButtonList(
      buttonList: buttonList,
      onChanged: (p0) {
        debugPrint('masukk');
      },
    );
  }

  _buildOtherOffers() {
    final textTheme = Theme.of(context).textTheme;
    final cardResponsiveWidth = screenWidthPercentage(context, percentage: .8);
    final imageResponsiveHeight =
        screenHeightPercentage(context, percentage: .24);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other offers',
          style: textTheme.headlineMedium,
        ),
        vSpaceSmall,
        SizedBox(
          height: 260,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemExtent: cardResponsiveWidth,
            itemBuilder: (context, index) {
              final obj = offersList[index];
              return Card(
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                semanticContainer: true,
                color: Colors.transparent,
                elevation: 0.0,
                margin: const EdgeInsets.only(bottom: 16, right: 16),
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
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -3),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                shape: const BeveledRectangleBorder(),
                                label: Text(
                                  obj.offerDetail,
                                  style: textTheme.displayMedium!.copyWith(
                                      height: 1.3,
                                      fontSize: 15,
                                      color: ColorConstants.kWhite),
                                ),
                                backgroundColor: ColorConstants.kError,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      obj.apartName,
                                      style: textTheme.headlineMedium!.copyWith(
                                          height: 1.3,
                                          color: ColorConstants.kWhite),
                                    ),
                                  ],
                                ),
                                Transform.translate(
                                  offset: const Offset(0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/location_white.svg',
                                        height: 18,
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                      ),
                                      hSpaceTiny,
                                      Text(
                                        obj.location,
                                        style: textTheme.displayMedium!
                                            .copyWith(
                                                color: ColorConstants.kWhite,
                                                fontSize: 15,
                                                height: 1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: offersList.length,
          ),
        ),
      ],
    );
  }
}
