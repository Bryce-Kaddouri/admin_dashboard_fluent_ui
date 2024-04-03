import 'package:admin_dashboard/src/core/helper/price_helper.dart';
import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_categ_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
  List<StatOrderByDayModel> lstData;

  PieChartWidget({super.key, required this.lstData});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    print('lstData: ${this.widget.lstData}');
  }

  Color getColor(String day) {
    switch (day) {
      case 'Monday':
        return AppColors.contentColorBlue;
      case 'Tuesday':
        return AppColors.contentColorYellow;
      case 'Wednesday':
        return AppColors.contentColorPink;
      case 'Thursday':
        return AppColors.contentColorGreen;
      case 'Friday':
        return AppColors.contentColorPurple;
      case 'Saturday':
        return AppColors.contentColorRed;
      case 'Sunday':
        return AppColors.contentColorCyan;
      default:
        return AppColors.contentColorBlue;
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

    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(children: [
        const SizedBox(
          height: 28,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.lstData.length,
            (index) => Indicator(
              color: getColor(widget.lstData[index].day),
              text: '${widget.lstData[index].day} - ${widget.lstData[index].orderCount} Orders',
              isSquare: true,
              size: 16,
              textColor: touchedIndex == index ? AppColors.contentColorWhite : AppColors.contentColorBlack,
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                startDegreeOffset: 180,
                centerSpaceRadius: 0,
                sections: List.generate(
                    widget.lstData.length,
                    (index) => PieChartSectionData(
                          color: getColor(widget.lstData[index].day),
                          value: widget.lstData[index].amountTotal.toDouble(),
                          title: '${PriceHelper.getFormattedPrice(widget.lstData[index].amountTotal)}',
                          radius: squareSize / 2.5,
                          borderSide: touchedIndex == index ? const BorderSide(color: AppColors.contentColorWhite, width: 6) : BorderSide(width: 1, color: AppColors.contentColorWhite.withOpacity(0)),
                        )),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
