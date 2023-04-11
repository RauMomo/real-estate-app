import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/util/validators.dart';

enum ControlAffinity {
  leading,
  trailing,
}

class OneLinerTextField extends StatefulWidget {
  const OneLinerTextField({
    super.key,
    this.title,
    this.hintText,
    this.selectedValidator,
    this.maxLength,
    this.minLength,
    this.affinity,
    this.onChanged,
    this.needValidation,
    this.containsIcon,
  });

  final String? title;
  final String? hintText;
  final int? minLength;
  final int? maxLength;
  final void Function(String)? onChanged;
  final ValidatorType? selectedValidator;
  final ControlAffinity? affinity;
  final bool? needValidation;
  final bool? containsIcon;

  @override
  _OneLinerTextFieldState createState() {
    return _OneLinerTextFieldState();
  }
}

class _OneLinerTextFieldState extends State<OneLinerTextField> {
  late TextEditingController controller;
  var maxLines = 1;
  var defaultValidator = ValidatorType.email;
  late ValidatorType selectedValidator;
  late StringValidator stringValidator;
  var hintText;
  late int? minLength;
  late int? maxLength;
  var isValid = false;
  var isObscure = false;
  late ControlAffinity controlAffinity;
  late bool needValidation;
  late bool containsIcon;
  late String title;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    selectedValidator = widget.selectedValidator ?? defaultValidator;
    isObscure = selectedValidator == ValidatorType.password ? true : false;
    title = widget.title ?? '';
    hintText = widget.hintText ?? 'Input $title';
    controlAffinity = widget.affinity ?? ControlAffinity.trailing;
    minLength = widget.minLength ?? 0;
    maxLength = widget.maxLength ?? 0;
    containsIcon = widget.containsIcon ?? true;
    needValidation = widget.needValidation ?? true;

    stringValidator = FormValidatorBuilder()
        .minLength(minLength, selectedValidator.name)
        .maxLength(maxLength, selectedValidator.name)
        .fromType(selectedValidator)
        .build();
  }

  @override
  Widget build(BuildContext context) {
    return needValidation
        ? _buildTextFormValidationEnabled()
        : _buildSearchBarForm();
  }

  _buildPasswordIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
      icon: isObscure
          ? Icon(
              Icons.visibility,
              color: ColorConstants.kGrey,
            )
          : Icon(
              Icons.visibility_off,
              color: ColorConstants.kGrey,
            ),
    );
  }

  _buildStatusIcon() {
    return stringValidator.call(controller.text) == null
        ? Visibility(
            replacement: const SizedBox.shrink(),
            visible: controller.text.isNotEmpty,
            child: Icon(
              Icons.check_circle_outline_rounded,
              color: ColorConstants.kSuccess,
            ),
          )
        : Icon(
            Icons.close_outlined,
            color: ColorConstants.kError,
          );
  }

  Widget _buildTextFormValidationEnabled() {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title.toUpperCase(),
            style: textTheme.headlineSmall,
          ),
        TextFormField(
          scrollPadding: const EdgeInsets.all(30),
          onChanged: (value) {
            widget.onChanged!.call(value);
            setState(() {});
          },
          obscureText: isObscure,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: stringValidator,
          autocorrect: true,
          cursorColor: ColorConstants.kPrimary,
          maxLines: maxLines,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.red),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(width: 1.0, color: ColorConstants.kGrey600),
              ),
              enabled: true,
              hintText: hintText,
              suffixIcon:
                  !containsIcon ? const SizedBox.shrink() : _buildSuffixIcon()),
        ),
      ],
    );
  }

  _buildSuffixIcon() {
    return selectedValidator == ValidatorType.password
        ? _buildPasswordIcon()
        : _buildStatusIcon();
  }

  _buildSearchBarForm() {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return TextField(
      maxLines: maxLines,
      keyboardAppearance: Brightness.dark,
      onChanged: (value) {
        widget.onChanged!.call(value);
      },
      style: textStyle,
      controller: controller,
      scrollPadding: const EdgeInsets.only(bottom: 200),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
        fillColor: ColorConstants.kLightGrey400,
        focusColor: ColorConstants.kLightGrey400,
        isDense: true,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(width: 1.0, color: ColorConstants.kGrey600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(width: 1.0, color: ColorConstants.kGrey600),
        ),
        enabled: true,
        hintText: hintText,
        hintStyle: textStyle,
        prefixIcon: Icon(
          Icons.search,
          color: ColorConstants.kGrey,
          weight: 2.0,
          size: 22,
        ),
      ),
    );
  }
}
