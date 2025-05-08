import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  @override State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _api = ApiService();
  final _qCtl = TextEditingController();
  final List<String> _chat = [];

  @override
  void dispose() {
    _qCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot (FAQs)')),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: _chat.length,
            itemBuilder: (_, i) => ListTile(title: Text(_chat[i])),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _qCtl,
                decoration: const InputDecoration(labelText: 'Ask a question', border: OutlineInputBorder()),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
                final q = _qCtl.text.trim();
                if (q.isEmpty) return;
                setState(() => _chat.add('You: $q'));
                final a = await _api.askFAQ(q);
                setState(() => _chat.add('Bot: $a'));
                _qCtl.clear();
              },
            )
          ]),
        )
      ]),
    );
  }
}
