import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: InkWell(
                onTap: () => print("Tap"),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("yotei v0.1.0", style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text("Yotei is your personal notes and target with Kanban style to helps you get things done"))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () => print("Tap"),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage("https://avatars1.githubusercontent.com/u/26734262?s=460&u=092ca42f28f667722aabbb55b0a939473625c9e9&v=4"),
                      ),
                      Expanded(
                       child: Container(
                         margin: EdgeInsets.only(left: 16),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                           children: [
                             Text("Prieyudha Akadita S", style: TextStyle(fontWeight: FontWeight.bold)),
                             Container(
                               margin: EdgeInsets.only(top: 8),
                               child: Text("This app created by prieyudha akadita s, it is available on github, if you want to contribute just send me a pull request!")
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: RaisedButton(
                                onPressed: () => _launchURL(), 
                                child: Text("View on github")
                                )
                            )
                           ],
                         ),
                       ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () => print(""),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Fanny Naditya Putra", style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text("Thanks for Fanny Naditya Putra for helped me generated the icon design."))
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


  _launchURL() async {
    const url = 'https://github.com/ydhnwb/yotei';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}