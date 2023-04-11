import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/bloc/auth_bloc.dart';
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
    return WillPopScope(
      onWillPop: () {
        pageController.previousPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  _buildAppBar() {
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthEmailFailed) {
          EasyLoading.showError(state.message);
        } else if (state is AuthSubmittedEmail) {
          EasyLoading.show();
        } else if (state is AuthEmailSuccess) {
          EasyLoading.dismiss();
          pageController.animateToPage(2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        final authProvider = context.read<AuthBloc>();
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
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                      mainAxisSize: MainAxisSize.min,
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
                        OneLinerTextField(
                          hintText: 'example@example.com',
                          selectedValidator: ValidatorType.email,
                          title: 'Email or Mobile Number',
                          minLength: 9,
                          onChanged: (p0) {
                            authProvider.listenEmailField(p0);
                          },
                        ),
                        vSpaceMedium,
                        AddButton(
                          type: ButtonType.fill,
                          isFullWidth: true,
                          buttonText: 'Next Step',
                          onPressed: () {
                            authProvider.add(
                                AuthEmailCheck(email: authProvider.emailInput));
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
                )),
          ],
        );
      }),
    );
  }

  _buildPasswordForm() {
    var height = screenHeightPercentage(context, percentage: 0.55);
    var textTheme = Theme.of(context).textTheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthEmailFailed) {
          EasyLoading.showError(state.message);
        } else if (state is AuthSubmittedPassword) {
          EasyLoading.show();
        } else if (state is AuthLoginSuccess) {
          EasyLoading.dismiss();
          Navigator.of(context).pushNamed('/');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final authProvider = context.read<AuthBloc>();
          return Stack(
            fit: StackFit.loose,
            children: [
              Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                scale: 2,
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                      mainAxisSize: MainAxisSize.min,
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
                        OneLinerTextField(
                          hintText: '● ● ● ● ● ●',
                          selectedValidator: ValidatorType.password,
                          title: 'Password',
                          onChanged: (p0) {
                            authProvider.listenPasswordField(p0);
                          },
                        ),
                        vSpaceRegular,
                        AddButton(
                          type: ButtonType.fill,
                          isFullWidth: true,
                          buttonText: 'Login',
                          onPressed: () {
                            authProvider.add(AuthLoginEvent(
                                email: authProvider.emailInput,
                                password: authProvider.passwordInput));
                          },
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
              ),
            ],
          );
        },
      ),
    );
  }
}
