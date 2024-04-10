/*import 'package:darq/darq.dart';
import 'package:faker/faker.dart';*/
import 'dart:math';
import 'dart:ui';

// import services for short cut

import 'package:admin_dashboard/src/core/helper/responsive_helper.dart';
import 'package:admin_dashboard/src/feature/theme/presentation/provider/theme_provider.dart';
import 'package:admin_dashboard/src/feature/track_issue/data/model/track_issue_model.dart';
import 'package:admin_dashboard/src/feature/track_issue/presentation/provider/track_issue_provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
/*
import 'package:fluent_ui/fluent_ui.dart';
*/
import 'package:flutter/material.dart' /*as material*/;
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/date_helper.dart';

/*
import '../../dummy_data/development.dart';
import '../../widget/pluto_example_button.dart';
import '../../widget/pluto_example_screen.dart';
*/

/*
import 'package:paged_datatable_example/post.dart';
*/
class TrackIssueScreen extends StatefulWidget {
  const TrackIssueScreen({super.key});

  @override
  State<TrackIssueScreen> createState() => _TrackIssueScreenState();
}

class _TrackIssueScreenState extends State<TrackIssueScreen> {
/*
  List<TrackIssueByDateModel> lstIssue = [];
*/

  List<TrackIssueModel> lstIssue = [];
  List<String> columns = [
    'Oder Id',
    'Order Date',
    'Issue Type',
    'Reported At',
    'Status',
    'Resolved At',
    'Action',
  ];

  List<int> currentIndex = [];
  bool isAscending = true;
  int sortColumnIndex = 1;

