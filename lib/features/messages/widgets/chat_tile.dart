// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String name, message, time, unread;
  final VoidCallback onTap;

  const ChatTile({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/Ellipse2.png'),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (unread.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4B6E),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unread,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
