import 'package:formz/formz.dart';

enum IDateTimeValidationError { empty }

class IDateTime extends FormzInput<DateTime?, IDateTimeValidationError> {
  const IDateTime.pure() : super.pure(null);
  const IDateTime.dirty([DateTime? value]) : super.dirty(value);

  @override
  IDateTimeValidationError? validator(DateTime? value) {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day);

    return value?.isBefore(midnight) ?? false
        ? null
        : IDateTimeValidationError.empty;
  }
}
