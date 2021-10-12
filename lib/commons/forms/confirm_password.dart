import 'package:formz/formz.dart';
import 'package:app/commons/forms/forms.dart';

enum ConfirmPasswordValidationError { empty }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure()
      : original = const StrongPassword.pure(),
        super.pure('');

  const ConfirmPassword.dirty({required this.original, String value = ''})
      : super.dirty(value);

  final StrongPassword original;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    return value.isNotEmpty == true && original.value == value
        ? null
        : ConfirmPasswordValidationError.empty;
  }
}
