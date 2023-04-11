import 'package:real_estate_app/shared/util/validator_locale.dart';
import 'package:real_estate_app/shared/util/validator_options.dart';

enum ValidatorType { email, phoneNumber, password }

typedef StringValidator = String? Function(String? value);

class FormValidatorBuilder {
  final List<StringValidator> validations = [];
  final ValidatorOptions options = ValidatorOptions();
  final FormValidatorLocale locale = EnglishFormValidatorLocale();

  FormValidatorBuilder add(StringValidator validator) {
    validations.add(validator);
    return this;
  }

  /// Tests [value] against defined [validations]
  String? test(String? value) {
    for (var validate in validations) {
      // Return null if field is optional and value is null
      if ((value == null || value.isEmpty)) {
        return null;
      }

      // Otherwise execute validations
      final result = validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  /// Returns a validator function for FormInput
  StringValidator build() => test;

  FormValidatorBuilder fromType(ValidatorType type) {
    switch (type) {
      case ValidatorType.email:
        return _email();
      case ValidatorType.phoneNumber:
        return _phoneNumber();
      case ValidatorType.password:
        return _password();
    }
  }

  static final RegExp _anyLetter = RegExp(r'[A-Za-z]');
  static final RegExp _mustContainLetter = RegExp(r'^(?=.*[A-Z])');
  static final RegExp _mustContainDigit = RegExp(r'^(?=.*[0-9])');
  static final RegExp _nonDigitsExp = RegExp(r'^(?=.*?[#?!@$%^&*-])');

  FormValidatorBuilder minLength(len, attr) => add((value) {
        if (len == 0) {
          return null;
        }
        return value!.length >= len ? null : locale.minLength(len, attr);
      });

  FormValidatorBuilder maxLength(len, attr) => add((value) {
        if (len == 0) {
          return null;
        }
        return value!.length <= len ? null : locale.maxLength(len, attr);
      });

  FormValidatorBuilder _email() =>
      add((value) => options.emailValidatorOptions.hasMatch(value!)
          ? null
          : locale.email(value));

  FormValidatorBuilder _phoneNumber() =>
      add((value) => options.phoneValidatorOptions
              .hasMatch(value!.replaceAll(_nonDigitsExp, ''))
          ? null
          : locale.phoneNumber(value));

  FormValidatorBuilder _password() => add((value) {
        const passwordKey = 'password';
        if (options.passwordValidatorOptions.hasMatch(value!)) {
          return null;
        } else {
          if (!_mustContainDigit.hasMatch(value)) {
            return locale.mustContainDigit(passwordKey);
          } else if (!_nonDigitsExp.hasMatch(value)) {
            return locale.mustContainSymbol(passwordKey);
          }
        }
        return null;
      });
}
