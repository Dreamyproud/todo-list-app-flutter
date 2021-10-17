import 'package:flutter/material.dart';
import 'package:thingstodo/widgets/slide_animation_wrapper.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SlideAnimationWrapper(
                fadeDuration: Duration(milliseconds: 1000),
                slideDuration: Duration(milliseconds: 1500),
                child: Text(
                  "Bienvenido!",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 50.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              SizedBox(height: 40),
              SlideAnimationWrapper(
                fadeDuration: Duration(milliseconds: 1500),
                slideDuration: Duration(milliseconds: 1900),
                child: Text(
                  "¿Estás listo para personalizar tus tareas?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w200,
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              SizedBox(height: 40),
              SlideAnimationWrapper(
                fadeDuration: Duration(milliseconds: 1600),
                slideDuration: Duration(milliseconds: 2000),
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, "/mainScreen"),
                    child: Text(
                      "Estoy listo",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 20.0),
                    )),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
