import 'package:formz/formz.dart';

enum EmailValidationError { empty }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.isNotEmpty == true  &&
        RegExp(r"[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}").allMatches(value).length > 0
        ? null : EmailValidationError.empty;
  }
}
