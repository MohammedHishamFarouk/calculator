import 'dart:developer';

import 'package:calculator/button_widget.dart';
import 'package:flutter/material.dart';

import 'buttons_text.dart';

class CalcScreen extends StatefulWidget{
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String firstNum = '';
  String secondNum = '';
  String operator = '';
  double result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/3,
              child:Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                      firstNum.isEmpty?'0':'$firstNum$operator$secondNum',
                    style:const TextStyle(
                      fontSize: 70
                    ),
                  ),
                ),
              )
            ),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: buttons()
              ),
            )
          ],
        ),
      ),
    );
  }

  List<ButtonWidget>buttons(){
    List<ButtonWidget>buttonsWidget = [];
    for(var n in Btn.btnMap.entries){
      if(n.value == '='){
        buttonsWidget.add(
          ButtonWidget(
          text: n.value,
          screenDivision: 2,
          background: Colors.orange,
          onPressed: () {
            getResults();
          },
          ),
        );
      }else if(n.value == 'x'||n.value == '-'||n.value == '+'||n.value == '÷'){
        buttonsWidget.add(
          ButtonWidget(
          text: n.value,
          screenDivision: 4,
          background: Colors.orange,
           onPressed: () {
            if(secondNum.isNotEmpty && secondNum != '-'){
              getResults();
            }
             addOp(n.value);
           }
          ),
        );
      }else if(n.value == 'del'||n.value == 'C'||n.value == '%'){
        buttonsWidget.add(
          ButtonWidget(
          text: n.value,
          screenDivision: 4,
          background: Colors.grey.withOpacity(0.9),
          onPressed: () {
            delete(n.value);
          },
          ),
        );
      }else{
        buttonsWidget.add(
          ButtonWidget(
            text: n.value,
            screenDivision: 4,
            background: Colors.transparent,
            onPressed: () {
              addNumbers(n.value);
              },
          ),
        );
      }
    }
    return buttonsWidget;
  }

  void addNumbers(String value){
    setState(() {
      if(operator.isEmpty){
        if(value == '.'){
          if(!firstNum.contains('.')){
            if(firstNum.isEmpty || firstNum == '-'){
              firstNum += '0.';
            }else{
              firstNum += value;
            }
          }
        }else{
          firstNum += value;
        }
      }else{
        if(value == '.'){
          if(!secondNum.contains('.')){
            if(secondNum.isEmpty || secondNum == '-'){
              secondNum += '0.';
            }else{
              secondNum += value;
            }
          }
        }else{
          secondNum += value;
        }
      }
    });
  }

  void addOp(String value){
    setState(() {});
    if(firstNum.isNotEmpty && firstNum != '.' && firstNum != '-' && operator.isEmpty){
      operator = value;
    }else if(firstNum.isEmpty && value == '-'){
      firstNum += value;
    }else if(secondNum.isEmpty && value == '-' && operator.isNotEmpty){
      secondNum += value;
    }
  }

  void getResults(){
    if(secondNum.isNotEmpty && secondNum != '-'){
      setState(() {});
      try{
        switch(operator){
          case '+':
            result = double.parse(firstNum) + double.parse(secondNum);
          case '-':
            result = double.parse(firstNum) - double.parse(secondNum);
          case 'x':
            result = double.parse(firstNum) * double.parse(secondNum);
          case '÷':
            result = double.parse(firstNum) / double.parse(secondNum);
        }
        operator = '';
        secondNum = '';
        firstNum = result.toString();
      }catch(e){
        log(e.toString());
      }
    }
  }

  void delete(String value){
    setState(() {});
    if(value == 'C'){
      firstNum = secondNum = operator = '';
      result = 0;
    }else if(value == 'del'){
      if(secondNum.isNotEmpty){
        secondNum = secondNum.substring(0,secondNum.length-1);
      }else if(operator.isNotEmpty){
        operator = '';
      }else if(firstNum.isNotEmpty){
        firstNum = firstNum.substring(0,firstNum.length-1);
      }
    }else{
      double number = 0;
      if(secondNum.isNotEmpty && secondNum != '-'){
        number = double.parse(secondNum)/100;
        secondNum = number.toString();
      }else if(firstNum.isNotEmpty && firstNum != '-' && operator.isEmpty){
        number = double.parse(firstNum)/100;
        firstNum = number.toString();
      }
    }
  }

}