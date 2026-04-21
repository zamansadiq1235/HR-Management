import 'package:get/get.dart';

class ChatController extends GetxController {

  final isTyping = false.obs;
  void updateTypingStatus(String text) {
    isTyping.value = text.trim().isNotEmpty;
  }
  
  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      // Add message logic here
      activeMessages.add({
        'isMe': true, 
        'text': text, 
        'time': '09.14'
      });
      
      // Reset typing status after sending
      isTyping.value = false;
    }
  }
  // Mock data for the message list
  final chatList = [
    {'name': 'Alicia Rochefort', 'msg': 'Hey Tonald, we have to attend...', 'time': '09.10', 'unread': '1'},
    {'name': 'Jessica Tan', 'msg': 'Ey Tonald, let\'s do the design...', 'time': '09.10', 'unread': ''},
    {'name': 'Lolita Xue', 'msg': 'Ey Tonald, let\'s do the design...', 'time': '09.10', 'unread': ''},
  ].obs;

  // Mock data for a specific conversation
  final activeMessages = [
    {'isMe': false, 'text': 'Hey Tonald, we have to attend our daily stand up', 'time': '09.10'},
    {'isMe': true, 'text': 'Sure, when will daily stand up starts?', 'time': '09.12'},
    {'isMe': false, 'text': 'It\'s around 11.00, in the meeting room', 'time': '09.13'},
  ].obs;

}