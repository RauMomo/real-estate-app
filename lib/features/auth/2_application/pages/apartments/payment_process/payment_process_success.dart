import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/apartment_detail.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/util/conversion.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';

class PaymentProcessSuccess extends StatefulWidget {
  const PaymentProcessSuccess({Key? key}) : super(key: key);

  static const String path = '/payment-success';

  @override
  State<PaymentProcessSuccess> createState() => _PaymentProcessSuccessState();
}

class _PaymentProcessSuccessState extends State<PaymentProcessSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorConstants.kPrimary,
      body: _buildBody(),
    );
  }

  _buildBody() {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.center,
      height: screenHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/check-in.png',
            scale: 4.0,
            alignment: AlignmentDirectional.center,
          ),
          Text(
            'Success!',
            style: textTheme.headlineLarge!.copyWith(
              height: pxToDouble(px: 36),
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: screenWidthPercentage(context, percentage: .35),
              maxWidth: screenWidthPercentage(context, percentage: .5),
            ),
            child: Text(
              'You succesfully maked a payment, enjoy travel!',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                  overflow: TextOverflow.clip),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(24),
            child: AddButton(
              type: ButtonType.fill,
              isFullWidth: true,
              buttonText: 'Next Step',
              onPressed: () {
                Navigator.of(context).popUntil(
                    (route) => route.settings.name == ApartmentDetailPage.path);
              },
              heightSize: 48,
              color: ColorConstants.kSuccess,
            ),
          )
        ],
      ),
    );
  }
}
