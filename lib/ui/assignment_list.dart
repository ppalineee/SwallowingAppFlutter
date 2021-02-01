import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/stores/assignment_store.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/assignment_status_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';
import 'package:swallowing_app/widgets/text_button_widget.dart';

class AssignmentListScreen extends StatefulWidget {
  @override
  _AssignmentListScreenState createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  AssignmentStore _assignmentStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _assignmentStore = Provider.of<AssignmentStore>(context);

    if (!_assignmentStore.loading) {
      await _assignmentStore.getAssignmentList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('แบบฝึกหัด', false),
      body: _buildBody(),
      bottomNavigationBar: Navbar(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Observer(
          builder: (context) {
            return Visibility(
              visible: !_assignmentStore.loading && _assignmentStore.success,
              child: _buildMainContent(),
            );
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _assignmentStore.loading || !_assignmentStore.success,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            _buildAssignmentBoardBtn(),
            SizedBox(
              height: 12,
            ),
            _buildAssignmentListHeader(),
            _buildAssignmentListBody()
          ],
        )
    );
  }
  Widget _buildAssignmentBoardBtn() {
    return Align(
      alignment: Alignment.center,
      child: TextButtonWidget(
        buttonText: 'กระดานแบบฝึกหัด',
        buttonColor: AppColors.deepblue,
        textStyle: TextStyle(
            fontFamily: FontFamily.kanit,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.assignment_board);
        },
      ),
    );
  }

  Widget _buildAssignmentListHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.symmetric(horizontal: BorderSide(width: 0.5, color: AppColors.gray)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5)
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text('หัวข้อ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            ),
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text('ได้รับ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text('กำหนดส่ง', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text('สถานะ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }

  Widget _buildAssignmentListBody() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 7, 15, 0),
        child: _assignmentStore.assignmentList != null
        ? ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: _assignmentStore.assignmentList.assignments.length,
          itemBuilder: (context, index) {
            int i = _assignmentStore.assignmentList.assignments.length - index - 1;
            Assignment assignment = _assignmentStore.assignmentList.assignments[i];
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.assignment);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(assignment.title, style: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: Text(assignment.timestamp, style: TextStyle(fontSize: 14)),
                    ),
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: Text(assignment.dueDate, style: TextStyle(fontSize: 14)),
                    ),
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      child: AssignmentStatusTextWidget(
                        status: assignment.status,
                        fontSize: 15
                      )
                    )
                  ],
                )
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.45,
              color: AppColors.gray,
            );
          },
        )
        : _handleNoAssignmentsFound()
      ),
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
}