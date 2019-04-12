// Code from https://github.com/namhyun-gu/preference-helper
import 'package:meta/meta.dart';

class Preference<T> {
  String key;
  T value;
  T initValue;

  Preference({
    @required this.key,
    this.value,
    @required this.initValue,
  });

  @override
  String toString() {
    return 'Preference{key: $key, value: $value, initValue: $initValue}';
  }

  Type typeOfPreference() => T;
}
