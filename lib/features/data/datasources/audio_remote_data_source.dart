import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/audio_model.dart';
import 'package:http/http.dart' as http;

abstract class AudioRemoteDataSource {
  Future<List<AudioModel>?>? getAudio({String? genre});
  Future<bool>? sendAudio(AudioModel audio);
}

class AudioRemoteDataSourceImpl implements AudioRemoteDataSource {
  http.Client client;
  AudioRemoteDataSourceImpl({required this.client});
  @override
  Future<List<AudioModel>?>? getAudio({String? genre}) async {
    // final response = client.get(Uri.parse('http://192.168.137.1:3000/Pop'));
    final response = await client.get(
        Uri.parse('http://192.168.137.1:3000/$genre'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Iterable decodedJson = json.decode(response.body)['audio'];
      List<AudioModel> audios = List<AudioModel>.from(
          decodedJson.map((audio) => AudioModel.fromJson(audio)));
      if (kDebugMode) {
        print(audios);
      }
      return audios;
    } else {
      throw response.statusCode;
    }
  }

  @override
  Future<bool>? sendAudio(AudioModel? audio) async {
    final audioJson = audio!.toJson();
    final response = await client.post(
        Uri.parse('http://192.168.137.1:3000/upload'),
        body: json.encode(audioJson),
        headers: {'Content-Type': 'application/json'});
    if (kDebugMode) {
      print(response);
    }
    if (response.statusCode == 200) {
      final responseDecoded = json.decode(response.body);
      return responseDecoded["ok"];
    } else {
      throw response.statusCode;
    }
  }
}
