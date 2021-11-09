import 'package:formz/formz.dart';

enum OptionalNameValidationError { empty }

class OptionalName extends FormzInput<String?, OptionalNameValidationError> {
  const OptionalName.pure() : super.pure('');

  const OptionalName.dirty([String? value = '']) : super.dirty(value);

  @override
  OptionalNameValidationError? validator(String? value) {
    return null;
  }
}
