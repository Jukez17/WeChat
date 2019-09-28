import 'package:flutter/material.dart';
import 'package:wechat/widgets/ChatAppBar.dart';
import 'package:wechat/widgets/ChatListWidget.dart';
import 'package:wechat/widgets/InputWidget.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
  const ConversationPage();
}

class _ConversationPageState extends State<ConversationPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: ChatAppBar(), // Custom app bar for chat screen
          body: Stack(children: <Widget>[
            Column(
              children: <Widget>[
              ChatListWidget(),
                InputWidget()
              ],
            ),
          ]
    )
      )
    );
  }


}