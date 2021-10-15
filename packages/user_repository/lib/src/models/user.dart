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

  String? get gender => get<String?>('gender');
  set gender(String? value) => set<String?>('gender', value);

  String? get addressLine1 => get<String?>('addressLine1');
  set addressLine1(String? value) => set<String?>('addressLine1', value);

  String? get addressLine2 => get<String?>('addressLine2');
  set addressLine2(String? value) => set<String?>('addressLine2', value);

  String? get city => get<String?>('city');
  set city(String? value) => set<String?>('city', value);

  String? get timeZone => get<String?>('timeZone');
  set timeZone(String? value) => set<String?>('timeZone', value);

  String? get driverLicenceIssueDate => get<String?>('driverLicenceIssueDate');
  set driverLicenceIssueDate(String? value) =>
      set<String?>('driverLicenceIssueDate', value);

  String? get driverLicenceExpiryDate =>
      get<String?>('driverLicenceExpiryDate');
  set driverLicenceExpiryDate(String? value) =>
      set<String?>('driverLicenceExpiryDate', value);

  String? get driverLicenceDocument => get<String?>('driverLicenceDocument');
  set driverLicenceDocument(String? value) =>
      set<String?>('driverLicenceDocument', value);

  String? get driverLicenceType => get<String?>('driverLicenceType');
  set driverLicenceType(String? value) =>
      set<String?>('driverLicenceType', value);

  String? get state => get<String?>('state');
  set state(String? value) => set<String?>('state', value);

  String? get region => get<String?>('Region');
  set region(String? value) => set<String?>('Region', value);

  String? get phoneNumber => get<String?>('phoneNumber');
  set phoneNumber(String? value) => set<String?>('phoneNumber', value);

  String? get postalCdode => get<String?>('postalCdode');
  set postalCdode(String? value) => set<String?>('postalCdode', value);

  String? get dateOfBirth => get<String?>('dateOfBirth');
  set dateOfBirth(String? value) => set<String?>('dateOfBirth', value);

  @override
  List<Object?> get props => [
        username,
        password,
        emailAddress,
        registeredSince,
        email,
        firstName,
        lastName,
        country,
        gender,
        addressLine1,
        addressLine2,
        city,
        timeZone,
        driverLicenceIssueDate,
        driverLicenceExpiryDate,
        driverLicenceDocument,
        driverLicenceType,
        state,
        region,
        phoneNumber,
        postalCdode,
        dateOfBirth,
      ];
}
