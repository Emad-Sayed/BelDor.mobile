import 'dart:async';
import 'dart:convert';

import 'package:bel_dor/models/general_response.dart';
import 'package:bel_dor/models/login_success_response.dart';
import 'package:bel_dor/models/register_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'result.dart';

/// In this implementation:
///
/// 1- All the requests made through this client will go to the baseUrl, i.e. the book_api’s url.
///
/// 2- NetworkClient uses the http.dart Client internally.
///    A Client is an interface for HTTP clients that takes care of maintaining
///    persistent connections across multiple requests to the same server.
///
/// 3- The request() method takes the following parameters:-
///      -RequestType is an enum class holding the different type of HTTP methods available.
///      -path is the endpoint to which the request has to be made.
///      -parameter holds the additional information to make a successful HTTP request. For example: body for a POST request.
///
/// 4- The request() method executes the proper HTTP request based on the requestType specified.
class NetworkClient {
  // 1
  static const String _baseUrl = "http://emaddemo-001-site1.itempurl.com/api";

  // 3
  Future<http.Response> request(
      {@required RequestType requestType,
      @required String path,
      dynamic parameter,
      Map<String, String> authHeader}) async {
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    if (authHeader != null) header.addAll(authHeader);
    print('"$_baseUrl/$path"');
    switch (requestType) {
      case RequestType.GET:
        return await http.get("$_baseUrl/$path", headers: header);
      case RequestType.POST:
        print("$parameter\n${json.encode(parameter)}");
        return await http.post("$_baseUrl/$path",
            headers: header, body: json.encode(parameter));
      case RequestType.DELETE:
        return await http.delete("$_baseUrl/$path", headers: header);
      default:
        return throw Exception("The HTTP request method is not found");
    }
  }

  Future<Result> register(
      {String username, String email, String password, String phone}) async {
    try {
      final response = await request(
          requestType: RequestType.POST,
          path: "User/CreateVisistor",
          parameter: {
            "userName": username,
            "email": email,
            "password": password,
            "phone": phone
          });
      print(response.body);
      if (response.statusCode == 200) {
        return Result<RegisterResponse>.success(
            RegisterResponse.fromJson(json.decode(response.body)),
            response.statusCode);
      } else {
        return Result<RegisterResponse>.error(
            RegisterResponse.fromJson(json.decode(response.body)));
      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(
          RegisterResponse(errorEN: "Code error", errorAR: "خطأ"));
    }
  }

  Future<Result> login({String username, String password}) async {
    try {
      final response = await request(
          requestType: RequestType.POST,
          path: "Auth",
          parameter: {"userName": username, "password": password});
      print(response.body);
      if (response.statusCode == 200) {
        return Result<LoginSuccessResponse>.success(
            LoginSuccessResponse.fromJson(json.decode(response.body)),
            response.statusCode);
      } else if (response.statusCode == 401) {
        return Result.error(
            GeneralResponse(message: "email or password incorrect"));
      } else {
        return Result.error(GeneralResponse(message: "Server error"));
      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(GeneralResponse(message: "Code error"));
    }
  }
}

enum RequestType { GET, POST, DELETE }
