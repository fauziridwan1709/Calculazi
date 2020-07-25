import 'dart:async';

import 'package:calculazi/model/image_carousel_data.dart';
import 'package:calculazi/screen/calculator.dart';
import 'package:calculazi/utils/parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../dots_indicator.dart';
import '../theme.dart';
import '../theme_notifier.dart';

class HomeScreen extends StatefulWidget {

  final Duration autoPlayDuration = const Duration(seconds: 5);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AnimationController animationController;
  PageController pageController;

  List<ImageCData> imageCData = ImageCData.tabIconsList;

  String valid = "2020";
  Timer timer;


  static var _darkTheme = false;

  @override
  void initState(){
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    pageController = PageController(initialPage: 1, viewportFraction: .90);

    if (imageCData != null && imageCData.isNotEmpty) {
      timer = Timer.periodic(widget.autoPlayDuration, (_) {
        if (pageController.hasClients) {
          if (pageController.page.round() == imageCData.length - 1) {
            pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
            );
          } else {
            pageController.nextPage(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    Color neumorphColor = _darkTheme?Color(0xff21272c):Color(0xfff1f1f1);
    Color shadow = _darkTheme?Color(0xff1f1f1f):Color(0xffdfdfdf);
    Color brightShadow = _darkTheme?Color(0xff3a3a3a):Colors.white;
    Color textColor = _darkTheme ? Colors.white : Color(0xff222222);
    Color homeText = _darkTheme ? Color(0xfffed187) : Color(0xffeb4d72);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _darkTheme? Brightness.light :Brightness.dark,
    ));
    Screen().init(context);
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
            width: Screen.width,
            height: Screen.height,
            padding: EdgeInsets.symmetric(horizontal:16.0),
            decoration: BoxDecoration(
              color: neumorphColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
    ),
            SingleChildScrollView(
              child: Container(
                width: Screen.width,
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top:Screen.height/15),
                          child: Center(child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                height: Screen.height/1.9,
                                width: double.infinity,
                                child: PageView.builder(
                                  controller: pageController,
                                  itemCount: imageCData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    final int count =
                                    imageCData.length > 10 ? 10 : imageCData.length;
                                    final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController,
                                            curve: Interval((1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                    animationController.forward();

                                    return CarouselView(
                                      imageCData: imageCData[index],
                                      animation: animation,
                                      animationController: animationController,
                                      color: neumorphColor,
                                      shadowColor: shadow,
                                      bright: brightShadow,
                                      homeText: homeText,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10)
                            ],
                          )),
                        ),

                      ],
                    ),

                    Container(
                      child: Center(
                        child: DotsIndicator(
                          controller: pageController,
                          itemCount: imageCData.length,
                          color: Colors.grey,
                          increasedColor: homeText,
                          dotSize: 7,
                          dotSpacing: 16,
                          dotIncreaseSize: 1.2,
                          onPageSelected: (int page) {
                            pageController.animateToPage(
                              page,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      height: Screen.height/17,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:Screen.width*.1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height:Screen.height/10,
                              child: TextFormField(
                                style:TextStyle(fontSize: Screen.width/18,color: textColor),
                                maxLength: 4,
                                textAlign: TextAlign.center,
                                decoration: new InputDecoration(labelText: "PIN",
                                    focusColor: textColor,
                                    labelStyle: TextStyle(color: textColor),
                                    fillColor: Colors.grey.withOpacity(.2),
                                    filled : true,
                                    border : OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: new BorderSide(color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide:new BorderSide(color: Colors.transparent)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: new BorderSide(color: Colors.transparent)),
                                    ),
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (value == valid) {
                                    return null;
                                  } else {
                                    return "please enter a valid value";
                                  }
                                },
                              ),
                            ),
                            SizedBox(height:Screen.height/25),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              height: Screen.height / 12,
                              width: Screen.width,
                              decoration: BoxDecoration(
                                  color: neumorphColor,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        // If the form is valid, display a Snackbar.
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Calculator()));
                                      }
                                    },
                                    child: Center(
                                        child: Text(
                                          'Login',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Screen.width/20,
                                              color: homeText,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ),
                            ),
                            SizedBox(height:Screen.height/10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  String pinValidator(String value) {
    Pattern pattern = r'^(?:[+0]9)?[0-9]{4}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value)) return '*Enter a valid pin';
    if (value == '2020')
      return null;
    else
      return "please input the right pin";
  }
}

class CarouselView extends StatelessWidget {
  const CarouselView(
      {Key key, this.imageCData, this.animationController, this.animation,this.color,this.shadowColor,this.bright,
      this.homeText})
      : super(key: key);

  final ImageCData imageCData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final Color color;
  final Color shadowColor;
  final Color bright;
  final Color homeText;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width/1.3,
                padding: EdgeInsets.symmetric(horizontal:18),
                height: Screen.height/2.3,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    boxShadow: [BoxShadow(
                      color: bright,
                      offset: Offset(-7, -7),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                      BoxShadow(
                        color:shadowColor,
                        offset: Offset(7,7),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )]
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: Screen.height/4,
                        margin: EdgeInsets.only(top: Screen.height/40,bottom: Screen.height/40),
                        decoration: BoxDecoration(
                          image: new DecorationImage(image:ExactAssetImage(imageCData.imagePath)),
                          borderRadius: const BorderRadius.only(

                          ),
                        ),
                      ),
                    ),
                    Text(imageCData.title,style:TextStyle(fontSize: Screen.width/10,color: homeText,fontFamily: "WorkSans-SemiBold")),
                    Text(imageCData.desc,style:TextStyle(fontSize: Screen.width/24,color: homeText,
                      fontFamily: "WorkSans-Regular"),textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
