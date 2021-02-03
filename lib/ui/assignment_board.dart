import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/stores/assignment_store.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/post_widget.dart';

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
        // _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return FutureBuilder<AssignmentList>(
      future: _assignmentStore.getAssignments(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final _assignmentList = snapshot.data.assignments;
          return Stack(
              children: <Widget>[
                Container(
                  color: AppColors.lightgray,
                  width: MediaQuery.of(context).size.width,
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _assignmentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      int i = _assignmentList.length - index - 1;
                      return PostWidget(assignment: _assignmentList[i]);
                    }
                )
              ]
          );
        } else if (snapshot.hasError) {
          return Center(
              child: Icon(
                Icons.no_photography_outlined,
                size: 40,
                color: Colors.white,
              )
          );
        } else {
          return Center(
              child: CircularProgressIndicator()
          );
        }
      },
    );
  }
}