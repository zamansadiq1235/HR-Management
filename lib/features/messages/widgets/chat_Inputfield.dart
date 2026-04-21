// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controllers/chat_message_controller.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  final ChatController chatController = Get.find<ChatController>();

  ChatInputField({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        onChanged: (val) =>
                            chatController.updateTypingStatus(val),
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,

                          fillColor: AppColors.background,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.attach_file, color: Colors.grey),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.camera_alt_rounded, color: Colors.grey),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Obx(
            () => GestureDetector(
              onTap: onSend,
              child: CircleAvatar(
                backgroundColor: const Color(0xFF7B61FF),
                child: Icon(
                  chatController.isTyping.value
                      ? Icons
                            .send // Show send if typing
                      : Icons.mic, // Show mic if empty
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
