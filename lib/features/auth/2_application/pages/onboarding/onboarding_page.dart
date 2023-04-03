import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/util/validators.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';
import 'package:real_estate_app/shared/widgets/one_liner_text_field.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() {
    return _OnboardingPageState();
  }
}

class _OnboardingPageState extends State<OnboardingPage> {
  late List<Widget> formList;
  PageController pageController = PageController();
  late StreamController<int> currentIndex;
  int takenIndex = 0;

  @override
  void initState() {
    currentIndex = StreamController();
    var initialIndex = 0;
    currentIndex.sink.add(initialIndex);

    currentIndex.stream.listen((event) {
      takenIndex = event;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    formList = [_buildEmailForm(), _buildPasswordForm()];
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    var height = screenHeightPercentage(context, percentage: 3);
    return AppBar(
      toolbarHeight: 0,
    );
  }

  _buildBody(context) {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) {
        return formList[index];
      },
      pageSnapping: true,
      itemCount: formList.length,
    );
  }

  _buildEmailForm() {
    var height = screenHeightPercentage(context, percentage: 0.55);
    var textTheme = Theme.of(context).textTheme;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          scale: 2,
        ),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              color: Colors.white,
            ),
            height: height,
            width: screenWidth(context),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: textTheme.headlineLarge,
                ),
                Text(
                  'Enter your email or number',
                  style: textTheme.titleMedium,
                ),
                vSpaceRegular,
                const OneLinerTextField(
                  hintText: 'example@example.com',
                  selectedValidator: ValidatorType.email,
                  title: 'Email or Mobile Number',
                  minLength: 9,
                ),
                vSpaceMedium,
                AddButton(
                  type: ButtonType.fill,
                  isFullWidth: true,
                  buttonText: 'Next Step',
                  onPressed: () {
                    
                    // setState(() {
                    //   currentIndex.sink.add(takenIndex + 1);
                    //   pageController.animateToPage(takenIndex,
                    //       duration: const Duration(milliseconds: 500),
                    //       curve: Curves.easeIn);
                    // });
                  },
                  heightSize: 60,
                ),
                vSpaceSmall,
                Center(
                  child: Text(
                    'or',
                    style: textTheme.displayMedium,
                  ),
                ),
                vSpaceSmall,
                AddButton(
                  type: ButtonType.outlined,
                  isFullWidth: true,
                  buttonText: 'Create an account',
                  onPressed: () {},
                  heightSize: 60,
                ),
                const Spacer(
                  flex: 3,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'By signing in you agree to our ',
                            style: textTheme.titleMedium),
                        TextSpan(
                          text: 'Terms of Service',
                          style: textTheme.titleMedium!.copyWith(
                              color: ColorConstants.kPrimary,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildPasswordForm() {
    var height = screenHeightPercentage(context, percentage: 0.5);
    var textTheme = Theme.of(context).textTheme;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          scale: 2,
        ),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              color: Colors.white,
            ),
            height: height,
            width: screenWidth(context),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: textTheme.headlineLarge,
                ),
                Text(
                  'Enter your password',
                  style: textTheme.titleMedium,
                ),
                vSpaceRegular,
                const OneLinerTextField(
                  hintText: '● ● ● ● ● ●',
                  selectedValidator: ValidatorType.password,
                  title: 'Password',
                ),
                vSpaceRegular,
                AddButton(
                  type: ButtonType.fill,
                  isFullWidth: true,
                  buttonText: 'Next Step',
                  onPressed: () {},
                  heightSize: 48,
                ),
                vSpaceSmall,
                Center(
                  child: Text(
                    'or',
                    style: textTheme.displayMedium,
                  ),
                ),
                vSpaceSmall,
                AddButton(
                  type: ButtonType.outlined,
                  isFullWidth: true,
                  buttonText: 'Create an account',
                  onPressed: () {},
                  heightSize: 48,
                ),
                const Spacer(
                  flex: 3,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'By signing in you agree to our ',
                            style: textTheme.titleMedium),
                        TextSpan(
                          text: 'Terms of Service',
                          style: textTheme.titleMedium!.copyWith(
                              color: ColorConstants.kPrimary,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
