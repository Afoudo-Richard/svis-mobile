import 'package:formz/formz.dart';

enum BooleanInputValidationError { empty }

class BooleanInput
    extends FormzInput<bool, BooleanInputValidationError> {
  const BooleanInput.pure() : super.pure(false);

  const BooleanInput.dirty([bool value = false]) : super.dirty(value);

  @override
  BooleanInputValidationError? validator(bool value) {
    return value == true ? null : BooleanInputValidationError.empty;
  }
}
