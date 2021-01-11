import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:swallowing_app/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:swallowing_app/stores/profile_store.dart';
import 'package:swallowing_app/widgets/app_bar_widget.dart';
import 'package:swallowing_app/widgets/progress_indicator_widget.dart';
import 'package:swallowing_app/widgets/text_button_widget.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ProfileStore _profileStore;
  List<String> _question = ['ปัญหาการกลืนทำให้น้ำหนักตัวของฉันลดลง',
                            'ปัญหาการกลืนของฉันรบกวนการออกไปรับประทานอาหารนอกบ้าน',
                            'ฉันต้องใช้ความพยายามมากกว่าปกติเพื่อกลืนของเหลว',
                            'ฉันต้องใช้ความพยายามมากกว่าปกติเพื่อกลืนอาหาร',
                            'ฉันต้องใช้ความพยายามมากกว่าปกติเพื่อกลืนยาเม็ด ',
                            'ฉันรู้สึกเจ็บขณะกลืน',
                            'การกลืนของฉันส่งผลต่อความพึงพอใจในการรับประทานอาหาร',
                            'เมื่อฉันกลืนอาหาร ฉันรู้สึกเหมือนมีอาหารติดค้างในลําคอ',
                            'ฉันไอเมื่อรับประทานอาหาร',
                            'การกลืนทําให้ฉันรู้สึกเครียด'];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);

    if (!_profileStore.loading) {
      await _profileStore.getPatientProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('แบบทดสอบ', true),
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
        Observer(
          builder: (context) {
            return Visibility(
              visible: !_profileStore.loading && _profileStore.success,
              child: _buildMainContent(),
            );
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _profileStore.loading || !_profileStore.success,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index == 0) return _buildTestInfo();
        if (index == 11) return _buildSubmitButton();
        else return _buildQuestion(index-1);
      },
    );
  }

  Widget _buildTestInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'EAT-10: แบบคัดกรองการกลืน',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.deepblue),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'วัตถุประสงค์',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.deepblue),
          ),
          Text(
            'แบบประเมิน EAT-10 ใช้ประเมินภาวะกลืนลำบาก ซึ่งคุณอาจจำเป็นต้องพบแพทย์เพื่อปรึกษาแนวทางการรักษาที่เหมาะสมต่อไป',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'วิธีทำแบบประเมิน',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.deepblue),
          ),
          Text(
            'คุณมีปัญหาการกลืนตามหัวข้อต่อไปนี้ในระดับใด',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${index+1}.  ${_question[index]}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.deepblue),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
              padding: EdgeInsets.only(left: 40),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Observer(
                            builder: (context) {
                              return Radio(
                                value: 0,
                                groupValue: _profileStore.score[index] ?? 0,
                                activeColor: AppColors.deepblue,
                                onChanged: (int value) {
                                  setState(() {
                                    _profileStore.score[index] = value;
                                  });
                                },
                              );
                            },
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '0 - ไม่มีปัญหา',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Observer(
                            builder: (context) {
                              return Radio(
                                value: 1,
                                groupValue: _profileStore.score[index] ?? 0,
                                activeColor: AppColors.deepblue,
                                onChanged: (int value) {
                                  setState(() {
                                    _profileStore.score[index] = value;
                                  });
                                },
                              );
                            },
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '1',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Observer(
                            builder: (context) {
                              return Radio(
                                value: 2,
                                groupValue: _profileStore.score[index] ?? 0,
                                activeColor: AppColors.deepblue,
                                onChanged: (int value) {
                                  setState(() {
                                    _profileStore.score[index] = value;
                                  });
                                },
                              );
                            },
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '2',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Observer(
                            builder: (context) {
                              return Radio(
                                value: 3,
                                groupValue: _profileStore.score[index] ?? 0,
                                activeColor: AppColors.deepblue,
                                onChanged: (int value) {
                                  setState(() {
                                    _profileStore.score[index] = value;
                                  });
                                },
                              );
                            },
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '3',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Observer(
                            builder: (context) {
                              return Radio(
                                value: 4,
                                groupValue: _profileStore.score[index] ?? 0,
                                activeColor: AppColors.deepblue,
                                onChanged: (int value) {
                                  setState(() {
                                    _profileStore.score[index] = value;
                                  });
                                },
                              );
                            },
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '4 - มีปัญหารุนแรง',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.black),
                      ),
                    ],
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: TextButtonWidget(
        buttonText: 'ส่งแบบทดสอบ',
        buttonColor: AppColors.deepblue,
        textStyle: TextStyle(
          fontSize: 18,
          color: AppColors.white),
        onPressed: () {
          _profileStore.submitTestScore(_profileStore.score);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                int score = _calculateTotalScore(_profileStore.score);
                return _buildResultPopUp(score);
              }
          );
        }
      ),
    );
  }

  Widget _buildResultPopUp(int score) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        backgroundColor: AppColors.deepblue,
        elevation: 5,
        content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width-100,
              maxHeight: 310,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close, color: AppColors.white, size: 26),
                  ),
                ),
                Text(
                  'คะแนนของคุณ',
                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 19),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.all(25),
                      width: 150,
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(score.toString(), style: TextStyle(color: AppColors.deepblue, fontSize: 40, fontWeight: FontWeight.w500)),
                          Text('  / 40', style: TextStyle(color: AppColors.deepblue, fontSize: 23))
                        ],
                      ),
                    )
                ),
                Text(
                  'หากคุณได้รับคะแนนรวมของแบบประเมิน EAT-10 ตั้งแต่ 3 คะแนนขึ้นไป คุณอาจมีปัญหาการกลืนที่ไม่มีประสิทธิภาพและไม่ปลอดภัย แนะนำให้คุณนำผลการประเมิน EAT-10 ไปพบแพทย์',
                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: 16),
                ),
              ],
            )
        )
    );
  }

  int _calculateTotalScore(List<int> score) {
    int totalScore = 0;
    for (var i = 0; i < 10; i++) {
      totalScore += score[i];
    }
    return totalScore;
  }
}