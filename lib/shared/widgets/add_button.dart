import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';

enum ButtonType { fill, outlined }

class AddButton extends StatelessWidget {
  final ButtonType type;
  final bool isFullWidth;
  final String buttonText;
  final VoidCallback onPressed;
  final double heightSize;

  const AddButton({
    Key? key,
    required this.type,
    required this.isFullWidth,
    required this.buttonText,
    required this.onPressed,
    this.heightSize = 36,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == ButtonType.fill
        ? _buildFillButtonWrapper(context)
        : _buildOutlinedButtonWrapper(context);
  }

  _buildFillButtonWrapper(BuildContext context) {
    return isFullWidth
        ? SizedBox(
            width: screenWidth(context),
            child: _buildFillButton(context),
          )
        : Container(
            constraints: const BoxConstraints(),
            child: _buildFillButton(context),
          );
  }

  _buildOutlinedButtonWrapper(BuildContext context) {
    return isFullWidth
        ? SizedBox(
            width: screenWidth(context),
            child: _buildOutlinedButton(context),
          )
        : Container(
            constraints: const BoxConstraints(),
            child: _buildOutlinedButton(context),
          );
  }

  _buildFillButton(context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: theme.elevatedButtonTheme.style!.copyWith(
        fixedSize: MaterialStatePropertyAll(
          Size.fromHeight(heightSize),
        ),
      ),
      child: Text(
        buttonText,
        style: theme.textTheme.displayMedium!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  _buildOutlinedButton(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () {},
      style: theme.textButtonTheme.style!.copyWith(
        fixedSize: MaterialStatePropertyAll(
          Size.fromHeight(heightSize),
        ),
      ),
      child: Text(
        buttonText,
      ),
    );
  }
}
