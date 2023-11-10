import 'package:flutter/material.dart';

class Option extends StatefulWidget {
  final String opText;
  final int index;
  const Option({required this.opText, required this.index, Key? key}) : super(key:key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  bool selected = false;
  var bgColor = MaterialStateProperty.all<Color>(Colors.redAccent.shade200);
  var bgColorUnselected = MaterialStateProperty.all<Color>(Colors.grey);
  var bgColorSelected = MaterialStateProperty.all<Color>(Colors.green);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10
        ),
        child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
              //foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),

              backgroundColor: bgColor,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.red),
                  )
              )
          ),
          onPressed: (){setState(() {
            selected = true;
            bgColor = bgColorSelected;
            setSelected(true);
          });},
          child: Text(widget.opText,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
    );
  }

  int setSelected(bool selected){
    this.selected = selected;
    if (selected == true){
      bgColor = bgColorSelected;
    }
    else {
      bgColor = bgColorUnselected;
    }
    return widget.index;
  }
}
