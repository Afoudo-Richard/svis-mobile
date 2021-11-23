import 'package:formz/formz.dart';

enum INumberValidationError { empty }

class INumber extends FormzInput<String, INumberValidationError> {
  const INumber.pure() : super.pure('');

  const INumber.dirty([String value = '']) : super.dirty(value);

  @override
  INumberValidationError? validator(String value) {
    try {
      return value.isEmpty == true || int.parse(value) != 0
          ? null
          : INumberValidationError.empty;
    } catch (_) {
      return INumberValidationError.empty;
    }
  }
}
