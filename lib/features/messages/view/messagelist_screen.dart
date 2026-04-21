// ignore_for_file: unnecessary_underscores, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_message_controller.dart';
import '../widgets/chat_tile.dart';
import 'chat_detail_seceen.dart';

class MessageListScreen extends StatelessWidget {
  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
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
                color: Color(0xFF7B61FF),
              ),
            ),
          ),
        ),
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Color(0xFF1E212C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          final item = controller.chatList[index];
          return ChatTile(
            name: item['name']!,
            message: item['msg']!,
            time: item['time']!,
            unread: item['unread']!,
            onTap: () => Get.to(() => ChatDetailScreen(name: item['name']!)),
          );
        },
      ),
    );
  }
}
