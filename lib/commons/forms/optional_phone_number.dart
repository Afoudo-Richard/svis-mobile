import 'package:formz/formz.dart';

enum OptionalPhoneNumberValidationError { empty }

class OptionalPhoneNumber
    extends FormzInput<String, OptionalPhoneNumberValidationError> {
  const OptionalPhoneNumber.pure() : super.pure('');

  const OptionalPhoneNumber.dirty([String value = '']) : super.dirty(value);

  @override
  OptionalPhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) {
      return null;
    } else {
      return RegExp(r"[0-9]{9}").hasMatch(value)
          ? null
          : OptionalPhoneNumberValidationError.empty;
    }
  }
}
