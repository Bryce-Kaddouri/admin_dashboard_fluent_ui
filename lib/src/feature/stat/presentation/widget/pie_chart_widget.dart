import 'package:admin_dashboard/src/feature/stat/data/model/stat_order_by_categ_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
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
  double total = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      total = widget.lstData.fold(0, (previousValue, element) => previousValue + element.amountTotal);
    });
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
    return Column(children: [
      Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.lstData.length,
              (index) => Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Indicator(
                  color: getColor(widget.lstData[index].day),
                  text: '${widget.lstData[index].day} - ${widget.lstData[index].orderCount} Orders',
                  isSquare: true,
                  size: 16,
                  textColor: touchedIndex == index ? AppColors.contentColorWhite : AppColors.contentColorBlack,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  } else {
                    print('touchedIndex: ${pieTouchResponse.touchedSection!.touchedSectionIndex}');
                    int index = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    StatOrderByDayModel data = widget.lstData[index];
                    String day = data.day;

                    fluent.showDialog<String>(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => fluent.ContentDialog(
                        style: const fluent.ContentDialogThemeData(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          bodyPadding: EdgeInsets.all(16),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                          minWidth: 300,
                        ),
                        title: Container(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            fluent.Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(day),
                              ),
                            ),
                            fluent.Button(
                              style: fluent.ButtonStyle(
                                padding: fluent.ButtonState.all(EdgeInsets.zero),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Icon(fluent.FluentIcons.chrome_close),
                              ),
                            ),
                          ]),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Total Orders: ${data.orderCount}'),
                            Text('Total Amount: ${data.amountTotal}'),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              borderData: FlBorderData(show: false),
              startDegreeOffset: 180,
              centerSpaceRadius: 0,
              sections: List.generate(widget.lstData.length, (index) {
                double percentage = (widget.lstData[index].amountTotal / total) * 100;

                print('percentage: $percentage');
                return PieChartSectionData(
                  color: getColor(widget.lstData[index].day),
                  value: widget.lstData[index].amountTotal.toDouble(),
                  title: '${percentage > 5 ? '${percentage.toStringAsFixed(0)}%' : ''}',
                  radius: MediaQuery.of(context).size.width / 2.5,
                  borderSide: touchedIndex == index ? const BorderSide(color: AppColors.contentColorWhite, width: 1) : BorderSide(width: 1, color: AppColors.contentColorWhite.withOpacity(0)),
                );
              }),
            ),
          ),
        ),
      )
    ]);
  }
}
