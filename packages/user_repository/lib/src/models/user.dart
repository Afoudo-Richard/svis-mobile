import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class User extends ParseUser with EquatableMixin implements ParseCloneable {
  User(String? username, String? password, String? emailAddress)
      : super(username, password, emailAddress);

  User.clone() : this(null, null, null);

  @override
  User clone(Map<String, dynamic> map) => User.clone()..fromJson(map);

  static const String kRegisteredSince = 'createdAt';
  static const String keyEmail = 'email';
  static const String kFirstName = 'firstName';
  static const String kLastName = 'lastName';
  DateTime? get registeredSince => get<DateTime?>(kRegisteredSince);

  set registeredSince(DateTime? value) =>
      set<DateTime?>(kRegisteredSince, value);

  String? get email => get<String?>(keyEmail);
  set email(String? value) => set<String?>(keyEmail, value);

  String? get firstName => get<String?>(kFirstName);
  set firstName(String? value) => set<String?>(kFirstName, value);

  String? get lastName => get<String?>(kLastName);
  set lastName(String? value) => set<String?>(kLastName, value);

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  String? get country => get<String?>('country');
  set country(String? value) => set<String?>('country', value);

  @override
  List<Object?> get props => [
        username,
        password,
        emailAddress,
        registeredSince,
        email,
        firstName,
        lastName,
      ];
}
