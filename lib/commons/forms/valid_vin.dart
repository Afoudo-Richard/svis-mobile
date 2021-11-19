import 'package:formz/formz.dart';

enum ValidVinValidationError { empty }

class ValidVin extends FormzInput<String, ValidVinValidationError> {
  const ValidVin.pure() : super.pure('');
  const ValidVin.dirty([String value = '']) : super.dirty(value);

  @override
  ValidVinValidationError? validator(String value) {
    return value.isNotEmpty == true &&
            RegExp(r"[A-HJ-NPR-Za-hj-npr-z\d]{8}[\dX][A-HJ-NPR-Za-hj-npr-z\d]{2}\d{6}")
                .hasMatch(value) &&
            value.length == 17
        ? null
        : ValidVinValidationError.empty;
  }
}
