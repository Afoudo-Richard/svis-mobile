import 'package:app/commons/country/countries.dart';
import 'package:flutter/material.dart';

class Country {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String phoneCode;

  Country(
      {required this.isoCode,
      required this.iso3Code,
      required this.phoneCode,
      required this.name});

  factory Country.fromMap(Map<String, String> map) => Country(
        name: map['name']!,
        isoCode: map['isoCode']!,
        iso3Code: map['iso3Code']!,
        phoneCode: map['phoneCode']!,
      );
}

Widget customSelectedItem(BuildContext context, Country? item) {
  return Container(
    child: (item == null)
        ? ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text("No item selected"),
          )
        : ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Image.asset(
              'assets/countries/flags/${item.isoCode.toLowerCase()}.png',
              width: 40,
              height: 40,
            ),
            title: Text(item.name),
            subtitle: Text(item.phoneCode),
          ),
  );
}

Widget customPopupItemBuilder(
    BuildContext context, Country? item, bool isSelected) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.name ?? ''),
      subtitle: Text(item?.phoneCode ?? ''),
      leading: Image.asset(
        'assets/countries/flags/${item?.isoCode.toLowerCase()}.png',
        width: 40,
        height: 40,
      ),
    ),
  );
}

Future<List<Country>> filterData(String? filter) async {
  return filter != null
      ? countryList.where((element) {
          return element.name.toLowerCase().contains(filter.toLowerCase());
        }).toList()
      : countryList;
}