  @override
  void initState() {
    super.initState();
    print('initState');
    context.read<TrackIssueProvider>().getAllTrackIssues().then((value) {
      print('value');
      print(value);
      List<TrackIssueModel> lstIssueTemp = [];
      if (value != null) {
        for (var issue in value) {
          lstIssueTemp.add(issue);
        }
        lstIssueTemp.sort((a, b) => b.orderDate.compareTo(a.orderDate));
        setState(() {
          lstIssue = lstIssueTemp;
        });
      }

      /*List<TrackIssueByDateModel> lstIssueTemp = [];
      if (value != null) {
        for (var issue in value) {
          DateTime date = issue.orderDate;
          if (lstIssueTemp.isEmpty) {
            lstIssueTemp.add(TrackIssueByDateModel(date: date, lstIssues: [issue]));
          } else {
            bool isExist = false;
            for (var item in lstIssueTemp) {
              if (item.date == date) {
                item.lstIssues.add(issue);
                isExist = true;
                break;
              }
            }
            if (!isExist) {
              lstIssueTemp.add(TrackIssueByDateModel(date: date, lstIssues: [issue]));
            } else {
              print('isExist');
              lstIssueTemp.firstWhere((element) => element.date == date).lstIssues.add(issue);
            }
          }
        }

        print('lstIssueTemp');
        print(lstIssueTemp);
        for (var item in lstIssueTemp) {
          print('item');
          print(item.lstIssues.length);
        }
        setState(() {
          lstIssue = lstIssueTemp;
        });
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: /*Column(
        children: [
          Card(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              title: Text('Track Issue'),
            ),
          ),
          Expanded(
              child:

                  */ /*material.Card(
                  child: material.DataTable(


                      headingRowColor: material.MaterialStateProperty.resolveWith((states) => Color(0xFFE0E0E0)),
                      */ /* */ /*onSelectAll: (b) {
                        setState(() {
                          if (b!) {
                            currentIndex = lstIssue.map((e) => lstIssue.indexOf(e)).toList();
                          } else {
                            currentIndex = [];
                          }
                        });
                      },*/ /* */ /*
                      sortAscending: isAscending,
                      sortColumnIndex: sortColumnIndex,
                      showCheckboxColumn: true,
                      columns: columns
                          .map((e) => material.DataColumn(
                                label: Text(e),
                                tooltip: e,
                                numeric: e == 'Oder Id',
                                onSort: e != 'Action'
                                    ? (columnIndex, ascending) {
                                        setState(() {
                                          sortColumnIndex = columnIndex;
                                          isAscending = ascending;
                                          if (ascending) {
                                            lstIssue.sort((a, b) {
                                              if (columnIndex == 0) {
                                                return a.orderId.compareTo(b.orderId);
                                              } else if (columnIndex == 1) {
                                                return a.orderDate.compareTo(b.orderDate);
                                              } else if (columnIndex == 2) {
                                                return a.issueType.compareTo(b.issueType);
                                              } else if (columnIndex == 3) {
                                                return a.reportedAt.compareTo(b.reportedAt);
                                              } else if (columnIndex == 4) {
                                                return a.resolutionStatus.compareTo(b.resolutionStatus);
                                              } else if (columnIndex == 5) {
                                                return a.resolvedAt!.compareTo(b.resolvedAt!);
                                              }
                                              return 0;
                                            });
                                          } else {
                                            lstIssue.sort((a, b) {
                                              if (columnIndex == 0) {
                                                return b.orderId.compareTo(a.orderId);
                                              } else if (columnIndex == 1) {
                                                return b.orderDate.compareTo(a.orderDate);
                                              } else if (columnIndex == 2) {
                                                return b.issueType.compareTo(a.issueType);
                                              } else if (columnIndex == 3) {
                                                return b.reportedAt.compareTo(a.reportedAt);
                                              } else if (columnIndex == 4) {
                                                return b.resolutionStatus.compareTo(a.resolutionStatus);
                                              } else if (columnIndex == 5) {
                                                return b.resolvedAt!.compareTo(a.resolvedAt!);
                                              }
                                              return 0;
                                            });
                                          }
                                        });
                                      }
                                    : null,
                              ))
                          .toList(),
                      rows: lstIssue
                          .map(
                            (e) => material.DataRow(
                              onSelectChanged: (b) {
                                setState(() {
                                  currentIndex = [lstIssue.indexOf(e)];
                                });
                              },
                              color: material.MaterialStateProperty.resolveWith((Set<material.MaterialState> states) {
                                if (states.contains(material.MaterialState.selected)) return FluentTheme.of(context).accentColor.withOpacity(0.08);
                                if (lstIssue.indexOf(e) % 2 == 0) return Colors.grey.withOpacity(0.3);
                                return null;
                              }),
                              selected: currentIndex.contains(lstIssue.indexOf(e)),
                              cells: [
                                material.DataCell(
                                  Text(e.orderId.toString()),
                                ),
                                material.DataCell(Text(e.orderDate.toString())),
                                material.DataCell(Text(e.issueType)),
                                material.DataCell(Text(e.reportedAt.toString())),
                                material.DataCell(
                                  Text(e.resolutionStatus),
                                ),
                                material.DataCell(Text(e.resolvedAt?.toString() ?? '-')),
                                material.DataCell(IconButton(
                                  icon: Icon(FluentIcons.edit),
                                  onPressed: () {},
                                )),
                              ],
                            ),
                          )
                          .toList()))),*/ /*



          */ /*CustomScrollView(
              slivers: [
                ...lstIssue
                    .map((e) {
                      return [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              title: Text(e.date.toString()),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Column(children: [
                                Card(
                                  padding: EdgeInsets.all(0),
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text(e.lstIssues[index].issueType),
                                  ),
                                )
                              ]);
                            },
                            childCount: e.lstIssues.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(height: 200),
                        ),
                      ];
                    })
                    .expand((element) => element)
                    .toList(),
              ],
            ),*/ /*

          */ /*ListView.builder(
            itemCount: lstIssue.length,
            itemBuilder: (context, index) {
              List<TrackIssueModel> lstIssueTemp1 = lstIssue[index].lstIssues;
              print('lstIssueTemp1');
              print(lstIssueTemp1);
              return Column(
                children: [
                  Text(lstIssue[index].date.toString()),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: lstIssue[index].lstIssues.length,
                    itemBuilder: (context, index2) {
                      return Card(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(lstIssue[index].lstIssues[index2].issueType),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          )*/ /*
        ],
      ),*/
            lstIssue.isNotEmpty ? RowLazyPaginationScreen(lstIssue: lstIssue) : Center(child: CircularProgressIndicator()));
  }
}

class TrackIssueByDateModel {
  final DateTime date;
  final List<TrackIssueModel> lstIssues;

