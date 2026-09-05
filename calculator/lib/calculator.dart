import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  var userInput='';
  var answer='0';
  final List<String>buttons=
  ['7','8','9','DEL',
   '4','5','6','+',
   '1','2','3','-',
   '.','0','/','*',
   'RESET','='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 90, 154),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(userInput,style: TextStyle(color: Colors.white,fontSize: 25),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(answer,style: TextStyle(color: Colors.white,fontSize: 25),),
                   )
              ],
            ),
            
            
            // child: Text(userInput,style: TextStyle(color: Colors.white,fontSize: 45),),
           ),
         ),
         SizedBox(height: 20,),
         Expanded(
           child: Container(
            height: 450,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 12,crossAxisSpacing: 12), 
              itemCount: buttons.length,
              itemBuilder: (BuildContext context,int index)
              {
                // RESET BUTTON
              if(buttons[index]=='RESET')
              {
                return ButtonWidget(label: buttons[index],
                color: Colors.green,
                textColor: Colors.white,
                tapped: () {
                  setState(() {
                    userInput='';
                    answer='0';
                    
                  });
                  
                },
                );
              }

              //DELETE BUTTON
              else if (buttons[index] == 'DEL') {
                    return ButtonWidget(
                      tapped: () { setState(() { if (userInput.isNotEmpty) { userInput = userInput.substring(0, userInput.length - 1); } }); },
                      label: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                    );
                  }

                  else if (buttons[index] == '=') {
                      return ButtonWidget(
                        label: buttons[index],
                        color: Colors.orange,
                        textColor: Colors.white,
                        tapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                      );
                    }
              else
              {
              return ButtonWidget(
              label: buttons[index],
              color: Colors.white,
              textColor:Colors.black,
              tapped: () {
                setState(() {
                  userInput+=buttons[index];
                });
              },);
              }
              }
              ),
            ),
           ),
         )
        ],
      ),
    );
  }
   void equalPressed() {
    if(userInput.isEmpty)return;
    try{
      Parser p=Parser();
      Expression exp=p.parse(userInput);
      ContextModel cm=ContextModel();
      double eval=exp.evaluate(EvaluationType.REAL, cm);

      answer=eval.toString();
    }
    catch(e)
    {
      answer='Error';
    }
  }
}