import 'package:app/commons/colors.dart';
import 'package:flutter/material.dart';

class BarChart extends StatefulWidget {
  const BarChart({Key? key, required this.data}) : super(key: key);
  final List<Map<String, dynamic>> data;
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Bar(
          date: widget.data[0]['date'],
          value: widget.data[0]['value'],
        ),
        Bar(
          date: widget.data[1]['date'],
          value: widget.data[1]['value'],
        ),
        Bar(
          date: widget.data[2]['date'],
          value: widget.data[2]['value'],
        ),
        Bar(
          date: widget.data[3]['date'],
          value: widget.data[3]['value'],
        ),
        Bar(
          date: widget.data[4]['date'],
          value: widget.data[4]['value'],
        ),
        //Bar(date: widget.data[4]['date'], value: widget.data[4]['value'], highest: highest,),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({
    Key? key,
    required this.date,
    required this.value,
  }) : super(key: key);

  final String date;
  final double value;

  final double _maxBarHeight = 100.0;

  Gradient getColors(double percent) {
    if (percent >= 0.75) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.1, 1],
        colors: [Colors.red, Colors.blue],
      );
    } else if (percent >= 0.50) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.3, 1],
        colors: [Colors.red, Colors.blue],
      );
    } else if (percent >= 0.25) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.01, 1],
        colors: [Colors.red, Colors.blue],
      );
    }

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue, Colors.blue],
    );
  }

  @override
  Widget build(BuildContext context) {
    final percent = (value) / 100;
    final barHeight = percent * _maxBarHeight;

    return Expanded(
      child: Column(
        children: [
          Text(
            "${value.toInt()}",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 8.0),
          ),
          SizedBox(height: 6.0),
          Stack(
            children: [
              Container(
                height: _maxBarHeight,
                width: 5.0,
                decoration: BoxDecoration(
                  color: kScaffoldBackground,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: barHeight,
                  width: 5.0,
                  decoration: BoxDecoration(
                    color: kAppPrimaryColor,
                    borderRadius: BorderRadius.circular(6.0),
                    gradient: getColors(percent),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            date,
            softWrap: false,
            style: TextStyle(fontSize: 6.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
