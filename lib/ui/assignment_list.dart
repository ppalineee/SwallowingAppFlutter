import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/routes.dart';
import 'package:swallowing_app/stores/assignment_store.dart';
import 'package:swallowing_app/ui/assignment.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/assignment_status_widget.dart';
import 'package:swallowing_app/widgets/nav_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';
import 'package:swallowing_app/widgets/text_button_widget.dart';
import 'package:swallowing_app/utils/date_format.dart';

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
            Expanded(
              child: LiquidPullToRefresh(
                height: 80,
                animSpeedFactor: 2,
                color: AppColors.lightgray,
                showChildOpacityTransition: false,
                onRefresh: _refresh,
                child: _buildAssignmentListBody()
              ),
            )
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
    return FutureBuilder<AssignmentList>(
      future: _assignmentStore.getAssignmentList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final _assignmentList = snapshot.data.assignments;
          if (_assignmentList.length > 0) {
            return Container(
                padding: EdgeInsets.fromLTRB(15, 7, 15, 12),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: _assignmentList.length,
                  itemBuilder: (context, index) {
                    int i = _assignmentList.length - index - 1;
                    Assignment assignment = _assignmentList[i];
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AssignmentScreen(
                                    assignment: assignment,
                                    assignmentStore: _assignmentStore,
                                  )
                              )
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    assignment.title,
                                    style: TextStyle(fontSize: 15)
                                ),
                              ),
                            ),
                            Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text(
                                  DateFormats.changeThaiShortFormat(assignment.timestamp),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15)
                              ),
                            ),
                            Container(
                              width: 80,
                              alignment: Alignment.center,
                              child: Text(
                                  DateFormats.changeThaiShortFormat(assignment.dueDate),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15)
                              ),
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

  Future<void> _refresh() async {
    setState(() {});
  }
}