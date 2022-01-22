import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class cal extends StatefulWidget {
  const cal({Key? key}) : super(key: key);

  @override
  _calState createState() => _calState();
}

class _calState extends State<cal> {
  String equation = '0';
  String expression = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.15, vertical: size.height * 0.15),
            alignment: Alignment.centerRight,
            child: Text(
              equation,
              style: TextStyle(fontSize: size.height * 0.12),
              maxLines: 1,
            ),
          ),
          Divider(),
          Row(
            children: [
              Container(
                width: size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      builtBtn('C', 1.0, Colors.white30, Colors.green),
                      builtBtn('Ac', 1.0, Colors.white30, Colors.green),
                      builtBtn('*', 1.0, Colors.white30, Colors.green),
                    ]),
                    TableRow(children: [
                      builtBtn('7', 1.0, Colors.white30, Colors.green),
                      builtBtn('8', 1.0, Colors.white30, Colors.green),
                      builtBtn('9', 1.0, Colors.white30, Colors.green),
                    ]),
                    TableRow(children: [
                      builtBtn('4', 1.0, Colors.white30, Colors.green),
                      builtBtn('5', 1.0, Colors.white30, Colors.green),
                      builtBtn('6', 1.0, Colors.white30, Colors.green),
                    ]),
                    TableRow(children: [
                      builtBtn('1', 1.0, Colors.white30, Colors.green),
                      builtBtn('2', 1.0, Colors.white30, Colors.green),
                      builtBtn('3', 1.0, Colors.white30, Colors.green),
                    ]),
                    TableRow(children: [
                      builtBtn('0', 1.0, Colors.white30, Colors.green),
                      builtBtn('00', 1.0, Colors.white30, Colors.green),
                      builtBtn('.', 1.0, Colors.white30, Colors.green),
                    ]),
                  ],
                ),
              ),
              Container(
                width: size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      builtBtn('/', 1.0, Colors.white30, Colors.green),
                    ]),
                    TableRow(children: [
                      builtBtn('+', 1.0, Colors.white30, Colors.green),
                    ]),
                    TableRow(children: [
                      builtBtn('-', 1.0, Colors.white30, Colors.green),
                    ]),
                    TableRow(children: [
                      builtBtn('=', 2.0, Colors.white30, Colors.green),
                    ]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget builtBtn(
      String btntext, double btnheight, Color btncolor, Color textColor) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1 * btnheight,
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.005, vertical: size.height * 0.003),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: btncolor,
          boxShadow: [
            BoxShadow(color: Colors.black12, offset: Offset(3.0, 6.0))
          ]),
      child: FlatButton(
        onPressed: () {
          setState(() {
            if (btntext == 'C') {
              equation = '0';
            } else if (btntext == 'Ac') {
              equation = equation.substring(0, equation.length - 1);
              if (equation == '') {
                equation = '0';
              }
            } else if (btntext == '=') {
              expression = equation;

              try {
                Parser p = Parser();
                Expression exp = p.parse(expression);
                ContextModel cm = ContextModel();
                equation = '${exp.evaluate(EvaluationType.REAL, cm)}';
              } catch (e) {
                equation = 'error';
              }
            } else {
              if (equation == '0') {
                equation = btntext;
              } else {
                equation += btntext;
              }
            }
          });
        },
        child: Text(
          btntext,
          style: TextStyle(fontSize: size.width * 0.07),
        ),
      ),
    );
  }
}
