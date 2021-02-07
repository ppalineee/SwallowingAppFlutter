import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/stores/assignment_store.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/post_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';

class AssignmentBoardScreen extends StatefulWidget {
  @override
  _AssignmentBoardScreenState createState() => _AssignmentBoardScreenState();
}

class _AssignmentBoardScreenState extends State<AssignmentBoardScreen> {
  AssignmentStore _assignmentStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _assignmentStore = Provider.of<AssignmentStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('กระดานแบบฝึกหัด', true),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.lightgray,
          width: MediaQuery.of(context).size.width,
        ),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return FutureBuilder<AssignmentList>(
      future: _assignmentStore.getAssignments('123'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final _assignmentList = snapshot.data.assignments;
          if (_assignmentList.length > 0) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _assignmentList.length,
                itemBuilder: (BuildContext context, int index) {
                  int i = _assignmentList.length - index - 1;
                  return PostWidget(assignmentStore: _assignmentStore, assignment: _assignmentList[i]);
                }
            );
          } else {
            return _handleNoAssignmentsFound();
          }
        } else if (snapshot.hasError) {
          return _handleErrorMessage();
        } else {
          return Center(
              child: CustomProgressIndicatorWidget()
          );
        }
      },
    );
  }

  Widget _handleNoAssignmentsFound() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
              child: Icon(
                Icons.inbox,
                size: 50,
                color: Colors.black45,
              )
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'ไม่พบแบบฝึกหัดของคุณ...',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 20),
            ),
          )
        ]
    );
  }

  Widget _handleErrorMessage() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Icon(
                Icons.wifi_off,
                size: 50,
                color: Colors.black45,
              )
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'เครือข่ายขัดข้อง กรุณาเชื่อมต่อเครือข่าย',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 20),
            ),
          )
        ]
    );
  }
}