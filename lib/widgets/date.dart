import 'package:meta/meta.dart';

import '../widgets/dateFormat.dart';
import '../widgets/nullableValidDate.dart';

@immutable
class _Date extends Date {
  _Date({required int day, required int month, required int year})
      : super(
          day: day,
          month: month,
          year: year,
        );
}

/// Base class for other date class objects
@immutable
abstract class Date {
  final int day;
  final int month;
  final int year;

  /// Base class for date objects
  const Date({required this.day, required this.month, required this.year,});

  @override
  bool operator ==(o) {
    return o is Date && day == o.day && month == o.month && year == o.year;
  }

  @override
  int get hashCode => day! ^ month! ^ year!;

  bool _greater(Date nonNullDate, Date other) {
    if (nonNullDate.year! < other.year!) return true;
    if (nonNullDate.year! > other.year!) return false;
    if (nonNullDate.month! < other.month!) return true;
    if (nonNullDate.month! > other.month!) return false;
    if (nonNullDate.day! < other.day!) return true;

    return false;
  }

  bool _smaller(Date nonNullDate, Date other) {
    if (nonNullDate.year! > other.year!) return true;
    if (nonNullDate.year! < other.year!) return false;
    if (nonNullDate.month! > other.month!) return true;
    if (nonNullDate.month! < other.month!) return false;
    if (nonNullDate.day! > other.day!) return true;

    return false;
  }

  Date _convertDateValuesToZeroIfNull(Date date) {
    return _Date(
      day: date.day ?? 0,
      month: date.month ?? 0,
      year: date.year ?? 0,
    );
  }

  /// Checks if [day], [month] or [year] is null
  bool hasNull() {
    return day == null || month == null || year == null;
  }

  bool operator <=(Date other) {
    var nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    var nonNullOtherDate = _convertDateValuesToZeroIfNull(other);

    if (nonNullThisDate == nonNullOtherDate) return true;
    return _greater(nonNullThisDate, nonNullOtherDate);
  }

  bool operator <(Date other) {
    var nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    var nonNullOtherDate = _convertDateValuesToZeroIfNull(other);

    if (nonNullThisDate == nonNullOtherDate) return false;
    return _greater(nonNullThisDate, nonNullOtherDate);
  }

  bool operator >=(Date other) {
    var nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    var nonNullOtherDate = _convertDateValuesToZeroIfNull(other);

    if (nonNullThisDate == nonNullOtherDate) return true;
    return _smaller(nonNullThisDate, nonNullOtherDate);
  }

  bool operator >(Date other) {
    var nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    var nonNullOtherDate = _convertDateValuesToZeroIfNull(other);

    if (nonNullThisDate == nonNullOtherDate) return false;
    return _smaller(nonNullThisDate, nonNullOtherDate);
  }

  /// Concatenates [year], [month] and [day] by [dateFormat] with [separator]
  @override
  String toString([
    DateFormat dateFormat = DateFormat.ymd,
    String separator = '-',
  ]) {
    var day = toStringWithLeadingZeroIfLengthIsOne(this.day!);
    var month = toStringWithLeadingZeroIfLengthIsOne(this.month!);

    String date;
    switch (dateFormat) {
      case DateFormat.ymd:
        date = '$year$separator$month$separator$day';
        break;
      case DateFormat.dmy:
        date = '$day$separator$month$separator$year';
        break;
      case DateFormat.mdy:
        date = '$month$separator$day$separator$year';
        break;
    }
    return date;
  }

  /// If [number] length is 1 add a leading 0 character at concatenation.
  ///
  /// If length is not exactly 1 return normal toString()
  static String toStringWithLeadingZeroIfLengthIsOne(int? number) {
    return number.toString().length == 1
        ? '0${number.toString()}'
        : number.toString();
  }

  /// Returns a new [NullableValidDate] object with either the current values,
  /// or replacing those values with the ones passed in.
  Date copyWith({
    final int? day,
    final int? month,
    final int? year,
    final DateFormat? dateFormat,
  }) {
    return NullableValidDate(
      day: day ?? this.day!,
      month: month ?? this.month!,
      year: year ?? this.year!,
    );
  }
}
