abstract class FormValidatorLocale {
  String email(String v);
  String phoneNumber(String v);
  String password(String v);
  String minLength(int len, String attr);
  String maxLength(int len, String attr);
  String mustContainDigit(String attr);
  String mustContainSymbol(String attr);
}

class EnglishFormValidatorLocale implements FormValidatorLocale {
  @override
  String email(String v) {
    return v.isEmpty ? 'Email is required' : 'Invalid email format';
  }

  @override
  String phoneNumber(String v) {
    return v.isEmpty ? 'Phone number is required' : 'Invalid phone number';
  }

  @override
  String password(String v) {
    return v.isEmpty ? 'Phone number is required' : 'Invalid phone number';
  }

  @override
  String mustContainDigit(String attr) {
    return '$attr must contain number';
  }

  @override
  String mustContainSymbol(String attr) {
    return '$attr must contain symbol';
  }

  @override
  String minLength(int len, String attr) {
    return '$attr length must be more than $len characters';
  }

  @override
  String maxLength(int len, String attr) {
    return '$attr length must be less than $len characters';
  }
}
