/// Bar chart example

import 'dart:math';

import 'package:admin_dashboard/src/core/helper/price_helper.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../data/model/stat_order_by_customer.dart';

class SimpleBarChartWidget extends StatefulWidget {
  final List<StatOrderByCustomer> statOrderByCustomerList;
  final bool isTotalAmount;

  const SimpleBarChartWidget({super.key, required this.statOrderByCustomerList, required this.isTotalAmount});

  @override
  State<SimpleBarChartWidget> createState() => _SimpleBarChartWidgetState();
}

class _SimpleBarChartWidgetState extends State<SimpleBarChartWidget> {
  /* int touchedIndex = -1;

  bool isPlaying = false;

  /// Create one series with sample hard coded data.

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
*/

  // clors for top 1 to 10
  final List<Color> barColors = [
    Color(0XFF008000),
    Color(0XFF1c8400),
    Color(0XFF398800),
    Color(0XFF558c00),
    Color(0XFF719000),
    Color(0XFF8e9500),
    Color(0XFFaa9900),
    Color(0XFFc69d00),
    Color(0XFFe3a100),
    Color(0XFFffa500),
  ];

  List<ChartItem> _values = <ChartItem<void>>[];
  double targetMax = 0;
  double targetMin = 0;
  int interval = 10;

  @override
  void initState() {
    super.initState();
    print('initState');
    List<ChartItem> _val = [];
    double min = 0;
    double max = 0;
    widget.statOrderByCustomerList.forEach((element) {
      if (widget.isTotalAmount) {
        _val.add(ChartItem(
          element.amountTotal,
        ));
        if (element.amountTotal > max) {
          max = element.amountTotal;
        }
      } else {
        _val.add(ChartItem(element.count.toDouble()));
        if (element.count > max) {
          max = element.count.toDouble();
        }
      }
    });
    setState(() {
      _values = _val;
      targetMax = max;
      targetMin = min;
      if (widget.isTotalAmount) {
        if (max > 1000) {
          interval = 1000;
        } else if (max > 100) {
          interval = 100;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      data: _values,
      height: MediaQuery.of(context).size.height * 0.4,
      dataToValue: (ChartItem value) => value.max ?? 0.0,
      itemOptions: WidgetItemOptions(
        widgetItemBuilder: (data) {
          final colorForValue = barColors[data.itemIndex];
          return Container(
            padding: const EdgeInsets.only(top: 12.0),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: colorForValue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              widget.isTotalAmount ? '${PriceHelper.getFormattedPrice(widget.statOrderByCustomerList[data.itemIndex].amountTotal)}' : '${widget.statOrderByCustomerList[data.itemIndex].count}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
        multiValuePadding: const EdgeInsets.symmetric(horizontal: 4.0),
      ),
      backgroundDecorations: [
        VerticalAxisDecoration(
          showValues: true,
          showLines: false,
          endWithChart: false,
          valueFromIndex: (index) => '${widget.statOrderByCustomerList[index].fNameCustomer} ${widget.statOrderByCustomerList[index].lNameCustomer}',
        ),
        HorizontalAxisDecoration(
          axisStep: interval.toDouble(),
          showValues: true,
          showLines: false,
          endWithChart: false,
          legendPosition: HorizontalLegendPosition.start,
        )
      ],
      foregroundDecorations: [],
    );
  }
}

class BarChartScreen extends StatefulWidget {
  BarChartScreen({Key? key}) : super(key: key);

  @override
  _BarChartScreenState createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  List<BarValue<void>> _values = <BarValue<void>>[];
  double targetMax = 0;
  double targetMin = 0;
  bool _showValues = false;
  bool _smoothPoints = false;
  bool _colorfulBars = false;
  bool _showLine = false;
  int minItems = 6;
  bool _legendOnEnd = true;
  bool _legendOnBottom = true;

  @override
  void initState() {
    super.initState();
    _updateValues();
  }

  void _updateValues() {
    final Random _rand = Random();
    final double _difference = _rand.nextDouble() * 10;
    targetMax = 5 + ((_rand.nextDouble() * _difference * 0.75) - (_difference * 0.25)).roundToDouble();
    _values.addAll(List.generate(minItems, (index) {
      return BarValue<void>(targetMax * 0.4 + _rand.nextDouble() * targetMax * 0.9);
    }));
    targetMin = targetMax - ((_rand.nextDouble() * 3) + (targetMax * 0.2));
  }

  void _addValues() {
    _values = List.generate(minItems, (index) {
      if (_values.length > index) {
        return _values[index];
      }

      return BarValue<void>(targetMax * 0.4 + Random().nextDouble() * targetMax * 0.9);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bar chart',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: BarChart(
              data: _values,
              height: MediaQuery.of(context).size.height * 0.4,
              dataToValue: (BarValue value) => value.max ?? 0.0,
              itemOptions: BarItemOptions(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                minBarWidth: 4.0,
                barItemBuilder: (data) {
                  final colorForValue = Colors.accents[data.itemIndex % 15];
                  return BarItem(
                    radius: const BorderRadius.vertical(
                      top: Radius.circular(24.0),
                    ),
                    color: _colorfulBars ? colorForValue : Theme.of(context).colorScheme.primary,
                  );
                },
              ),
              backgroundDecorations: [
                GridDecoration(
                  showHorizontalValues: _showValues,
                  showVerticalValues: _showValues,
                  showTopHorizontalValue: _legendOnBottom ? _showValues : false,
                  horizontalLegendPosition: _legendOnEnd ? HorizontalLegendPosition.end : HorizontalLegendPosition.start,
                  verticalLegendPosition: _legendOnBottom ? VerticalLegendPosition.bottom : VerticalLegendPosition.top,
                  horizontalAxisStep: 1,
                  verticalAxisStep: 1,
                  verticalValuesPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  horizontalValuesPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  textStyle: Theme.of(context).textTheme.caption,
                  gridColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                ),
                TargetAreaDecoration(
                  targetAreaFillColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
                  targetLineColor: Theme.of(context).colorScheme.error,
                  targetAreaRadius: BorderRadius.circular(12.0),
                  targetMax: targetMax,
                  targetMin: targetMin,
                  colorOverTarget: Theme.of(context).colorScheme.error,
                ),
              ],
              foregroundDecorations: [
                SparkLineDecoration(
                  lineWidth: 4.0,
                  lineColor: Theme.of(context).primaryColor.withOpacity(_showLine ? 1.0 : 0.0),
                  smoothPoints: _smoothPoints,
                ),
                ValueDecoration(
                  alignment: Alignment.bottomCenter,
                  textStyle: Theme.of(context).textTheme.button!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
                BorderDecoration(endWithChart: true)
              ],
            ),
          ),
          Expanded(
            child: ChartOptionsWidget(
              onRefresh: () {
                setState(() {
                  _values.clear();
                  _updateValues();
                });
              },
              onAddItems: () {
                setState(() {
                  minItems += 4;
                  _addValues();
                });
              },
              onRemoveItems: () {
                setState(() {
                  if (_values.length > 4) {
                    minItems -= 4;
                    _values.removeRange(_values.length - 4, _values.length);
                  }
                });
              },
              toggleItems: [
                ToggleItem(
                  title: 'Axis values',
                  value: _showValues,
                  onChanged: (value) {
                    setState(() {
                      _showValues = value;
                    });
                  },
                ),
                ToggleItem(
                  value: _colorfulBars,
                  title: 'Rainbow bar items',
                  onChanged: (value) {
                    setState(() {
                      _colorfulBars = value;
                    });
                  },
                ),
                ToggleItem(
                  value: _legendOnEnd,
                  title: 'Legend on end',
                  onChanged: (value) {
                    setState(() {
                      _legendOnEnd = value;
                    });
                  },
                ),
                ToggleItem(
                  value: _legendOnBottom,
                  title: 'Legend on bottom',
                  onChanged: (value) {
                    setState(() {
                      _legendOnBottom = value;
                    });
                  },
                ),
                ToggleItem(
                  value: _showLine,
                  title: 'Show line decoration',
                  onChanged: (value) {
                    setState(() {
                      _showLine = value;
                    });
                  },
                ),
                ToggleItem(
                  value: _smoothPoints,
                  title: 'Smooth line curve',
                  onChanged: (value) {
                    setState(() {
                      _smoothPoints = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef DataToValue<T> = double Function(T item);
typedef DataToAxis<T> = String Function(int item);

/// Short-hand to easier create several bar charts
class BarChart<T> extends StatelessWidget {
  BarChart({
    required List<T> data,
    required DataToValue<T> dataToValue,
    this.height = 240.0,
    this.backgroundDecorations = const [],
    this.foregroundDecorations = const [],
    this.chartBehaviour = const ChartBehaviour(),
    this.itemOptions = const BarItemOptions(),
    this.stack = false,
    Key? key,
  })  : _mappedValues = [data.map((e) => BarValue<T>(dataToValue(e))).toList()],
        super(key: key);

  const BarChart.map(
    this._mappedValues, {
    this.height = 240.0,
    this.backgroundDecorations = const [],
    this.foregroundDecorations = const [],
    this.chartBehaviour = const ChartBehaviour(),
    this.itemOptions = const BarItemOptions(),
    this.stack = false,
    Key? key,
  }) : super(key: key);

  final List<List<BarValue<T>>> _mappedValues;
  final double height;

  final bool stack;
  final ItemOptions itemOptions;
  final ChartBehaviour chartBehaviour;
  final List<DecorationPainter> backgroundDecorations;
  final List<DecorationPainter> foregroundDecorations;

  @override
  Widget build(BuildContext context) {
    final _data = ChartData<T>(
      _mappedValues,
      valueAxisMaxOver: 1,
      dataStrategy: stack ? StackDataStrategy() : DefaultDataStrategy(stackMultipleValues: false),
    );

    return AnimatedChart<T>(
      height: height,
      width: MediaQuery.of(context).size.width - 24.0,
      duration: const Duration(milliseconds: 450),
      state: ChartState<T>(
        data: _data,
        itemOptions: itemOptions,
        behaviour: chartBehaviour,
        foregroundDecorations: foregroundDecorations,
        backgroundDecorations: [
          ...backgroundDecorations,
        ],
      ),
    );
  }
}

class ChartOptionsWidget extends StatefulWidget {
  ChartOptionsWidget({
    required this.onRefresh,
    required this.toggleItems,
    required this.onAddItems,
    required this.onRemoveItems,
    Key? key,
  }) : super(key: key);

  final VoidCallback onRefresh;
  final VoidCallback onAddItems;
  final VoidCallback onRemoveItems;
  final List<Widget> toggleItems;

  @override
  _ChartOptionsWidgetState createState() => _ChartOptionsWidgetState();
}

class _ChartOptionsWidgetState extends State<ChartOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: ListTile(
                  trailing: Icon(Icons.add),
                  title: Text('Add data'),
                  onTap: widget.onAddItems,
                ),
              ),
              Flexible(
                child: ListTile(
                  trailing: Icon(Icons.remove),
                  title: Text('Remove data'),
                  onTap: widget.onRemoveItems,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: ToggleItem(
                  value: timeDilation == 10,
                  title: 'Slow animations',
                  onChanged: (value) {
                    setState(() {
                      timeDilation = timeDilation == 10 ? 1 : 10;
                    });
                  },
                ),
              ),
              Flexible(
                child: ListTile(
                  enabled: widget.onRefresh != null,
                  trailing: Icon(Icons.refresh),
                  title: Text('Refresh dataset'),
                  onTap: widget.onRefresh,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Text(
                'OPTIONS',
                style: Theme.of(context).textTheme.button!.copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
          ),
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Flexible(
            child: ListView(
              children: widget.toggleItems,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class ToggleItem extends StatelessWidget {
  ToggleItem({required this.title, required this.value, required this.onChanged, Key? key}) : super(key: key);

  final bool value;
  final String title;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SwitchListTile(
        value: value,
        title: Text(title),
        onChanged: onChanged,
      ),
    );
  }
}
