import 'package:bits_project/features/domain/entities/audio_entity.dart';

class AudioModel implements AudioEntity {
  @override
  String? audioLink;

  @override
  String? audioName;

  @override
  String? genre;

  @override
  String? id;

  @override
  String? imageLink;

  @override
  String? login;

  @override
  String? userId;

  AudioModel(
      {this.id,
      this.audioName,
      this.imageLink,
      this.audioLink,
      this.userId,
      this.genre,
      this.login});
  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
        id: json["_id"],
        audioName: json["audioName"],
        imageLink: json["imageLink"],
        audioLink: json["audioLink"],
        genre: json["genre"],
        userId: json["userId"],
        login: json["nickName"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "audioName": audioName,
      "imageLink": imageLink,
      "audioLink": audioLink,
      "genre": genre,
      "userId": userId,
      "nickName": login
    };
  }
}
