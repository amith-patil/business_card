import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(BusinessCard());
}

class BusinessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.3, 0.6, 0.9],
            colors: [
              Colors.deepPurple[900],
              Colors.deepPurple[800],
              Colors.deepPurple[700],
              Colors.deepPurple[600],
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/imagebg.png'), fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TweenAnimationBuilder(
                    duration: Duration(seconds: 3),
                    tween: Tween(begin: 0.0,end: 1.0),
                    curve: Curves.elasticOut,
                    builder: (context, value, child){
                      return Transform.scale(scale: value,child: AvatarGlow(
                        endRadius: 120.0,
                        duration: Duration(seconds: 2),
                        repeatPauseDuration: Duration(seconds: 4),
                        repeat: true,
                        glowColor: Colors.white24,
                        child: Material(
                          shape: CircleBorder(),
                          elevation: 10.0,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                            AssetImage('images/joel_signature.gif'),
                            radius: 70.0,
                          ),
                        ),
                      ),);
                    },
                  ),
                  FadeIn(
                    2.0,
                    Text(
                      'Amith Patil',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FadeIn(
                    2.33,
                    Text(
                      'FLUTTER DEVELOPER',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 20.0,
                        color: Colors.white,
                        letterSpacing: 5.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FadeIn(
                    2.33,
                    SizedBox(
                      width: 200.0,
                      height: 30.0,
                      child: Divider(
                        color: Colors.white,
                        thickness: 2.0,
                      ),
                    ),
                  ),
                  FadeIn(
                    3,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: Card(
                        elevation: 10.0,
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => launch('tel://+91 7204838428'),
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.blueGrey,
                              size: 30.0,
                            ),
                            title: Text(
                              '+91 - 7204838428',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 1.0,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    3.33,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: Card(
                        elevation: 10.0,
                        child: InkWell(
                          onTap: () => launch('mailto:amithsp93@live.com'),
                          child: ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Colors.blueGrey,
                              size: 30.0,
                            ),
                            title: Text(
                              'amithsp93@live.com',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeIn(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: 130.0, end: 0.0),
          curve: Curves.decelerate)
    ]);

    return PlayAnimation(
      delay: Duration(milliseconds: (800 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
