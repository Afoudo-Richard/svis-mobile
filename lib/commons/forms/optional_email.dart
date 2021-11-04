import 'package:formz/formz.dart';

enum OptionalEmailValidationError { empty }

class OptionalEmail extends FormzInput<String, OptionalEmailValidationError> {
  const OptionalEmail.pure() : super.pure('');

  const OptionalEmail.dirty([String value = '']) : super.dirty(value);

  @override
  OptionalEmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return null;
    } else {
      return RegExp(r"[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}")
                  .allMatches(value)
                  .length >
              0
          ? null
          : OptionalEmailValidationError.empty;
    }
  }
}
