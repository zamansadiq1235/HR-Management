import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  final isTyping = false.obs;
  final chatList = [
    {
      'name': 'Alicia Rochefort',
      'msg': 'Hey Tonald, we have to attend...',
      'time': '09.10',
      'unread': '1',
    },

    {
      'name': 'Jessica Tan',
      'msg': 'Ey Tonald, let\'s do the design...',
      'time': '09.10',
      'unread': '',
    },

    {
      'name': 'Lolita Xue',
      'msg': 'Ey Tonald, let\'s do the design...',
      'time': '09.10',
      'unread': '',
    },
  ].obs;
  // Use RxList<Map<String, dynamic>> to force the correct type
  final RxList<Map<String, dynamic>> activeMessages = <Map<String, dynamic>>[
    {
      'id': '1',
      'isMe': false,
      'text': 'Hey Tonald, we have to attend our daily stand up',
      'time': '09.10',
    },
    {
      'id': '2',
      'isMe': true,
      'text': 'Sure, when will daily stand up starts?',
      'time': '09.12',
    },
    {
      'id': '3',
      'isMe': false,
      'text': 'It\'s around 11.00, in the meeting room',
      'time': '09.13',
    },
  ].obs;

  void updateTypingStatus(String text) =>
      isTyping.value = text.trim().isNotEmpty;

  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      // Explicitly typing the new message map
      final Map<String, dynamic> newMessage = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'isMe': true,
        'text': text,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      };

      // Use .value assignment with spread operator for proper GetX tracking
      activeMessages.value = [...activeMessages, newMessage];
      isTyping.value = false;
    }
  }

  void deleteMessage(int index) {
    if (index >= 0 && index < activeMessages.length) {
      activeMessages.value = [...activeMessages]..removeAt(index);
    }
  }

  void editMessage(int index, String newText) {
    if (newText.trim().isNotEmpty &&
        index >= 0 &&
        index < activeMessages.length) {
      // Use Map.from to ensure a fresh, mutable copy
      final updatedMsg = Map<String, dynamic>.from(activeMessages[index]);
      updatedMsg['text'] = newText;
      activeMessages.value = [...activeMessages]..[index] = updatedMsg;
      activeMessages.refresh(); // Tells Obx to rebuild
    }
  }
}
