// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WordCountModel {
  final String word;
  final int count;

  WordCountModel(
    this.word,
    this.count,
  );

  WordCountModel copyWith({
    String? word,
    int? count,
  }) {
    return WordCountModel(
      word ?? this.word,
      count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'count': count,
    };
  }

  factory WordCountModel.fromMap(Map<String, dynamic> map) {
    return WordCountModel(
      map['word'] as String,
      map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WordCountModel.fromJson(String source) =>
      WordCountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WordCountModel(word: $word, count: $count)';

  @override
  bool operator ==(covariant WordCountModel other) {
    if (identical(this, other)) return true;

    return other.word == word && other.count == count;
  }

  @override
  int get hashCode => word.hashCode ^ count.hashCode;
}
