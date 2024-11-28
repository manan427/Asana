import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class EmailCall {
  static Future<ApiCallResponse> call({
    String? sendto = '',
    String? name = '',
    String? replyTo = '',
    String? title = '',
    String? body = '',
  }) async {
    final ffApiRequestBody = '''
{
  "sendto": "$sendto",
  "name": "$name",
  "replyTo": "$replyTo",
  "ishtml": "false",
  "title": "$title",
  "body": "$body"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'email',
      apiUrl: 'https://mail-sender-api1.p.rapidapi.com/',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': '01660293f5msh401ad8afb7d2e34p11c7d1jsne82af49a7560',
        'X-RapidAPI-Host': 'mail-sender-api1.p.rapidapi.com',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SupabaseCall {
  static Future<ApiCallResponse> call({
    String? url = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'supabase',
      apiUrl: 'https://nzpkdamrqkyvsjwkkhpc.supabase.co/rest/v1/${url}select=*',
      callType: ApiCallType.GET,
      headers: {
        'apiKey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE',
        'Authorization':
            '0o3Q5O57buIGSpwVdthuPOI1f72hY58+6Yf++k0WxWNEXvkZJTxx+C7IOvHd2n6oU1IZrhgWtk2vRrV+BRbVVg==',
      },
      params: {
        'url': url,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? alltasks(dynamic response) => getJsonField(
        response,
        r'''$[:]''',
        true,
      ) as List?;
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
