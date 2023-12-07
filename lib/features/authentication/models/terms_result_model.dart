class TermsResultModel {
  final int termsId;
  final String title;
  final String content;

  TermsResultModel({
    required this.termsId,
    required this.title,
    required this.content,
  });

  factory TermsResultModel.fromJson(Map<String, dynamic> json) {
    return TermsResultModel(
      termsId: json['termsId'],
      title: json['title'],
      content: json['content'],
    );
  }
}
