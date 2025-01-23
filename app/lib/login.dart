import 'package:artify/main.dart';
import 'package:artify/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Login> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void disponse() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      body:  Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 36, 36, 36),
              Colors.deepPurpleAccent,
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Row(
                        children: [
                        Icon(
                          Icons.palette_outlined,
                          color: Colors.deepPurpleAccent,
                          size: 50,
                        ),
                          Text(
                            "Artify",
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          )
            ]),
                      ),
                  SizedBox(
                    height: 40,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text(
                        "Modern Sanat Galerisi, Telefonunuzu Güzelleştirin",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 36, 36),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 36, 36, 36),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 36, 36, 36),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white))),
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: "Kullanıcı Adı",
                                        hintStyle:
                                        TextStyle(color: Colors.white),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white))),
                                  child: TextField(
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: "Şifre",
                                        hintStyle:
                                        TextStyle(color: Colors.white),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Main()),
                              );
                            },
                            height: 50,
                            color: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "Giriş Yap",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: Text(
                            "Hesabın mı yok? Hemen ",
                            style: TextStyle(color: Colors.grey),
                          )),
                      FadeInUp(
                          duration: Duration(milliseconds: 1500),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Hesap Oluştur",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}