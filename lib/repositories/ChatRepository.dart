import 'package:wechat/models/Chat.dart';
import 'package:wechat/models/Message.dart';
import 'package:wechat/models/User.dart';
import 'package:wechat/providers/BaseProviders.dart';
import 'package:wechat/providers/ChatProvider.dart';

class ChatRepository{
  BaseChatProvider chatProvider = ChatProvider();
  Stream<List<Chat>> getChats() => chatProvider.getChats();
  Stream<List<Message>> getMessages(String chatId) => chatProvider.getMessages(chatId);
  Future<void> sendMessage(String chatId, Message message) => chatProvider.sendMessage(chatId, message);
  Future<String> getChatIdByUsername(String username) => chatProvider.getChatIdByUsername(username);
  Future<void> createChatIdForContact(User user) => chatProvider.createChatIdForContact(user);
}