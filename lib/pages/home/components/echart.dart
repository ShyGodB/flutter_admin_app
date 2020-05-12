import 'package:flutter/cupertino.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class HomeEchart extends StatelessWidget {
  final List times;
  final List orders;
  final List turnover;

  HomeEchart({
    this.orders, 
    this.times, 
    this.turnover
  });

  @override
  Widget build(BuildContext context) {
    return Echarts(
      option: '''
        {
          color: ["#65a031", "#fc7c00"],
          title: {
            text: "",
            subtext: "",
            top: 0
          },
          grid: {
            height: 150,
            top: 35
          },
          tooltip: {
            trigger: "axis"
          },
          legend: {
            data: ["单量", "交易额"],
            top: 6
          },
          xAxis: {
            type: 'category',
            data: $times
          },
          yAxis: [
            {
              type: "value",
              name: ""
            },
            {
              type: "value",
              name: "单量",
              splitLine: {
                show: false
              }
            }
          ],
          series: [{
            name: '单量',
            yAxisIndex: 1,
            type: 'line',
            data: $orders
          }, {
            name: '交易额',
            type: 'bar',
            data: $turnover
          }]
        }
      ''',
    ); 
  }
}