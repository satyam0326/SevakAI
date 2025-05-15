import 'package:ai_chatbot/controller/chat_controller.dart';
import 'package:ai_chatbot/widget/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final _c = Get.put(ChatController());
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Talk With Your Sevak',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[850] : Colors.blue[800],
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: isDark ? Colors.black : Colors.blue[900]!.withOpacity(0.5),
      ),

      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  gradient:
                      isDark
                          ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.grey[850]!, Colors.grey[900]!],
                          )
                          : null,
                ),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  controller: _c.scrollC,
                  padding: const EdgeInsets.only(top: 16, bottom: 100),
                  itemCount: _c.list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return MessageCard(
                      message: _c.list[index],
                    ).animate().fadeIn(duration: 300.ms);
                  },
                ),
              ),
            ),
          ),

          _buildInputArea(theme, isDark),
        ],
      ),
    );
  }

  Widget _buildInputArea(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.blue[200]!,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withOpacity(0.5)
                    : Colors.blue[100]!.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark ? Colors.grey[700]! : Colors.blue[300]!,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _c.textC,
                        focusNode: _focusNode,
                        minLines: 1,
                        maxLines: 4,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.blue[800],
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.blue[400],
                            fontSize: 15,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Iconsax.emoji_happy,
                        color: isDark ? Colors.blue[200] : Colors.blue[500],
                        size: 22,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 8),

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors:
                      isDark
                          ? [Colors.blue[800]!, Colors.blue[600]!]
                          : [Colors.blue[500]!, Colors.blue[700]!],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.blue[800] : Colors.blue[400]!)!
                        .withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Iconsax.send_1, color: Colors.white, size: 22),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
    // ).animate().moveY(begin: 100, duration: 500.ms, curve: Curves.easeOutQuint);
  }

  void _sendMessage() {
    if (_c.textC.text.trim().isNotEmpty) {
      _c.askQuestion();
      _focusNode.unfocus();
    }
  }
}
