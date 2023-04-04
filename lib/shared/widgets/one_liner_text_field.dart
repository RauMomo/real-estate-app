import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/util/validators.dart';

class OneLinerTextField extends StatefulWidget {
  const OneLinerTextField(
      {super.key,
      this.title,
      this.hintText,
      this.selectedValidator,
      this.maxLength,
      this.minLength,
      this.onChanged});

  final String? title;
  final String? hintText;
  final int? minLength;
  final int? maxLength;
  final void Function(String)? onChanged;
  final ValidatorType? selectedValidator;

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
  late String title;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    selectedValidator = widget.selectedValidator ?? defaultValidator;
    title = widget.title ?? '';
    hintText = widget.hintText ?? 'Input $title';
    minLength = widget.minLength ?? 0;
    maxLength = widget.maxLength ?? 0;
    stringValidator = FormValidatorBuilder()
        .minLength(minLength, selectedValidator.name)
        .maxLength(maxLength, selectedValidator.name)
        .fromType(selectedValidator)
        .build();
  }

  @override
  Widget build(BuildContext context) {
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
            suffixIcon: selectedValidator == ValidatorType.password
                ? _buildPasswordIcon()
                : _buildStatusIcon(),
          ),
        ),
      ],
    );
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
}
