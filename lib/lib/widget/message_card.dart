import 'package:ai_chatbot/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment:
          message.msgType == MessageType.bot
              ? Alignment.centerLeft
              : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color:
                message.msgType == MessageType.bot
                    ? isDark
                        ? Colors.grey[900]
                        : Colors.white
                    : isDark
                    ? Colors.blue[800]
                    : Colors.blue.shade600,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft:
                  message.msgType == MessageType.bot
                      ? const Radius.circular(0)
                      : const Radius.circular(20),
              bottomRight:
                  message.msgType == MessageType.bot
                      ? const Radius.circular(20)
                      : const Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.blue.shade100.withOpacity(0.5),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.msgType == MessageType.bot)
                Row(
                  children: [
                    Icon(
                      Iconsax.cpu,
                      size: 16,
                      color: isDark ? Colors.blue[200] : Colors.blue.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'AI Assistant',
                      style: TextStyle(
                        color: isDark ? Colors.blue[200] : Colors.blue.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              if (message.msgType == MessageType.bot) const SizedBox(height: 4),
              message.msg.isEmpty
                  ? Row(
                    children: [
                      _buildTypingIndicator(isDark),
                      const SizedBox(width: 4),
                      _buildTypingIndicator(isDark, delay: 200),
                      const SizedBox(width: 4),
                      _buildTypingIndicator(isDark, delay: 400),
                    ],
                  )
                  : Text(
                    message.msg,
                    style: TextStyle(
                      color:
                          message.msgType == MessageType.bot
                              ? isDark
                                  ? Colors.white
                                  : Colors.grey.shade800
                              : Colors.white,
                      fontSize: 14,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(bool isDark, {int delay = 0}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isDark ? Colors.blue[400] : Colors.blue.shade400,
        shape: BoxShape.circle,
      ),
    ).animate(delay: Duration(milliseconds: delay));
    // .scale(
    //   begin: const Offset(1, 1),
    //   end: const Offset(1.2, 1.2),
    //   duration: 600.ms,
    //   curve: Curves.easeInOut,
    // );
  }
}
