class Driver {
  String name;
  bool isActive;
  bool hasIncreased;
  
  Driver({required this.name, required this.isActive, required this.hasIncreased});

  factory Driver.fromJson(Map<String, dynamic> json){
    return Driver(
      name: json['name'] as String,
      isActive: false,
      hasIncreased: true
    );
  }
}