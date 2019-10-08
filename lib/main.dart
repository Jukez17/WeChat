import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/blocs/chats/Bloc.dart';
import 'package:wechat/blocs/contacts/Bloc.dart';
import 'package:wechat/pages/ContactListPage.dart';
import 'package:wechat/repositories/AuthenticationRepository.dart';
import 'package:wechat/repositories/ChatRepository.dart';
import 'package:wechat/repositories/StorageRepository.dart';
import 'package:wechat/repositories/UserDataRepository.dart';
import 'package:wechat/utils/SharedObjects.dart';
import 'blocs/authentication/Bloc.dart';
import 'config/Palette.dart';
import 'pages/RegisterPage.dart';

void main() async {
  //create instances of the repositories to supply them to the app
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();
  final ChatRepository chatRepository = ChatRepository();
  SharedObjects.prefs  = await CachedSharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(
      providers:[
        BlocProvider<AuthenticationBloc>(
          builder: (context) => AuthenticationBloc(
              authenticationRepository: authRepository,
              userDataRepository: userDataRepository,
              storageRepository: storageRepository)
            ..dispatch(AppLaunched()),
        ),
        BlocProvider<ContactsBloc>(
          builder: (context) => ContactsBloc(
              userDataRepository: userDataRepository,
            chatRepository: chatRepository
             ),
        ),
        BlocProvider<ChatBloc>(
          builder: (context) => ChatBloc(
            userDataRepository: userDataRepository,
            storageRepository:  storageRepository,
            chatRepository:chatRepository
          ),
        )
      ] ,
      child: WeChat(),
    )

  );
}

class WeChat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wechat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
        fontFamily: 'Manrope'
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UnAuthenticated) {
            return RegisterPage();
          } else if (state is ProfileUpdated) {
            BlocProvider.of<ChatBloc>(context).dispatch(FetchChatListEvent());
            return ContactListPage();
          //  return ConversationPageSlide();
          } else {
            return RegisterPage();
          }
        },
      ),
    );
  }
}
