import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/date_helper.dart';
import '../../data/model/product_orice_history_model.dart';

class ScrollableChartScreen extends StatefulWidget {
  int currentIndex;
  List<ProductPriceHistoryModel> data;
  ScrollableChartScreen({Key? key, required this.data, required this.currentIndex}) : super(key: key);

  @override
  _ScrollableChartScreenState createState() => _ScrollableChartScreenState();
}

class _ScrollableChartScreenState extends State<ScrollableChartScreen> {
  List<double> _values = <double>[];
  double targetMax = 0;
  int minItems = 30;
  int? _selected;

  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // sort the data by date
    widget.data[widget.currentIndex].priceHistory.sort((a, b) => a.date.compareTo(b.date));
    double minTemp = 0;
    double maxTemp = 0;
    for (var price in widget.data[widget.currentIndex].priceHistory) {
      if (price.price < minTemp) {
        minTemp = price.price;
      }
      if (price.price > maxTemp) {
        maxTemp = price.price;
      }
    }
    setState(() {
      _values = widget.data[widget.currentIndex].priceHistory.map((e) => e.price).toList();
      targetMax = maxTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _chartState = ChartState(
      data: ChartData.fromList(
        _values.map((e) => ChartItem(e)).toList(),
        axisMax: targetMax + 10,
      ),
      itemOptions: BarItemOptions(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        minBarWidth: 60,
        barItemBuilder: (data) {
          return BarItem(
            color: Colors.transparent,
            radius: const BorderRadius.vertical(
              top: Radius.circular(24.0),
            ),
          );
        },
      ),
      behaviour: ChartBehaviour(
        scrollSettings: ScrollSettings(),
        onItemClicked: (item) {
          print('Clciked');
          setState(() {
            _selected = item.itemIndex;
          });
        },
        onItemHoverEnter: (_) {
          print('Hover Enter');
        },
        onItemHoverExit: (_) {
          print('Hover Enter');
        },
      ),
      backgroundDecorations: [
        /*HorizontalAxisDecoration(
          endWithChart: false,
          lineWidth: 2.0,
          axisStep: 1,
          lineColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        ),
        */

        GridDecoration(
          showTopHorizontalValue: true,
          verticalAxisValueFromIndex: (val) {
            return DateHelper.getFormattedDate(widget.data[widget.currentIndex].priceHistory[val].date);
          },
          showVerticalGrid: true,
          showHorizontalValues: true,
          showVerticalValues: true,
          verticalValuesPadding: const EdgeInsets.symmetric(vertical: 12.0),
          verticalAxisStep: 1,
          horizontalAxisStep: 10,
          textStyle: Theme.of(context).textTheme.caption,
          gridColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        ),
        SparkLineDecoration(
          fill: true,
          lineColor: Theme.of(context).primaryColor.withOpacity(0.2),
          smoothPoints: false,
        ),
      ],
      foregroundDecorations: [
        ValueDecoration(
          alignment: Alignment(0, -1.0),
          textStyle: Theme.of(context).textTheme.button!.copyWith(color: (Theme.of(context).colorScheme.primary).withOpacity(1.0)),
        ),
        SparkLineDecoration(
          lineWidth: 2.0,
          lineColor: Theme.of(context).primaryColor.withOpacity(1),
          smoothPoints: false,
        ),
        BorderDecoration(
          endWithChart: true,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        SelectedItemDecoration(
          _selected,
          animate: true,
          selectedColor: Theme.of(context).colorScheme.secondary,
          topMargin: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                shape: BoxShape.circle,
              ),
              child: Text('${_selected != null ? _values[_selected!].toStringAsPrecision(2) : '...'}'),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
        ),
      ],
    );

    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(12.0),
      child: /*Row(
            children: [
              Expanded(
                child:*/
          SingleChildScrollView(
        physics: ScrollPhysics(),
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: AnimatedChart(
          duration: Duration(milliseconds: 450),
          width: MediaQuery.of(context).size.width - 24.0,
          height: MediaQuery.of(context).size.height * 0.4,
          state: _chartState,
        ),
      ),

      /*AnimatedContainer(
                duration: Duration(milliseconds: 350),
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.0),
                  ], stops: [
                    0.5,
                    1.0
                  ]),
                ),
                width: 0.0,
                height: MediaQuery.of(context).size.height * 0.4,
                child: DecorationsRenderer(
                  [],
                  _chartState,
                ),
              ),*/
      /*],
          ),
        ),*/
    );
  }
}

class LineChartProductPrice extends StatefulWidget {
  final List<ProductPriceHistoryModel> data;
  const LineChartProductPrice({super.key, required this.data});

  @override
  State<LineChartProductPrice> createState() => _LineChartProductPriceState();
}

class _LineChartProductPriceState extends State<LineChartProductPrice> {
  @override
  Widget build(BuildContext context) {
    return Container(); /*LineChart(

      LineChartData(
        lineBarsData: widget.data
            .map(
              (e) => LineChartBarData(
                spots: e.priceHistory
                    .map(
                      (e) => FlSpot(
                        e.date.millisecondsSinceEpoch.toDouble(),
                        e.price,
                      ),
                    )
                    .toList(),
                isCurved: true,
                color: Colors.red,
                barWidth: 2,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.red.withOpacity(0.3),
                ),
              ),
            )
            .toList(),
      ),*/
  }
}
