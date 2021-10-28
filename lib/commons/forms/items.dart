import 'package:formz/formz.dart';

enum ItemsValidationError { empty }

class Items<T> extends FormzInput<List<T>?, ItemsValidationError> {
  const Items.pure() : super.pure(null);
  const Items.dirty([List<T>? value]) : super.dirty(value);

  @override
  ItemsValidationError? validator(List<T>? value) {
    return value?.isEmpty == false ? null : ItemsValidationError.empty;
  }
}
