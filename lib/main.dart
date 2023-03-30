import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}
class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Calculator",
      theme: ThemeData(primarySwatch: Colors.teal),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {

  SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation='0';

  String result='0';

  String expression='';

  double equationFontSize=38.0;

  double resultFontSize=48.0;

  buttonPressed(buttontext){
    setState(() {
       if(buttontext == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttontext == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttontext == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttontext;
        }else {
          equation = equation + buttontext;
        }
      }
    });
  }


  Widget buildButton(String buttontext,double buttonHeight,Color buttonColor){
     return  Container(
                             height: MediaQuery.of(context).size.height*0.1*buttonHeight,
                            color:buttonColor,
                            child: GestureDetector(
                              child: FloatingActionButton(
                                shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  
                                ),
                                onPressed:(() => buttonPressed(buttontext)),
                                child:Text(
                                  buttontext,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(equation,style: TextStyle(fontSize:equationFontSize,),),

          ),
           Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(result,style: TextStyle(fontSize:resultFontSize,),),
          ),
          Expanded(
            child:Divider(), 
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                         buildButton("C", 1, Colors.orange),
                         buildButton("⌫", 1, Colors.blue),
                         buildButton("÷", 1, Colors.blue),
                        ]
                      ),
                       TableRow(
                        children: [
                         buildButton("7", 1, Colors.black54),
                         buildButton("8", 1, Colors.black54),
                         buildButton("9", 1, Colors.black54),
                        ]
                      ),
                       TableRow(
                        children: [
                         buildButton("4", 1, Colors.black54),
                         buildButton("5", 1, Colors.black54),
                         buildButton("6", 1, Colors.black54),
                        ]
                      ),
                       TableRow(
                        children: [
                         buildButton("1", 1, Colors.black54),
                         buildButton("2", 1, Colors.black54),
                         buildButton("3", 1, Colors.black54),
                        ]
                      ),
                       TableRow(
                        children: [
                         buildButton(".", 1, Colors.black54),
                         buildButton("0", 1, Colors.black54),
                         buildButton("00", 1, Colors.black54),
                        ]
                      ),

                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.25,
                  child: Table(
                    children: [
                      TableRow(
                           children: [
                               buildButton("×", 1, Colors.blue),
                           ],
                      ),
                        TableRow(
                           children: [
                               buildButton("-", 1, Colors.blue),
                           ],
                      ),
                        TableRow(
                           children: [
                               buildButton("+", 1, Colors.blue),
                           ],
                      ),
                        TableRow(
                           children: [
                               buildButton("=", 2, Colors.redAccent),
                           ],
                      ),
                      ],                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}


