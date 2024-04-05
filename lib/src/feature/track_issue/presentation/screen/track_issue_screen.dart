import 'package:admin_dashboard/src/feature/track_issue/data/model/track_issue_model.dart';
import 'package:admin_dashboard/src/feature/track_issue/presentation/provider/track_issue_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';

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
      child: Column(
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
              child: material.Card(
                  child: material.DataTable(
                      headingRowColor: material.MaterialStateProperty.resolveWith((states) => Color(0xFFE0E0E0)),
                      /*onSelectAll: (b) {
                        setState(() {
                          if (b!) {
                            currentIndex = lstIssue.map((e) => lstIssue.indexOf(e)).toList();
                          } else {
                            currentIndex = [];
                          }
                        });
                      },*/
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
                          .toList()))),

          /*CustomScrollView(
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
            ),*/

          /*ListView.builder(
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
          )*/
        ],
      ),
    );
  }
}

class TrackIssueByDateModel {
  final DateTime date;
  final List<TrackIssueModel> lstIssues;

  TrackIssueByDateModel({required this.date, required this.lstIssues});
}
