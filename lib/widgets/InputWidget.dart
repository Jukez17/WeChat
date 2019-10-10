import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/blocs/chats/Bloc.dart';
import 'package:wechat/config/Palette.dart';
import 'package:wechat/pages/ConversationBottomSheet.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  InputWidget();
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 60.0,
        child: Container(
      child: Row(
        children: <Widget>[
          Material(
            child:  Container(
              margin:  EdgeInsets.symmetric(horizontal: 1.0),
              child:  IconButton(
                icon:  Icon(Icons.face),
                color: Palette.accentColor,
                onPressed: () => {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                          child:  Wrap(
                            children: <Widget>[
                              ConversationBottomSheet()
                            ],
                          ),
                        );
                      })
                },
              ),
            ),
            color: Colors.white,
          ),

          // Text input
          Flexible(
            child: Material(
                child: Container(
              child: TextField(
                style:
                    TextStyle(color: Palette.primaryTextColor, fontSize: 15.0),
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Palette.greyColor),
                ),
              ),
            )),
          ),

          // Send Message Button
          Material(
            child:  Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child:  IconButton(
                icon:  Icon(Icons.send),
                onPressed: () => sendMessage(context),
                color: Palette.accentColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration:  BoxDecoration(
          border:  Border(
              top:  BorderSide(color: Palette.greyColor, width: 0.5)),
          color: Colors.white),
    ));
  }
  
  void sendMessage(context){
    BlocProvider.of<ChatBloc>(context).dispatch(SendTextMessageEvent(textEditingController.text));
    textEditingController.clear();
  }
}