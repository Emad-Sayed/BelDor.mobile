import 'dart:async';
import 'dart:convert';

import 'package:bel_dor/models/general_response.dart';
import 'package:bel_dor/models/login_success_response.dart';
import 'package:bel_dor/models/register_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'result.dart';

class NetworkClient {
  static const String _baseUrl = "http://emaddemo-001-site1.itempurl.com/api";

  Future<http.Response> request(
      {@required RequestType requestType,
        @required String path,
        dynamic parameter,
        dynamic queryParameters,
        Map<String, String> authHeader}) async {
    print("\n$queryParameters\n");
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    if (authHeader != null) header.addAll(authHeader);
    print('"$_baseUrl/$path"');
    switch (requestType) {
      case RequestType.GET:
        return await http.get(
            Uri(
                scheme: "http",
                host: 'emaddemo-001-site1.itempurl.com',
                path: 'api/$path',
                queryParameters: queryParameters),
            headers: header);
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

  Future<Result> getTickets({String token,
    String specificDay,
    List<String> statusIds,
    List<String> branchIds,
    List<String> departmentIds,
    String pageNumber,
    String pageSize}) async {
    try {
      final response = await request(
          requestType: RequestType.GET,
          path: "Ticket/VisitorDailyTickets",
          queryParameters: {
            "specificDay": specificDay,
            "statusIds": statusIds,
            "branchIds": branchIds,
            "departementIds": departmentIds,
            "pageNumber": pageNumber,
            "pageSize": pageSize
          },
          authHeader: {
            'Authorization': 'Bearer $token',
          });
      print(response.body);
//      if (response.statusCode == 200) {
//        return Result<LoginSuccessResponse>.success(
//            LoginSuccessResponse.fromJson(json.decode(response.body)),
//            response.statusCode);
//      } else if (response.statusCode == 401) {
//        return Result.error(
//            GeneralResponse(message: "email or password incorrect"));
//      } else {
//        return Result.error(GeneralResponse(message: "Server error"));
//      }
    } catch (error) {
      print("ERROR $error");
      return Result.error(GeneralResponse(message: "Code error"));
    }
  }
}

enum RequestType { GET, POST, DELETE }