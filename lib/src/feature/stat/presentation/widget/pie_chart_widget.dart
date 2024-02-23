import 'dart:math';

import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_categ_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample1 extends StatefulWidget {
  final String title;
  PieChartSample1({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex = -1;

  List<PieChartSectionData> showingSections() {

    return List.generate(
      4,
          (i) {
        final isTouched = i == touchedIndex;
        const color0 = AppColors.contentColorBlue;
        const color1 = AppColors.contentColorYellow;
        const color2 = AppColors.contentColorPink;
        const color3 = AppColors.contentColorGreen;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 25,
              title: '',
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                  color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 25,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                  color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 25,
              title: '',
              radius: 60,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                  color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 25,
              title: '',
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                  color: AppColors.contentColorWhite.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print('lstData: ${this.touchedIndex}');
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: <Widget>[

          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,

                  sections: showingSections(),

                ),
              ),
            ),
          ),
         /* const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Indicator(
                color: Colors.green,
                text: 'One',
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0
                    ? Colors.green
                    : AppColors.mainTextColor3,
              ),
              Indicator(
                color: AppColors.contentColorYellow,
                text: 'Two',
                isSquare: false,
                size: touchedIndex == 1 ? 18 : 16,
                textColor: touchedIndex == 1
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              ),
              Indicator(
                color: AppColors.contentColorPink,
                text: 'Three',
                isSquare: false,
                size: touchedIndex == 2 ? 18 : 16,
                textColor: touchedIndex == 2
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              ),
              Indicator(
                color: AppColors.contentColorGreen,
                text: 'Four',
                isSquare: false,
                size: touchedIndex == 3 ? 18 : 16,
                textColor: touchedIndex == 3
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),*/
        ],
      ),
    );
  }


}


class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}


class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}


class PieChartWidget extends StatefulWidget {
  List<StatOrderByCategoryModel> lstData;

  PieChartWidget({super.key, required this.lstData});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {

  int touchedIndex = -1;
  List<Color> colors = [

  ];

  @override
  void initState() {
    super.initState();
    print('lstData: ${this.widget.lstData}');
    for (var i = 0; i < widget.lstData.length; i++) {
      colors.add(Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1));
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double squareSize = size.width - 100;
    // check if the device is in landscape mode
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      // do something
    print('landscape');
    print('size: $size');
    squareSize = size.height - 100;

    }

    return Column(children:[
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(16),
          color: AppColors.pageBackground,
        ),
/*
        color: Colors.red,
*/
        height: squareSize,
          width: squareSize,
        child:
    PieChart(
    PieChartData(


      startDegreeOffset: 180,


      centerSpaceRadius: 0,



      sections: List.generate(widget.lstData.length, (index) => PieChartSectionData(
        color: colors[index],
        value: widget.lstData[index].total_quantity.toDouble(),
        title: '',
        radius: squareSize / 2.5,

        borderSide: touchedIndex == index
            ? const BorderSide(
            color: AppColors.contentColorWhite, width: 6)
            : BorderSide(
          width: 1,
            color: AppColors.contentColorWhite.withOpacity(0)),
      )),


    ),

      ),



  ),
      Container(
        child: Column(
          children:
          List.generate(widget.lstData.length
              , (index) => Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors[index],
                  ),
                ),
                SizedBox(width: 10,),
                Text('${widget.lstData[index].nameCategory} (${widget.lstData[index].total_quantity})'),
              ],
            ),
          )),
        )
      ),
    ]);
  }
}
