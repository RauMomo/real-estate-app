class ValidatorOptions {
  RegExp phoneValidatorOptions;
  RegExp emailValidatorOptions;
  RegExp passwordValidatorOptions;

  ValidatorOptions(
      {RegExp? phoneValidatorOptions,
      RegExp? emailValidatorOptions,
      RegExp? passwordValidatorOptions})
      : emailValidatorOptions =
            emailValidatorOptions ?? _defaultEmailValidatorOptions,
        phoneValidatorOptions =
            phoneValidatorOptions ?? _defaultPhoneValidatorOptions,
        passwordValidatorOptions =
            passwordValidatorOptions ?? _defaultPasswordValidatorOptions;

  static final _defaultEmailValidatorOptions = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  static final _defaultPhoneValidatorOptions = RegExp(r'^\d{7,15}$');

  static final _defaultPasswordValidatorOptions =
      RegExp(r'^(?=.*[A-Z])(?=.*?[0-9])');
}
