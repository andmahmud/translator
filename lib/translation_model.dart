class TranslationModel {
  final String translatedText;

  TranslationModel({required this.translatedText});

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      translatedText: json['responseData']['translatedText'],
    );
  }
}
