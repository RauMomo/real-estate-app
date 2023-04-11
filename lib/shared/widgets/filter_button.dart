import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/widgets/add_button.dart';

class FilterButton extends StatelessWidget {
  final ButtonType type;
  final bool isFullWidth;
  final String buttonText;
  final VoidCallback onPressed;
  final bool isSelected;
  final double heightSize;

  const FilterButton({
    Key? key,
    required this.type,
    required this.isFullWidth,
    required this.buttonText,
    required this.onPressed,
    this.isSelected = false,
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
        shape: MaterialStatePropertyAll(
          BeveledRectangleBorder(
            side: BorderSide(width: 1.0, color: ColorConstants.kGrey200),
          ),
        ),
        backgroundColor: isSelected
            ? MaterialStatePropertyAll(ColorConstants.kPrimary)
            : MaterialStatePropertyAll(ColorConstants.kGrey200),
      ),
      child: Text(
        buttonText,
        style: theme.textTheme.displayMedium!.copyWith(
            color: isSelected ? ColorConstants.kWhite : Colors.black,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.4,
            height: 1.2),
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
