extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this list with name [name].
  ///
  /// Modified from [byName] in [EnumByName] from enum.dart in dart:core
  /// Goes through this collection looking for an enum with
  /// name [name], as reported by [EnumName.name].
  /// Returns the first value with the given name, or null if not found
  T? byNameOrNull(String name) {
    for (var value in this) {
      if (value.name == name) return value;
    }
    // Used to throw ArgumentError now returns null
    return null;
  }
}
