import 'package:formz/formz.dart';

enum StrongPasswordValidationError { empty }

class StrongPassword extends FormzInput<String, StrongPasswordValidationError> {
  const StrongPassword.pure() : super.pure('');
  const StrongPassword.dirty([String value = '']) : super.dirty(value);

  @override
  StrongPasswordValidationError? validator(String value) {
    return value.isNotEmpty == true &&
            RegExp(r"(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*")
                .hasMatch(value)
        ? null
        : StrongPasswordValidationError.empty;
  }
}
