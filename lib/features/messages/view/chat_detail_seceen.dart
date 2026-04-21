import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_message_controller.dart';
import '../widgets/chat_Inputfield.dart';
import '../widgets/chat_bubble.dart';

class ChatDetailScreen extends StatelessWidget {
  final String name;
  final controller = Get.find<ChatController>();
  final TextEditingController _textController = TextEditingController();

  ChatDetailScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: _buildAppBar(name),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.activeMessages.length,
                itemBuilder: (context, index) {
                  final msg = controller.activeMessages[index];
                  return ChatBubble(
                    isMe: msg['isMe'] as bool,
                    text: msg['text'] as String,
                    time: msg['time'] as String,
                  );
                },
              ),
            ),
          ),
          ChatInputField(
            controller: _textController,
            onSend: () {
              controller.sendMessage(_textController.text);
              _textController.clear();
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      // Removes the default back button to use the custom styled one
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Color(0xFF7B61FF), // Primary theme purple
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1E212C), // Dark Navy/Black
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      // Bottom border to create a subtle separation from the chat area
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: const Color(0xFFF1F1F1), height: 1.0),
      ),
    );
  }
}
