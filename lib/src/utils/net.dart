import 'dart:convert';

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

Future<List> searchFreelas(category) async => await getFreelas(category);
