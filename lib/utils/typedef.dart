typedef VoidCallbackArg<T> = void Function(T);

typedef ReturnCallbackArg<T, R> = R Function(T);

typedef ReturnCallbackArgAsync<T, R> = Future<R> Function(T);

typedef ReturnCallbackAsync<R> = Future<R> Function();
