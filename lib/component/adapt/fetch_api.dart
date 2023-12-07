import 'package:flutter/material.dart';
import 'package:sales_management/utils/typedef.dart';

typedef SuccessBuilder<T> = ReturnCallbackArg<T, Widget>;

class FetchAPI<T> extends StatelessWidget {
  final Future<T> future;
  final SuccessBuilder<T> successBuilder;
  final Widget? loading;
  const FetchAPI(
      {super.key,
      required this.future,
      required this.successBuilder,
      this.loading});

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
        return loading != null
            ? loading!
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
