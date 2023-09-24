import 'package:flutter/material.dart';

typedef SuccessBuilder<T> = Widget Function(T data);

class FetchAPI<T> extends StatelessWidget {
  final Future<T> future;
  final SuccessBuilder<T> successBuilder;
  const FetchAPI(
      {super.key, required this.future, required this.successBuilder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return successBuilder(data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}