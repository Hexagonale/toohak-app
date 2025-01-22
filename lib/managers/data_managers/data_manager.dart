import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataManager<T> {
  @protected
  final BehaviorSubject<Map<String, T>> _data = BehaviorSubject<Map<String, T>>.seeded(<String, T>{});

  Stream<List<T>> get data$ => _data.stream.map((Map<String, T> data) => data.values.toList());

  Stream<T?> dataForId$(String id) => _data.stream.map((Map<String, T> data) => data[id]);

  List<T> get lastKnownValues => _data.value.values.toList();

  T? lastKnownValueForId(String id) => _data.value[id];

  /// deleteWhere is using to delete old values which doesn't exists.
  /// For example when you delete something and fetch again data, value still exists in map so we need to delete
  /// it first if we update stream with using current value.
  void updateStreamWith(Map<String, T?> updatedData, {bool Function(T item)? deleteWhere}) {
    final Map<String, T> currentValues = _data.value;
    if (deleteWhere != null) {
      currentValues.removeWhere((_, T value) => deleteWhere(value));
    }

    for (String id in updatedData.keys) {
      final T? data = updatedData[id];

      if (data == null) {
        currentValues.remove(id);
      } else {
        currentValues[id] = data;
      }
    }

    _data.add(currentValues);
  }
}
