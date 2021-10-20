import 'package:formz/formz.dart';
import 'package:app/commons/forms/forms.dart';

enum CurrentEmailValidationError { empty }

class CurrentEmail extends FormzInput<String, CurrentEmailValidationError> {
  const CurrentEmail.pure()
      : original = '',
        super.pure('');

  const CurrentEmail.dirty({required this.original, String value = ''})
      : super.dirty(value);

  final String original;

  @override
  CurrentEmailValidationError? validator(String value) {
    return value.isNotEmpty == true && original == value
        ? null
        : CurrentEmailValidationError.empty;
  }
}
