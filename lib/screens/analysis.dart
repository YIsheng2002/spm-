import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/bottomNavbar/bottomNavBar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/model/UserResult.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});



  @override
  State<Analysis> createState() => _MyAppState();
}

class _MyAppState extends State<Analysis> {
  final Color leftBarColor = Colors.green;
  final Color rightBarColor = Colors.red;
  final Color avgColor = Colors.orange;

  var db = FirebaseFirestore.instance;

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;
  int userResultLenght = 0;
  bool isPlaying = false;

  List<UserResult> userResults = [];
  List<ChapterResult> chapterResults = [];


  Future<void> fetchUserResult() async {
    print("asdasdasd");
    try {
      final userResultRef = db.collection("UserResult");
      final querySnapshot = await userResultRef
          .where("userId", isEqualTo: "UID1")
          .get();

      userResults.clear(); // Clear the userResults list
      chapterResults.clear(); // Clear the chapterResults list

      for (var userResultDoc in querySnapshot.docs) {
        final userResultData = userResultDoc.data() as Map<String, dynamic>;
        final userResult = UserResult(
          id: userResultDoc.id,
          userId: userResultData["userId"],
          examId: userResultData["examId"],
          timeStamp: userResultData["timeStamp"],
          totalResult: userResultData["totalResult"],
        );
        userResults.add(userResult);
        print(userResult);

        final chaptersRef =
        userResultDoc.reference.collection("ChapterResult");
        final chapterQuerySnapshot = await chaptersRef.get();

        for (var chapterDoc in chapterQuerySnapshot.docs) {
          final chapterData = chapterDoc.data() as Map<String, dynamic>;
          final chapterResult = ChapterResult(
            id: chapterDoc.id,
            correctAnswer: chapterData["correctAnswer"],
            incorrectAnswer: chapterData["incorrectAnswer"],
          );
          chapterResults.add(chapterResult);
          userResultLenght = chapterResults.length!;
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserResult(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Analysis for each chapter',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Total Correct Question',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 38,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: BarChart(
                            mainBarData(),
                            swapAnimationDuration: animDuration,

                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Provide a loading indicator or placeholder here
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    barColor ??= Colors.green;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,

          width: width,

          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 10,
            color: Colors.red,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }


  List<BarChartGroupData> showingGroups() => List.generate(userResultLenght, (i) {
    double y = chapterResults[i].correctAnswer.toDouble();
    return makeGroupData(i, y, isTouched:  i ==touchedIndex);



  });


  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String chapterName="";


              chapterName = chapterResults[groupIndex].id;



            return BarTooltipItem(
              '$chapterName\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(

                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 6,
    );
    Widget text;




    int index = value.toInt();
    if (index < 0 || index >= chapterResults.length) {
      text = const Text('', style: style);
    } else {
      int count = value.toInt();
      String chapterName = "";
      chapterName = chapterResults[count].id;
      text = Text(chapterName, style: style,);

    }
    //switch (value.toInt()) {
      // case 0:
      //   text = const Text('M', style: style);
      //   break;
      // case 1:
      //   text = const Text('T', style: style);
      //   break;
      // case 2:
      //   text = const Text('W', style: style);
      //   break;
      // case 3:
      //   text = const Text('T', style: style);
      //   break;
      // case 4:
      //   text = const Text('F', style: style);
      //   break;
      // case 5:
      //   text = const Text('S', style: style);
      //   break;
      // case 6:
      //   text = const Text('S', style: style);
      //   break;
      // default:
      //   text = const Text('', style: style);
      //   break;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }



}