  TrackIssueByDateModel({required this.date, required this.lstIssues});
}

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting("en");

  PostsRepository.generate(200);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        PagedDataTableLocalization.delegate
      ],
      supportedLocales: const [Locale("es"), Locale("en")],
      locale: const Locale("en"),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: Colors.deepPurple, secondary: Colors.teal),
          textTheme: GoogleFonts.robotoTextTheme(),
          cardTheme: CardTheme(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          popupMenuTheme: PopupMenuThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))),
      home: const MainView(),
    );
  }
}*/

class RowLazyPaginationScreen extends StatefulWidget {
  static const routeName = 'feature/row-lazy-pagination';

  final List<TrackIssueModel> lstIssue;

  const RowLazyPaginationScreen({Key? key, required this.lstIssue}) : super(key: key);

  @override
  State<RowLazyPaginationScreen> createState() => _RowLazyPaginationScreenState();
}

class _RowLazyPaginationScreenState extends State<RowLazyPaginationScreen> {
  late final PlutoGridStateManager stateManager;

  final List<PlutoColumn> columns = [];

  // Pass an empty row to the grid initially.
  final List<PlutoRow> rows = [];

  final List<PlutoRow> fakeFetchedRows = [];
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();

    DateTime start = DateTime.now();
    DateTime end = DateTime.now().add(Duration(days: 30));

    widget.lstIssue.forEach((element) {
      if (startDate == null || startDate!.isAfter(element.orderDate)) {
        startDate = element.orderDate;
      }
      if (endDate == null || endDate!.isBefore(element.orderDate)) {
        endDate = element.orderDate;
      }
    });

    setState(() {
      startDate = start;
      endDate = end;
    });

