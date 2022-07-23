import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';

import '../../../colors.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;

  const BottomChatField({
    required this.receiverUserId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  var cameraPressed = false;
  var emojiPressed = false;
  var isShowSendButton = false;

  final TextEditingController _messageController = TextEditingController();

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider)?.sendTextMessage(
            context: context,
            text: _messageController.text.trim(),
            receiverUserId: widget.receiverUserId,
          );
    }
    setState(() {
      _messageController.clear();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _messageController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isShowSendButton = true;
                });
              } else if (value.isEmpty) {
                setState(() {
                  isShowSendButton = false;
                });
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            emojiPressed = !emojiPressed;
                          });
                        },
                        icon: Icon(
                            emojiPressed
                                ? Icons.emoji_emotions
                                : Icons.emoji_emotions_outlined,
                            color: Colors.grey),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.gif, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.attach_file, color: Colors.grey),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cameraPressed = !cameraPressed;
                        });
                      },
                      icon: Icon(
                          cameraPressed
                              ? Icons.camera_alt
                              : Icons.camera_alt_outlined,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              hintText: "Enter a message",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 2, left: 2),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: messageColor,
            child: IconButton(
              onPressed: () {
                sendTextMessage();
              },
              icon: Icon(isShowSendButton ? Icons.send : Icons.mic,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
