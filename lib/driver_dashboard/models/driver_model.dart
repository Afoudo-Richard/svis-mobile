import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Driver extends Equatable {
  final String name;
  final bool isActive;
  final bool hasIncreased;
  
  const Driver({required this.name, required this.isActive, required this.hasIncreased});

  factory Driver.fromJson(ParseObject data){
    return Driver(
      name: data.get('lastName'),
      isActive: false,
      hasIncreased: true
    );
  }

  @override
  String toString(){
    return name;
  }

  @override

  List<Object?> get props => [name, isActive, hasIncreased];
}