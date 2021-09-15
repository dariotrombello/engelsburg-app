import 'dart:convert';

import 'package:engelsburg_app/src/widgets/error_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Result {
  Result._of(this.result);

  Result._error(this.error);

  Result._empty();

  Map<String, dynamic>? result;
  ApiError? error;

  bool errorPresent() {
    return error != null;
  }

  bool resultPresent() {
    return result != null;
  }

  factory Result.of(Map<String, dynamic> result) => Result._of(result);

  factory Result.error(ApiError apiError) => Result._error(apiError);

  factory Result.empty() => Result._empty();

  static keepJson(Map<String, dynamic> json) => json;

  void handle<T>(BuildContext context,
      {T Function(Map<String, dynamic>)? parse,
      void Function(T?)? onSuccess,
      void Function(ApiError)? onError}) {
    if (errorPresent() && onError != null) {
      //If error occurred
      onError(error!);
      _handleCommonError(context);
    } else if (onSuccess != null) {
      if (resultPresent() && parse != null) {
        //If result present and valid parse function specified
        onSuccess(parse(result!));
      } else {
        //Empty result or no parse function
        onSuccess(null);
      }
    }
  }

  void _handleCommonError(BuildContext context) {
    if (errorPresent()) {
      //Handle errors
      if (error!.status == 0) {
        //Custom status to handle fetching errors
        //TODO: no network connection, error fetching
      } else if (error!.status == 400) {
        if (error!.extra.contains('token')) {
          if (error!.messageKey == 'EXPIRED') {
            //TODO: get new JWT
          } else if (error!.messageKey == 'INVALID' ||
              error!.messageKey == 'FAILED') {
            //TODO: try to login again
          }
        }
      } else if (error!.status == 401) {
        //TODO: need to be logged in
      } else if (error!.status == 403) {
        //TODO: don't permitted
      }
    }
  }

  Widget build<T>(BuildContext context,
      {T Function(Map<String, dynamic>)? parse,
      required Widget Function(T) onSuccess,
      Widget? Function(ApiError)? onError}) {
    Widget? ret;
    if (errorPresent()) {
      //If error occurred
      if (onError != null) ret = onError(error!);
      return ret ?? _buildCommonError(context); //If error wasn't handled
    } else {
      if (resultPresent() && parse != null) {
        //If result present and valid parse function specified
        return onSuccess(parse(result!));
      } else {
        //Empty result or no parse function
        return const ErrorBox();
      }
    }
  }

  Widget _buildCommonError(BuildContext context) {
    if (errorPresent()) {
      //Handle errors
      if (error!.status == 0) {
        //Custom status to handle fetching errors
        //TODO: no network connection, error fetching
      } else if (error!.status == 400) {
        if (error!.extra.contains('token')) {
          if (error!.messageKey == 'EXPIRED') {
            //TODO: get new JWT
          } else if (error!.messageKey == 'INVALID' ||
              error!.messageKey == 'FAILED') {
            //TODO: try to login again
          }
        }
      } else if (error!.status == 401) {
        //TODO: need to be logged in
      } else if (error!.status == 403) {
        //TODO: don't permitted
      }
    }

    return const ErrorBox();
  }
}

class ApiError {
  final int status;
  final String messageKey;
  final String extra;

  ApiError({required this.status, this.messageKey = '', this.extra = ''});

  factory ApiError.tryDecode(Response response) {
    try {
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json.containsKey("status")) {
          return ApiError.fromJson(json);
        }
      }
    } catch (_) {}

    return ApiError.fromStatus(response.statusCode);
  }

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
      status: json['status'],
      messageKey: json['messageKey'],
      extra: json['extra']);

  factory ApiError.fromStatus(int status) => ApiError(status: status);

  bool get isForbidden => status == 403 && messageKey == 'FORBIDDEN';
  bool get isNotFound => status == 404 && messageKey == 'NOT_FOUND';

  bool get isAlreadyExisting => status == 409 && messageKey == 'ALREADY_EXISTS';
}
