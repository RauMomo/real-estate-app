import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/book_apartment/book_apartment_page.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';
import 'package:real_estate_app/shared/widgets/button_list.dart';
import 'package:real_estate_app/shared/widgets/single_rating.dart';

class ApartmentDetailPage extends StatefulWidget {
  const ApartmentDetailPage({Key? key}) : super(key: key);
  static const String path = '/apartment-detail';

  @override
  State<ApartmentDetailPage> createState() => _ApartmentDetailPageState();
}

class _ApartmentDetailPageState extends State<ApartmentDetailPage> {
  final List<Widget> items = [
    ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(48.0),
        bottomRight: Radius.circular(48.0),
      ),
      child: AspectRatio(
        aspectRatio: 1.12,
        child: Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
          scale: 2,
        ),
      ),
    ),
    ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(48.0),
        bottomRight: Radius.circular(48.0),
      ),
      child: AspectRatio(
        aspectRatio: 1.12,
        child: Image.asset(
          'assets/images/img.png',
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
          scale: 2,
        ),
      ),
    ),
    ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(48.0),
        bottomRight: Radius.circular(48.0),
      ),
      child: AspectRatio(
        aspectRatio: 1.12,
        child: Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
          scale: 2,
        ),
      ),
    ),
    ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(48.0),
        bottomRight: Radius.circular(48.0),
      ),
      child: AspectRatio(
        aspectRatio: 1.1,
        child: Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
        ),
      ),
    ),
  ];

  late var initialPage;

  @override
  void initState() {
    super.initState();
    initialPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    var height = screenHeightPercentage(context, percentage: 0.55);
    var textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    items: items,
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            initialPage = index;
                          });
                        },
                        aspectRatio: 1.1,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        initialPage: initialPage,
                        padEnds: false,
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                        animateToClosest: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale),
                  ),
                  Transform.translate(
                    offset: Offset(0, height - 110),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: items.map(
                        (image) {
                          //these two lines
                          int index = items.indexOf(image); //are changed
                          return Container(
                            width: 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 6.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: initialPage == index
                                    ? Colors.white24
                                    : Colors.white),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: screenWidth(context),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Luxury Apartments',
                                  style: textTheme.headlineLarge),
                              const SingleRating(rating: 4, size: 30),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorConstants.kPrimary,
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.person),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildSpecification(),
                    _buildDescription(),
                    _buildAboutThisSpace(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: _buildPurchaseButton(),
        )
      ],
    );
  }

  _buildSpecification() {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specifications',
            style: textTheme.headlineMedium,
          ),
          vSpaceSmall,
          ButtonList(
            buttonList: const [
              '3 Bathrooms',
              'Wi-Fi',
              'Twin Bed',
              'Swimming Pool'
            ],
            onChanged: (p0) {},
          )
        ],
      ),
    );
  }

  _buildDescription() {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: textTheme.headlineMedium,
          ),
          vSpaceSmall,
          Text(
            'Nullam hendrerit lectus non pretium fermentum. Donec faucibus sodales ante, nec finibus quam lacinia sit amet. Nunc ut posuere erat. Proin convallis odio elementum sem vestibulum',
            style: textTheme.displayMedium!.copyWith(
              color: ColorConstants.kDark600,
            ),
          ),
        ],
      ),
    );
  }

  _buildAboutThisSpace() {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This Space',
            style: textTheme.headlineMedium,
          ),
          vSpaceSmall,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidthPercentage(context, percentage: .7),
                    minWidth: 200,
                  ),
                  child: Card(
                    color: ColorConstants.kLightGrey200,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mr. Adi',
                            style: textTheme.headlineMedium,
                          ),
                          vSpaceRegular,
                          const Text(
                              'Nullam hendrerit lectus non pretium fermentum. Donec faucibus sodales ante, nec finibus quam lacinia sit amet. Nunc ut posuere erat. Proin convallis odio elementum sem vestibulum'),
                        ],
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidthPercentage(context, percentage: .7),
                    minWidth: 200,
                  ),
                  child: Card(
                    color: ColorConstants.kLightGrey200,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mr. Roberto Gallardo',
                            style: textTheme.headlineMedium,
                          ),
                          vSpaceRegular,
                          const Text(
                              'Nullam hendrerit lectus non pretium fermentum. Donec faucibus sodales ante, nec finibus quam lacinia sit amet. Nunc ut posuere erat. Proin convallis odio elementum sem vestibulum'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          vSpaceLarge,
          vSpaceLarge,
        ],
      ),
    );
  }

  _buildPurchaseButton() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
      ),
      height: screenHeightPercentage(context, percentage: .125),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '\u0024150',
                  style: textTheme.headlineLarge!.copyWith(height: 2.25),
                ),
                TextSpan(
                  text: '/night',
                  style: textTheme.titleMedium!.copyWith(height: 2.25),
                ),
              ],
            ),
          ),
          Center(
            child: AddButton(
              type: ButtonType.fill,
              isFullWidth: false,
              buttonText: 'Booking',
              onPressed: () {
                Navigator.of(context).pushNamed(BookApartmentPage.path);
              },
              heightSize: screenHeightPercentage(context, percentage: .06),
              widthSize: screenWidthPercentage(context, percentage: .33),
            ),
          )
        ],
      ),
    );
  }
}
