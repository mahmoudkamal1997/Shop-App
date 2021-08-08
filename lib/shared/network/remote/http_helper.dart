import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HttpHelper
{


  static Future<http.Response> getData({
    @required String url,
    Map<String,dynamic> query,
    String token
  })async{
    return await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'lang':'en',
        'Authorization': token??''
      },
    );
  }

  static Future<http.Response> postData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String token
  })async {
    return await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'lang':'en',
        'Authorization': token??''
      },
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> updateData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String token
  })async {
    return await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'lang':'en',
        'Authorization': token??''
      },
      body: jsonEncode(data),
    );
  }
}