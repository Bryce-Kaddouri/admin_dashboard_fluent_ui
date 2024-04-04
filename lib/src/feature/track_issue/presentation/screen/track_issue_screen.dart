import 'package:admin_dashboard/src/feature/track_issue/data/model/track_issue_model.dart';
import 'package:admin_dashboard/src/feature/track_issue/presentation/provider/track_issue_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class TrackIssueScreen extends StatefulWidget {
  const TrackIssueScreen({super.key});

  @override
  State<TrackIssueScreen> createState() => _TrackIssueScreenState();
}

class _TrackIssueScreenState extends State<TrackIssueScreen> {
  List<TrackIssueByDateModel> lstIssue = [];

  @override
  void initState() {
    super.initState();
    context.read<TrackIssueProvider>().getAllTrackIssues().then((value) {
      print('value');
      print(value);
      List<TrackIssueByDateModel> lstIssueTemp = [];
      if (value != null) {
        for (var issue in value) {
          DateTime date = issue.orderDate;
          if (lstIssueTemp.isEmpty) {
            lstIssueTemp.add(TrackIssueByDateModel(date: date, lstIssue: [issue]));
          } else {
            bool isExist = false;
            for (var item in lstIssueTemp) {
              if (item.date == date) {
                item.lstIssue.add(issue);
                isExist = true;
                break;
              }
            }
            if (!isExist) {
              lstIssueTemp.add(TrackIssueByDateModel(date: date, lstIssue: [issue]));
            } else {
              print('isExist');
              lstIssueTemp.firstWhere((element) => element.date == date).lstIssue.add(issue);
            }
          }
        }

        print('lstIssueTemp');
        print(lstIssueTemp);
        for (var item in lstIssueTemp) {
          print('item');
          print(item.lstIssue.length);
        }
        setState(() {
          lstIssue = lstIssueTemp;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Track Issue'),
          Expanded(
              child: ListView.builder(
            itemCount: lstIssue.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(lstIssue[index].date.toString()),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: lstIssue[index].lstIssue.length,
                    itemBuilder: (context, index2) {
                      Card(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(lstIssue[index].lstIssue[index2].issueType),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}

class TrackIssueByDateModel {
  final DateTime date;
  final List<TrackIssueModel> lstIssue;

  TrackIssueByDateModel({required this.date, required this.lstIssue});
}
