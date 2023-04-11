import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';

enum IconWTextButtonType { fill, outlined }

class IconWTextButton extends StatelessWidget {
  final IconWTextButtonType type;
  final bool isFullWidth;
  final IconData icon;
  final String buttonText;
  final VoidCallback onPressed;
  final double heightSize;
  final double? widthSize;

  const IconWTextButton({
    Key? key,
    required this.type,
    required this.isFullWidth,
    required this.icon,
    required this.buttonText,
    required this.onPressed,
    this.heightSize = 36,
    this.widthSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == IconWTextButtonType.fill
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
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: theme.elevatedButtonTheme.style!.copyWith(
        fixedSize: MaterialStatePropertyAll(
          widthSize == null
              ? Size.fromHeight(heightSize)
              : Size(
                  widthSize!,
                  heightSize,
                ),
        ),
      ),
      icon: Icon(icon, size: 28),
      label: Text(
        buttonText,
        style: theme.textTheme.displayMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
            height: 1.15),
      ),
    );
  }

  _buildOutlinedButton(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: onPressed,
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
