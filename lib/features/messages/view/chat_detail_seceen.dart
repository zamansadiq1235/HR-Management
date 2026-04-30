// ignore_for_file: use_key_in_widget_constructors

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
                    isMe: msg['isMe'],
                    text: msg['text'],
                    time: msg['time'],
                    onLongPress: () {
                      if (msg['isMe']) {
                        _showOptionsSheet(index, msg['text'], msg['isMe']);
                      }
                    },
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

  void _showEditDialog(int index, String currentText) {
    final editC = TextEditingController(text: currentText);
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16),
      titlePadding: const EdgeInsets.only(top: 16, bottom: 8),
      title: "Edit Message",
      content: TextField(controller: editC),
      textConfirm: "Save",
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text("Cancel"),
      ),
      onConfirm: () {
        controller.editMessage(index, editC.text);
        Get.back();
      },
    );
  }

  void _showOptionsSheet(int index, String currentText, bool isMe) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          children: [
            // 1. Only show Edit if the message belongs to ME
            if (isMe)
              ListTile(
                leading: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF7B61FF),
                ),
                title: const Text('Edit Message'),
                onTap: () {
                  Get.back();
                  _showEditDialog(index, currentText);
                },
              ),

            // 2. Always show Delete (for both Me and Others)
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Delete Message',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Get.back();
                _confirmDelete(index);
              },
            ),

            // Padding for modern devices with bottom bars
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(int index) {
    Get.defaultDialog(
      title: "Delete Message?",
      middleText: "This message will be removed from your view.",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      buttonColor: Colors.redAccent,
      onConfirm: () {
        controller.deleteMessage(index);
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }
}
