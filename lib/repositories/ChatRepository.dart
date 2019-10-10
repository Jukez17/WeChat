import 'dart:async';

import 'package:wechat/models/Chat.dart';
import 'package:wechat/models/Message.dart';
import 'package:wechat/models/User.dart';
import 'package:wechat/providers/ChatProvider.dart';


class ChatRepository{
  ChatProvider chatProvider = ChatProvider();
  Stream<List<Chat>> getChats() => chatProvider.getChats();
  Stream<List<Message>> getMessages(String chatId)=> chatProvider.getMessages(chatId);

  Future<List<Message>> getPreviousMessages(
          String chatId, Message prevMessage) =>
      chatProvider.getPreviousMessages(chatId, prevMessage);

  Future<void> sendMessage(String chatId, Message message)=>chatProvider.sendMessage(chatId, message);

  Future<String> getChatIdByUsername(String username) =>
      chatProvider.getChatIdByUsername(username);

  Future<void> createChatIdForContact(User user) =>
      chatProvider.createChatIdForContact(user);


}