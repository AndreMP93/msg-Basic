import 'package:flutter/material.dart';

class ConversationTab extends StatefulWidget {
  const ConversationTab({Key? key}) : super(key: key);

  @override
  State<ConversationTab> createState() => _ConversationTabState();
}

class _ConversationTabState extends State<ConversationTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Conversas")
    );
  }
}
