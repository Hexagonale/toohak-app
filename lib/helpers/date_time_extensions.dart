extension DateTimeExtensions<T extends DateTime> on T {
  String get readable {
    final String day = this.day.toString().padLeft(2, '0');
    final String month = this.month.toString().padLeft(2, '0');
    final String year = this.year.toString();

    return '$day.$month.$year';
  }

  String get readableTime {
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}