    // Instead of fetching data from the server,
    // Create a fake row in advance.
    fakeFetchedRows.addAll(
      List.generate(
        widget.lstIssue.length,
        (index) => PlutoRow(
          cells: {
            'order_id': PlutoCell(value: widget.lstIssue[index].orderId),
            'order_date': PlutoCell(value: widget.lstIssue[index].orderDate),
            'issue_type': PlutoCell(value: TrackIssueModel.getTypeString(widget.lstIssue[index].issueType)),
            'reported_at': PlutoCell(value: widget.lstIssue[index].reportedAt),
            'status': PlutoCell(value: TrackIssueModel.getStatusString(widget.lstIssue[index].resolutionStatus)),
            'resolved_at': PlutoCell(value: widget.lstIssue[index].resolvedAt ?? '-'),
          },
        ),
      ),
    );
  }

  Future<PlutoLazyPaginationResponse> fetch(
    PlutoLazyPaginationRequest request,
  ) async {
    List<PlutoRow> tempList = fakeFetchedRows;

    // If you have a filtering state,
    // you need to implement it so that the user gets data from the server
    // according to the filtering state.
    //
    // request.page is 1 when the filtering state changes.
    // This is because, when the filtering state is changed,
    // the first page must be loaded with the new filtering applied.
    //
    // request.filterRows is a List<PlutoRow> type containing filtering information.
    // To convert to Map type, you can do as follows.
    //
    // FilterHelper.convertRowsToMap(request.filterRows);
    //
    // When the filter of abc is applied as Contains type to column2
    // and 123 as Contains type to column3, for example
    // It is returned as below.
    // {column2: [{Contains: 123}], column3: [{Contains: abc}]}
    //
    // If multiple filtering conditions are set in one column,
    // multiple conditions are included as shown below.
    // {column2: [{Contains: abc}, {Contains: 123}]}
    //
    // The filter type in FilterHelper.defaultFilters is the default,
    // If there is user-defined filtering,
    // the title set by the user is returned as the filtering type.
    // All filtering can change the value returned as a filtering type by changing the name property.
    // In case of PlutoFilterTypeContains filter, if you change the static type name to include
    // PlutoFilterTypeContains.name = 'include';
    // {column2: [{include: abc}, {include: 123}]} will be returned.
    if (request.filterRows.isNotEmpty) {
      final filter = FilterHelper.convertRowsToFilter(
        request.filterRows,
        stateManager.refColumns,
      );

      tempList = fakeFetchedRows.where(filter!).toList();
    }

    // If there is a sort state,
    // you need to implement it so that the user gets data from the server
    // according to the sort state.
    //
    // request.page is 1 when the sort state changes.
    // This is because when the sort state changes,
    // new data to which the sort state is applied must be loaded.
    if (request.sortColumn != null && !request.sortColumn!.sort.isNone) {
      tempList = [...tempList];

      tempList.sort((a, b) {
        final sortA = request.sortColumn!.sort.isAscending ? a : b;
        final sortB = request.sortColumn!.sort.isAscending ? b : a;

        return request.sortColumn!.type.compare(
          sortA.cells[request.sortColumn!.field]!.valueForSorting,
          sortB.cells[request.sortColumn!.field]!.valueForSorting,
        );
      });
    }

    final page = request.page;
    const pageSize = 100;
    final totalPage = (tempList.length / pageSize).ceil();
    final start = (page - 1) * pageSize;
    final end = start + pageSize;

    Iterable<PlutoRow> fetchedRows = tempList.getRange(
      max(0, start),
      min(tempList.length, end),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    return Future.value(PlutoLazyPaginationResponse(
      totalPage: totalPage,
      rows: fetchedRows.toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: fluent.LayoutBuilder(
        builder: (context, constraint) {
          double widthColumn = 120;
          if (ResponsiveHelper.isDesktop(context)) {
            widthColumn = (constraint.maxWidth - 100) / 5;
          }
          return PlutoGrid(
            /*rowColorCallback: (row) {
          print(row.row.cells['status']!.value);
          */ /*if (row.row.cells['status']!.value == 'Resolved') {
            return Colors.green.shade100;
          } else if (row.row.cells['status']!.value == 'In Progress') {
            return Colors.yellow.shade100;
          } else if (row.row.cells['status']!.value == 'Ignored') {
            return Colors.grey.shade100;
          }
          return Colors.red.shade300;*/ /*
          switch (row.row.cells['status']!.value) {
            case 'Resolved':
              return Colors.green.shade100;
            case 'In Progress':
              return Colors.yellow.shade100;
            case 'Ignored':
              return Colors.grey.shade100;
            case 'Unresolved':
              return Colors.red.shade300;
            default:
              return Colors.transparent;
          }
        },*/
            noRowsWidget: Center(
              child: Text('No rows'),
            ),
            mode: PlutoGridMode.normal,
            columns: [
              PlutoColumn(
                width: 100,
                enableEditingMode: false,
                readOnly: true,
                title: 'Order ID',
                field: 'order_id',
                type: PlutoColumnType.number(negative: false, format: '#'),
                enableRowDrag: false,
                enableRowChecked: false,
              ),
              PlutoColumn(
                width: widthColumn,
                enableEditingMode: false,
                readOnly: true,
                title: 'Order Date',
                field: 'order_date',
                type: PlutoColumnType.date(
                  startDate: startDate,
                  endDate: endDate,
                ),
              ),
              PlutoColumn(
                width: widthColumn > 150 ? widthColumn : 150,
                enableEditingMode: false,
                readOnly: true,
                title: 'Issue Type',
                field: 'issue_type',
                type: PlutoColumnType.text(),
              ),
              PlutoColumn(
                width: widthColumn,
                enableEditingMode: false,
                readOnly: true,
                title: 'Reported At',
                field: 'reported_at',
                type: PlutoColumnType.date(),
              ),
              PlutoColumn(
                width: widthColumn > 150 ? widthColumn : 150,
                enableAutoEditing: true,
                title: 'Status',
                field: 'status',
                renderer: (rendererContext) {
                  final value = rendererContext.row.cells['status']!.value;
                  return Container(
                    height: 30,
                    width: 150,
                    child: fluent.Button(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(value,
                              style: TextStyle(
                                  color: value == 'Unresolved'
                                      ? Colors.red
                                      : value == 'In progress'
                                          ? Colors.yellow
                                          : value == 'Resolved'
                                              ? Colors.green
                                              : Colors.grey)),
                          Icon(fluent.FluentIcons.chevron_down),
                        ],
                      ),
                      onPressed: () async {
                        String? value = rendererContext.row.cells['status']!.value;
                        if (value == 'In Progress') {
                          context.read<TrackIssueProvider>().updateSelectedIndex(1);
                        } else if (value == 'Resolved') {
                          context.read<TrackIssueProvider>().updateSelectedIndex(2);
                        } else if (value == 'Ignored') {
                          context.read<TrackIssueProvider>().updateSelectedIndex(3);
                        } else {
                          context.read<TrackIssueProvider>().updateSelectedIndex(0);
                        }

                        String? res = await fluent.showDialog<String?>(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return fluent.ContentDialog(
                              title: Text('Select Status'),
                              content: fluent.Column(
                                mainAxisSize: fluent.MainAxisSize.min,
                                children: [
                                  fluent.ListTile.selectable(
                                    selected: context.watch<TrackIssueProvider>().selectedIndex == 0,
                                    title: Text(
                                      'Unresolved',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      context.read<TrackIssueProvider>().updateSelectedIndex(0);
                                    },
                                  ),
                                  fluent.ListTile.selectable(
                                    selected: context.watch<TrackIssueProvider>().selectedIndex == 1,
                                    title: Text(
                                      'In Progress',
                                      style: TextStyle(color: Colors.yellow),
                                    ),
                                    onPressed: () {
                                      context.read<TrackIssueProvider>().updateSelectedIndex(1);
                                    },
                                  ),
                                  fluent.ListTile.selectable(
                                    selected: context.watch<TrackIssueProvider>().selectedIndex == 2,
                                    title: Text('Resolved', style: TextStyle(color: Colors.green)),
                                    onPressed: () {
                                      context.read<TrackIssueProvider>().updateSelectedIndex(2);
                                    },
                                  ),
                                  fluent.ListTile.selectable(
                                    selected: context.watch<TrackIssueProvider>().selectedIndex == 3,
                                    title: Text('Ignored', style: TextStyle(color: Colors.grey)),
                                    onPressed: () {
                                      context.read<TrackIssueProvider>().updateSelectedIndex(3);
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                fluent.FilledButton(
                                  onPressed: () {
                                    String? value;
                                    if (context.read<TrackIssueProvider>().selectedIndex == 0) {
                                      value = 'Unresolved';
                                    } else if (context.read<TrackIssueProvider>().selectedIndex == 1) {
                                      value = 'In progress';
                                    } else if (context.read<TrackIssueProvider>().selectedIndex == 2) {
                                      value = 'Resolved';
                                    } else if (context.read<TrackIssueProvider>().selectedIndex == 3) {
                                      value = 'Ignored';
                                    }
                                    Navigator.of(context).pop(value);
                                  },
                                  child: Text('Confirm'),
                                ),
                                fluent.Button(
                                  onPressed: () {
                                    Navigator.of(context).pop(null);
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );

                        if (res != null && res != value) {
                          final event = rendererContext;
                          int orderId = event.row.cells['order_id']!.value;
                          print(orderId);
                          DateTime orderDate = DateTime.parse(event.row.cells['order_date']!.value);
                          print(orderDate);

                          print(event.row.cells);

                          bool resReq = await context.read<TrackIssueProvider>().updateTrackIssue(orderId, orderDate, TrackIssueModel.getStatusFromString(res));
                          if (resReq) {
                            setState(() {
                              event.row.cells['status']!.value = res;
                              event.row.cells['resolved_at']!.value = DateHelper.getFormattedDate(DateTime.now());
                            });
                            await fluent.displayInfoBar(
                              context,
                              builder: (context, close) {
                                return fluent.InfoBar(
                                  title: Text('Status updated successfully'),
                                  action: IconButton(
                                    icon: const Icon(fluent.FluentIcons.clear),
                                    onPressed: close,
                                  ),
                                  severity: fluent.InfoBarSeverity.success,
                                );
                              },
                              alignment: fluent.Alignment.topRight,
                            );
                          } else {
                            await fluent.displayInfoBar(
                              context,
                              builder: (context, close) {
                                return fluent.InfoBar(
                                  title: Text('Ouch! Something went wrong'),
                                  action: IconButton(
                                    icon: const Icon(fluent.FluentIcons.clear),
                                    onPressed: close,
                                  ),
                                  severity: fluent.InfoBarSeverity.error,
                                );
                              },
                              alignment: fluent.Alignment.topRight,
                            );
                          }
                          print(res);
                        }
                      },
                    ),
                  );
                },
                type: PlutoColumnType.text(),
              ),
              PlutoColumn(
                width: widthColumn > 180 ? widthColumn : 180,
                enableEditingMode: false,
                readOnly: true,
                title: 'Resolved At',
                field: 'resolved_at',
                // format :
                type: PlutoColumnType.date(
                  format: 'yyyy-MM-dd HH:mm:ss',
                ),
              ),
            ],
            rows: rows,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
              stateManager.setShowColumnFilter(true);
            },
            configuration: context.watch<ThemeProvider>().themeMode == 'dark'
                ? PlutoGridConfiguration.dark(
                    columnSize: PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.none),
                    enableMoveHorizontalInEditing: true,
                    scrollbar: PlutoGridScrollbarConfig(
                      isAlwaysShown: false,
                      dragDevices: PointerDeviceKind.values.toSet(),
                    ),
                    enableMoveDownAfterSelecting: true,
                    style: PlutoGridStyleConfig.dark(
                      oddRowColor: fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor!,
                      evenRowColor: fluent.FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor!,
                    ),
                  )
                : PlutoGridConfiguration(
                    enableMoveHorizontalInEditing: true,
                    scrollbar: PlutoGridScrollbarConfig(
                      isAlwaysShown: false,
                      dragDevices: PointerDeviceKind.values.toSet(),
                    ),
                    enableMoveDownAfterSelecting: true,
                    style: PlutoGridStyleConfig(
                      oddRowColor: fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor!,
                      evenRowColor: fluent.FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor!,
                      iconColor: Colors.black,
                      enableColumnBorderVertical: false,
                      enableCellBorderVertical: false,
                      enableRowColorAnimation: true,
                      gridBackgroundColor: fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor!,
                      activatedColor: fluent.FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor!,
                      cellColorInEditState: fluent.FluentTheme.of(context).navigationPaneTheme.overlayBackgroundColor!,
                      menuBackgroundColor: fluent.FluentTheme.of(context).navigationPaneTheme.backgroundColor!,
                      gridBorderColor: Colors.transparent,
                      columnTextStyle: fluent.FluentTheme.of(context).typography.body!,
                      cellTextStyle: fluent.FluentTheme.of(context).typography.body!,
                      filterHeaderColor: fluent.FluentTheme.of(context).typography.body!.color,
                    ),
                  ),
            createFooter: (stateManager) {
              return PlutoLazyPagination(
                // Determine the first page.
                // Default is 1.
                initialPage: 1,

                // First call the fetch function to determine whether to load the page.
                // Default is true.
                initialFetch: true,

                // Decide whether sorting will be handled by the server.
                // If false, handle sorting on the client side.
                // Default is true.
                fetchWithSorting: true,

                // Decide whether filtering is handled by the server.
                // If false, handle filtering on the client side.
                // Default is true.
                fetchWithFiltering: true,

                // Determines the page size to move to the previous and next page buttons.
                // Default value is null. In this case,
                // it moves as many as the number of page buttons visible on the screen.
                pageSizeToMove: null,
                fetch: fetch,
                stateManager: stateManager,
              );
            },
          );
        },
      ),
    );
  }
}
