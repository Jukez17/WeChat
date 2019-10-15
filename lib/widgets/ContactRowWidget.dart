import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/blocs/config/Bloc.dart';
import 'package:wechat/config/Constants.dart';
import 'package:wechat/config/Transitions.dart';
import 'package:wechat/models/Contact.dart';
import 'package:wechat/pages/ConversationPageSlide.dart';
import 'package:wechat/pages/SingleConversationPage.dart';
import 'package:wechat/utils/SharedObjects.dart';

// ignore: must_be_immutable
class ContactRowWidget extends StatelessWidget {
  ContactRowWidget({
    Key key,
    @required this.contact,
  }) : super(key: key);
  final Contact contact;
  bool configMessagePaging = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc,ConfigState>(
      builder: (context, state) {
        if (state is UnConfigState)
          configMessagePaging =
              SharedObjects.prefs.getBool(Constants.configMessagePaging);
        if (state is ConfigChangeState) if (state.key ==
            Constants.configMessagePaging) configMessagePaging = state.value;

        return InkWell(
          onTap: () =>
              Navigator.push(context,SlideLeftRoute(page:  configMessagePaging
                  ? ConversationPageSlide(
                  startContact:contact)
                  : SingleConversationPage(
                contact: contact,
              ))),
          child: Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body2,
                      children: <TextSpan>[
                        TextSpan(text: contact.getFirstName()),
                        TextSpan(
                            text: ' ' + contact.getLastName(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ))),
        );
      }
    );
  }
}