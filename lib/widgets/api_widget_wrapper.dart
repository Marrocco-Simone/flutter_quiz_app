import 'dart:developer';
import 'package:flutter/material.dart';

typedef ApiCall<T> = Future<T> Function();
typedef GetChild<T> = Widget Function(T result);

class ApiWidgetWrapper<T> extends StatefulWidget {
  final ApiCall<T> apiCall;
  final GetChild<T> getChild;
  const ApiWidgetWrapper(this.apiCall, this.getChild, {super.key});

  @override
  State<ApiWidgetWrapper<T>> createState() {
    return ApiWidgetWrapperState<T>();
  }
}

class ApiWidgetWrapperState<T> extends State<ApiWidgetWrapper<T>> {
  Future<T>? _future;

  getFuture() {
    setState(() {
      _future = widget.apiCall();
    });
  }

  @override
  void initState() {
    super.initState();
    getFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredText("Waiting for an operation result.");
          } else if (snapshot.hasError) {
            final errorString = snapshot.error.toString();
            final errorStringCutted =
                errorString.substring(0, errorString.length - 4);

            log(errorStringCutted);
            log(snapshot.stackTrace.toString());

            return CenteredText("Error in operation: $errorStringCutted");
          } else if (!snapshot.hasData) {
            return const CenteredText("No operation result yet.");
          } else {
            T result = snapshot.data as T;
            return widget.getChild(result);
          }
        });
  }
}

class CenteredText extends StatelessWidget {
  final String text;
  const CenteredText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50000,
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }
}
