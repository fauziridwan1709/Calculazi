import 'package:calculazi/utils/parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../theme_notifier.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkTheme = false;
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
    Screen().init(context);
    return Scaffold(
      backgroundColor: neumorphColor,
      body: Container(
        height: Screen.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:Screen.height/23,left: Screen.height/27,right: Screen.height/27),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    color: textColor,
                    icon: Icon(Icons.arrow_back),
                    onPressed: ()=>Navigator.pop(context,true),),
                  Text("About me",style: TextStyle(fontFamily:"WorkSans-SemiBold"
                      ,fontSize: Screen.width/15,color: textColor)),
                  SizedBox(width: Screen.width/8,),

                ],
              ),
            ),
            SizedBox(height: Screen.height/20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:Screen.width/15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width:Screen.width/4,
                        height: Screen.width/4,
                        decoration:BoxDecoration(
                          color: neumorphColor,
                          shape: BoxShape.circle,
                            boxShadow: [BoxShadow(
                              color: brightShadow,
                              offset: Offset(-5, -5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                              BoxShadow(
                                color:shadow,
                                offset: Offset(5,5),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )]
                        ),
                        child: Center(
                          child: Container(
                            width: Screen.width/5,
                            height: Screen.width/5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: ExactAssetImage('assets/images/pawpaw.png'),fit: BoxFit.cover)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: Screen.width/20,),
                  Container(
                    width: Screen.width*.54,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Muhamad Fauzi Ridwan",style: TextStyle(fontFamily:"WorkSans-SemiBold"
                            ,fontSize: Screen.width/16,color: textColor),maxLines: 2,),
                        Text("Panggil 'pawpaw'",style: TextStyle(fontFamily: "WorkSans-Regular"
                            ,fontSize:Screen.width/24,color: textColor)),

                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screen.height/19,
            ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:Screen.width/15),
                      child: Text("Hobi",style: TextStyle(fontFamily: "WorkSans-Medium"
                          ,fontSize:Screen.width/20,color: textColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:Screen.width/15),
                      child: Text("Instagram",style: TextStyle(fontFamily: "WorkSans-Medium"
                          ,fontSize:Screen.width/20,color: textColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:Screen.width/15),
                      child: Text("Line",style: TextStyle(fontFamily: "WorkSans-Medium"
                          ,fontSize:Screen.width/20,color: textColor)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:Screen.width/15),
                      child: Text(": Kuliner, hal baru",style: TextStyle(fontFamily: "WorkSans-Medium"
                          ,fontSize:Screen.width/20,color: textColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:Screen.width/15),
                      child: Text(": @fauziridwan1709",style: TextStyle(fontFamily: "WorkSans-Medium"
                          ,fontSize:Screen.width/20,color: textColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:Screen.width/15),
                      child: Text(": garit65",style: TextStyle(fontFamily: "WorkSans-Medium"
                          ,fontSize:Screen.width/20,color: textColor)),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
