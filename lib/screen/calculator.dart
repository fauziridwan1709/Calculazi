import 'package:calculazi/screen/profile.dart';
import 'package:calculazi/theme_notifier.dart';
import 'package:calculazi/utils/parameter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';




class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> with TickerProviderStateMixin {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = Screen.width*.12;
  double resultFontSize = Screen.width*.10;
  Color expressionColor = Color(0xffdd9327);
  Color one = Color(0xffeb4d72);
  Color two = Color(0xfffed187);
  Color fontColor = _darkTheme? Color(0xffededed):Color(0xff787878);

  bool isCollapsed = true;

  Animation<double> _scaleAnimation;
  Animation<Offset> _slideAnimation;
  Animation<double> _menuScaleAnimation;
  AnimationController _controller;

  static var _darkTheme = false;

  @override
  void initState(){
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin:0.5, end:1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin:Offset(-1,0), end: Offset(0,0)).animate(_controller);

    super.initState();
  }

  void _handleOnPressed(){
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();
      isCollapsed = !isCollapsed;
    });
  }


  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final Duration duration = const Duration(milliseconds: 200);

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = Screen.width*.10;
        resultFontSize = Screen.width*.12;
      }

      else if(buttonText == "⌫"){
        equationFontSize = Screen.width*.12;
        resultFontSize = Screen.width*.10;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = Screen.width*.10;
        resultFontSize = Screen.width*.12;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          String near = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if(near.substring(near.length-2)==".0"){
            result = near.substring(0,near.length-2);
          }else{
            result = near;
          }
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = Screen.width*.12;
        resultFontSize = Screen.width*.10;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget symbolButton(String buttonText, double buttonHeight, Color buttonColor,Color background,Color shadow,Color bright){
    Screen().init(context);
    return Container(
      margin: EdgeInsets.all(Screen.width/33),
      height: Screen.width * 0.125 * buttonHeight,
      width: Screen.width * 0.125 * buttonHeight,
      decoration: BoxDecoration(
          color: background,

          borderRadius: BorderRadius.all(Radius.circular(1000.0)),
          boxShadow: [BoxShadow(
            color: bright,
            offset: Offset(-4, -4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
            BoxShadow(
              color:shadow,
              offset: Offset(4,4),
              blurRadius: 12,
              spreadRadius: 2,
            )]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(onTap: ()=>  buttonPressed(buttonText),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: buttonColor,fontSize: Screen.width*.08),
              ),
            ),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    Color neumorphColor = _darkTheme?Color(0xff21272c):Color(0xfff1f1f1);
    Color shadow = _darkTheme?Color(0xff1f1f1f):Color(0xffdfdfdf);
    Color brightShadow = _darkTheme?Color(0xff3a3a3a):Colors.white;
    Color textColor = _darkTheme ? Colors.white : Color(0xff222222);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _darkTheme? Brightness.light :Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: neumorphColor,
      body: Stack(
        children: <Widget>[
        SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _menuScaleAnimation,
          child: Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(bottom: 90),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        InkWell(
                          onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (_)=> ProfileScreen())),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.perm_identity, color: textColor),
                              SizedBox(width: 10),
                              Text(
                                  "Profile",
                                  style:TextStyle(color: textColor,fontFamily: "WorkSans-SemiBold",fontSize: 26) ,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: (){
                            _darkTheme = !_darkTheme;
                            onThemeChanged(_darkTheme, themeNotifier);
                          },
                          child: Row(
                            children: <Widget>[
                              Text('DarkMode',style:TextStyle(fontSize: 20,color: textColor,fontFamily: "WorkSans-SemiBold")),
                              SizedBox(width:25),
                              CupertinoSwitch(
                                activeColor: _darkTheme
                                    ? Colors.blue
                                    : Colors.grey.withOpacity(0.6),
                                onChanged: (bool value) {
                                  _darkTheme = !_darkTheme;
                                  onThemeChanged(_darkTheme, themeNotifier);
                                  setState(() {
                                    _darkTheme = value;
                                  });
                                },
                                value: _darkTheme,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
          AnimatedPositioned(
            duration: duration,
            top: 0,
            bottom: 0,
            left: isCollapsed? 0: .5 * Screen.width,
            right: isCollapsed? 0: -.5 * Screen.width,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                decoration: BoxDecoration(
                    color: neumorphColor,
                    borderRadius: isCollapsed
                        ?BorderRadius.all(Radius.circular(0))
                        :BorderRadius.all(Radius.circular(70.0)),
                    boxShadow: [BoxShadow(
                      color: brightShadow,
                      offset: Offset(-10, -10),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                      BoxShadow(
                        color: shadow,
                        offset: Offset(10,10),
                        blurRadius: 15,
                        spreadRadius: 2,
                      )]
                ),
                child: Column(
                  children: <Widget>[

                    Align(
                      alignment:Alignment.centerLeft,
                      child: Container(
                        height: Screen.height/16,
                        width: Screen.height/16,
                        margin: EdgeInsets.symmetric(horizontal:Screen.width/15,vertical: Screen.width/15),
                        decoration: BoxDecoration(
                            color: neumorphColor,
                            borderRadius: BorderRadius.all(Radius.circular(1000.0)),
                            boxShadow: [BoxShadow(
                              color: brightShadow,
                              offset: Offset(-4, -4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                              BoxShadow(
                                color:shadow,
                                offset: Offset(4,4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )]
                        ),
                        child: Center(child: IconButton(icon:Icon(Icons.menu),onPressed: ()=> _handleOnPressed(),iconSize: 24,color: textColor,)),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Text(equation, style: TextStyle(fontSize: equationFontSize,color: textColor),maxLines: 2,),
                    ),


                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(24, 30, 24, 0),
                      child: Text(result, style: TextStyle(fontSize: resultFontSize,color: textColor),maxLines: 2,),
                    ),


                    Expanded(child: SizedBox(),),

                    Column(
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            symbolButton("C", 1, Colors.redAccent,neumorphColor,shadow,brightShadow),
                            symbolButton("⌫", 1, expressionColor,neumorphColor,shadow,brightShadow),
                            symbolButton("÷", 1, expressionColor,neumorphColor,shadow,brightShadow),
                            symbolButton("×", 1, expressionColor,neumorphColor,shadow,brightShadow),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            symbolButton("7", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("8", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("9", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("%", 1, expressionColor,neumorphColor,shadow,brightShadow),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            symbolButton("4", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("5", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("6", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("-", 1, expressionColor,neumorphColor,shadow,brightShadow),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            symbolButton("1", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("2", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("3", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("+", 1, expressionColor,neumorphColor,shadow,brightShadow),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            symbolButton("00", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("0", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton(".", 1, fontColor,neumorphColor,shadow,brightShadow),
                            symbolButton("=", 1, expressionColor,neumorphColor,shadow,brightShadow),
                          ]
                      )
                    ]
                ),

                    SizedBox(height: Screen.height/20,)


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}