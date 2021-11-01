import 'package:formz/formz.dart';

enum OptionalItemsValidationError { empty }

class OptionalItems extends FormzInput<List?, OptionalItemsValidationError> {
  const OptionalItems.pure() : super.pure(null);
  const OptionalItems.dirty([List? value]) : super.dirty(value);

  @override
  OptionalItemsValidationError? validator(List? value) {
    return null;
  }
}
