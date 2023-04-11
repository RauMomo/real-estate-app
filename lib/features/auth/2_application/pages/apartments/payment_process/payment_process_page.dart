import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/payment_process/payment_process_success.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';
import 'package:real_estate_app/shared/widgets/one_liner_text_field.dart';

class PaymentProcessPage extends StatefulWidget {
  static const String path = '/payment-process';
  const PaymentProcessPage({Key? key}) : super(key: key);

  @override
  State<PaymentProcessPage> createState() => PaymentProcessPageState();
}

class PaymentProcessPageState extends State<PaymentProcessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Payment Process'.toUpperCase(),
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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 4,
            child: Image.asset(
              'assets/images/card.png',
              fit: BoxFit.cover,
              width: screenWidth(context),
            ),
          ),
          Flexible(
            flex: 7,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                children: [
                  OneLinerTextField(
                    title: 'Your Name'.toUpperCase(),
                    hintText: 'Jan Kowalski',
                  ),
                  vSpaceSemiRegular,
                  OneLinerTextField(
                    title: 'Your Card Number'.toUpperCase(),
                    hintText: 'XXXX-XXXX-XXXX-XXXX-XXX',
                  ),
                  vSpaceSemiRegular,
                  Row(
                    children: [
                      Expanded(
                        child: OneLinerTextField(
                          title: 'Date'.toUpperCase(),
                          hintText: 'DD.MM.RR',
                        ),
                      ),
                      hSpaceMedium,
                      Expanded(
                        child: OneLinerTextField(
                          title: 'CVC'.toUpperCase(),
                          hintText: '234',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Old price',
                        style: textTheme.headlineMedium!.copyWith(
                            height: 2.25, color: ColorConstants.kDark400),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '\u0024350',
                              style: textTheme.headlineLarge!.copyWith(
                                  height: 2.25, color: ColorConstants.kDark400),
                            ),
                            TextSpan(
                              text: '/night',
                              style: textTheme.titleMedium!.copyWith(
                                  height: 2.25, color: ColorConstants.kDark400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total pay',
                        style: textTheme.headlineMedium!.copyWith(height: 1.75),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '\u0024150',
                              style: textTheme.headlineLarge!
                                  .copyWith(height: 1.75),
                            ),
                            TextSpan(
                              text: '/night',
                              style:
                                  textTheme.titleMedium!.copyWith(height: 1.75),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  vSpaceMedium,
                  AddButton(
                    type: ButtonType.fill,
                    isFullWidth: true,
                    buttonText: 'Next Step',
                    heightSize: 48,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(PaymentProcessSuccess.path);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
