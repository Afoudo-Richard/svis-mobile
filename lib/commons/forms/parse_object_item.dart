import 'package:formz/formz.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

enum ParseObjectItemValidationError { empty }

class ParseObjectItem
    extends FormzInput<ParseObject?, ParseObjectItemValidationError> {
  const ParseObjectItem.pure() : super.pure(null);
  const ParseObjectItem.dirty([ParseObject? value]) : super.dirty(value);

  @override
  ParseObjectItemValidationError? validator(ParseObject? value) {
    return value?.objectId != null
        ? null
        : ParseObjectItemValidationError.empty;
  }
}
