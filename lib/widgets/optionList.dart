import 'package:flutter/material.dart';
import 'package:testing/widgets/option.dart';

class OptionList extends StatefulWidget {
  const OptionList({super.key});

  @override
  State<OptionList> createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {

  @override
  Widget build(BuildContext context) {
    Option op1 = Option(opText: 'A', index: 0);
    Option op2 = Option(opText: 'B', index: 1);
    Option op3 = Option(opText: 'C', index: 2);
    Option op4 = Option(opText: 'D', index: 3);
    List<Option> opList= [];
    opList.add(op1);
    opList.add(op2);
    opList.add(op3);
    opList.add(op4);


    return GridView.count(
      padding:  const EdgeInsets.all(20),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: opList,
    );
  }
}
