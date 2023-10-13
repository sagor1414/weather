// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_app/consts/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void openWhatsAppChat(String phoneNumber) async {
    String message = 'Hello!';
    bool whatsappInstalled =
        await canLaunch('whatsapp://send?phone=$phoneNumber');
    if (whatsappInstalled) {
      String url =
          'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';

      await launch(url);
    } else {
      String webUrl =
          'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}';

      await launch(webUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: "About me".text.color(theme.primaryColor).make(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [cardColor, Colors.pinkAccent],
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 250.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/sagor.jpg",
                        ),
                        radius: 50.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Sagor Samadder",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Bio:",
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'My name is Sagor and I am  a mobile app developper.\n'
                    'if you need any mobile app for your company then contact me for more informations',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: theme.primaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: cardColor),
                  onPressed: () {
                    openWhatsAppChat('+8801797512477');
                  },
                  child: "Cotact me"
                      .text
                      .size(24)
                      .color(theme.primaryColor)
                      .make()),
            )
          ],
        ),
      ),
    );
  }
}
