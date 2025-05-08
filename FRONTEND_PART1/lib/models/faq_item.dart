class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  factory FAQItem.fromJson(Map<String, dynamic> j) => FAQItem(
        question: j['question'] as String,
        answer: j['answer'] as String,
      );
}
