import '../helpers.dart';

enum UIError {
  emailInUse,
  invalidCredentials,
  invalidField,
  requiredField,
  unexpected
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.emailInUse: return R.strings.msgEmailInUse;
      case UIError.invalidCredentials: return R.strings.msgInvalidCredentials;
      case UIError.invalidField: return R.strings.msgInvalidField;
      case UIError.requiredField: return R.strings.msgRequiredField;
      default: return R.strings.msgUnexpectedError;
    }
  }
}