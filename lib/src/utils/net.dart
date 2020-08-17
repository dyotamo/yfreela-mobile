import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:free/src/models.dart';
import 'package:http/http.dart' as http;

Future<List> getCategories() async {
  var body = (await http.get('https://yfreela.herokuapp.com/categories')).body;
  return ((jsonDecode(body)) as List).map((category) => category).toList();
}

Future<List> getFreelas(category) async {
  var body =
      (await http.get('https://yfreela.herokuapp.com/categories/$category'))
          .body;

  return ((jsonDecode(body)) as List)
      .map((json) => Freela.fromJson(json))
      .toList();
}

Future<List> allFreelas() async {
  var body = (await http.get('https://yfreela.herokuapp.com/search/')).body;

  return ((jsonDecode(body)) as List)
      .map((json) => Freela.fromJson(json))
      .toList();
}

Future<Freela> getFreela(freelaId) async {
  var queryParameters = {
    'device_id': await DeviceId.getID,
  };

  var uri =
      Uri.https('yfreela.herokuapp.com', '/freelas/$freelaId', queryParameters);

  var body = (await http.get(uri)).body;

  return Freela.fromJson(jsonDecode(body));
}

Future<List> searchFreelas(category) async {
  var body =
      (await http.get('https://yfreela.herokuapp.com/search/$category')).body;

  return ((jsonDecode(body)) as List)
      .map((json) => Freela.fromJson(json))
      .toList();
}

Future<Freela> likeOrDislike(freela, action) async {
  final deviceId = await DeviceId.getID;

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final resp = await http.post('https://yfreela.herokuapp.com/like_or_dislike',
      body: jsonEncode(
          {'freela_id': freela.id, 'device_id': deviceId, 'action': action}),
      headers: headers);

  return Freela.fromJson(jsonDecode(resp.body));
}
