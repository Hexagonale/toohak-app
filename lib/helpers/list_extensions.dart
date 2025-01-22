extension ListExtensions<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    return cast<T?>().firstWhere(
      (T? element) => test(element as T),
      orElse: () => null,
    );
  }

  T? get firstOrNull {
    if (isEmpty) {
      return null;
    }

    return first;
  }
}
