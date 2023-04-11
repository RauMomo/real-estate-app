import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/payment_process/payment_process_page.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';

import 'widgets/apartment_date_range_widget.dart';

class BookApartmentPage extends StatefulWidget {
  const BookApartmentPage({Key? key}) : super(key: key);

  static const String path = '/book-apartment';

  @override
  State<BookApartmentPage> createState() => BookApartmentPageeState();
}

class BookApartmentPageeState extends State<BookApartmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    final appBarTheme = Theme.of(context).appBarTheme;
    var toolbarHeightSize = screenHeightPercentage(context, percentage: 0.12);
    return AppBar(
      toolbarHeight: toolbarHeightSize,
      leading: Transform.translate(
        offset: Offset(16, toolbarHeightSize / 4),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: ColorConstants.kPrimary,
            child: IconButton(
              alignment: Alignment.center,
              iconSize: 20,
              style: IconButton.styleFrom(
                foregroundColor: ColorConstants.kPrimary800,
                fixedSize: const Size.fromHeight(48),
                shape: const RoundedRectangleBorder(),
              ),
              color: ColorConstants.kPrimary400,
              hoverColor: ColorConstants.kPrimary600,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: ColorConstants.kWhite,
              ),
            ),
          ),
        ),
      ),
      title: Transform.translate(
        offset: Offset(0, toolbarHeightSize / 4),
        child: Text(
          'Summary'.toUpperCase(),
        ),
      ),
      automaticallyImplyLeading: true,
      centerTitle: true,
      primary: false,
      titleTextStyle:
          appBarTheme.titleTextStyle!.copyWith(fontSize: 14, height: 1.0),
      backgroundColor: ColorConstants.kWhite,
      elevation: appBarTheme.elevation,
    );
  }

  _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '15 nights in Perfect Room',
              style: textTheme.headlineMedium!.copyWith(fontSize: 18),
            ),
            _buildCheckInDetails(),
            _buildFeeTaxDetails(),
            vSpaceRegular,
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  _buildCheckInDetails() {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        ApartmentDateRangeWidget(
          startDate: DateTime(2023, 1, 21),
          endDate: DateTime(2023, 11, 6),
        ),
        Expanded(
          child: SizedBox(
            height: screenHeightPercentage(context, percentage: .25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    'Friday Check in',
                    style: textTheme.displayMedium,
                  ),
                  subtitle: Text(
                    '1PM-7PM',
                    style: textTheme.headlineMedium,
                  ),
                ),
                const Spacer(),
                ListTile(
                  title: Text(
                    'Tuesday Check out',
                    style: textTheme.displayMedium,
                  ),
                  subtitle: Text(
                    '1PM-7PM',
                    style: textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildFeeTaxDetails() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fee & Tax Details',
          style: textTheme.headlineMedium!.copyWith(fontSize: 18),
        ),
        vSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\u0024122 x 15 nights',
              style: textTheme.displayMedium,
            ),
            Text(
              '\u00241.813',
              style: textTheme.headlineMedium,
            ),
          ],
        ),
        vSpaceTiny,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Service charges',
              style: textTheme.displayMedium,
            ),
            Text(
              '\u002425',
              style: textTheme.headlineMedium,
            ),
          ],
        ),
        vSpaceTiny,
        const Divider(height: 16),
        vSpaceTiny,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: textTheme.displayMedium,
            ),
            Text(
              '\u00241.824',
              style: textTheme.headlineMedium,
            ),
          ],
        )
      ],
    );
  }

  _buildButtons() {
    final buttonTheme = Theme.of(context).elevatedButtonTheme;
    final textButtonTheme = Theme.of(context).textButtonTheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: buttonTheme.style!.copyWith(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConstants.kLightGrey200),
              fixedSize: const MaterialStatePropertyAll(
                Size.fromHeight(56),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(PaymentProcessPage.path);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/mc.png'),
                  hSpaceMedium,
                  Text(
                    'Pay with Master Card',
                    style: textTheme.displayMedium!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: textButtonTheme.style!.copyWith(
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              fixedSize: const MaterialStatePropertyAll(
                Size.fromHeight(56),
              ),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Other Method',
                    style: textTheme.displayMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.kGrey600),
                  ),
                ],
              ),
            ),
          ),
        ),
        vSpaceMedium,
        AddButton(
          type: ButtonType.fill,
          isFullWidth: true,
          buttonText: 'Next step',
          onPressed: () {},
          heightSize: 56,
        )
      ],
    );
  }
}
