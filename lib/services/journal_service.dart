import 'dart:convert';

import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class JournalService {
  static const String uri = "http://192.168.0.10:3000/";
  static const String resource = "journals";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  String getUrl() {
    return "$uri$resource";
  }

  // register(String content) {
  //   client.post(Uri.parse(getUrl()), body: {"content": content});
  // }

  Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());

    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {'Content-type': 'application/json'},
      body: jsonJournal,
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> edit(String id, Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());

    http.Response response = await client.put(
      Uri.parse("${getUrl()}$id"),
      headers: {'Content-type': 'application/json'},
      body: jsonJournal,
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> delete(String id) async {
    http.Response response = await http.delete(Uri.parse("${getUrl()}$id"));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    if (response.statusCode != 200) {
      throw Exception();
    }

    List<Journal> list = [];

    List<dynamic> listDynamic = json.decode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(Journal.fromMap(jsonMap));
    }

    return list;
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    return response.body;
  }
}

/*
import 'dart:convert';

import 'package:flutter_web_api_v2/models/journal.dart';
import 'package:flutter_web_api_v2/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class JournalService {
  static const String uri = "http://192.168.0.10:3000/";
  static const String resource = "journals";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  String getUrl() {
    return "$uri$resource";
  }

  // register(String content) {
  //   client.post(Uri.parse(getUrl()), body: {"content": content});
  // }

  Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {'Content-type': 'application/json'},
      body: jsonJournal,
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    if (response.statusCode != 200) {
      throw Exception();
    }

    List<Journal> list = [];

    List<dynamic> listDynamic = json.decode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(Journal.fromMap(jsonMap));
    }

    return list;
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    return response.body;
  }
}
*/
