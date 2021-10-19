import 'dart:math';


final rand = Random();

final List<Map<String,dynamic>> barChartData = [
  {
    'date' : "29.Jan",
    'value' : rand.nextDouble() * 100
  },
  {
    'date' : "30.Jan",
    'value' : rand.nextDouble() * 100
  },
  {
    'date' : "31.Jan",
    'value' : rand.nextDouble() * 100
  },
  {
    'date' : "01.Feb",
    'value' : rand.nextDouble() * 100
  },
  {
    'date' : "02.Feb",
    'value' : rand.nextDouble() * 100
  }
];