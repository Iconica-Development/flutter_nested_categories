/// An enum that represents the capitalization of the category header.
/// This is used to determine how the header should be displayed.
/// The header is the name of the category.
enum CategoryHeaderCapitalization {
  /// The first letter of the header will be capitalized.
  capitalizeFirstLetter,

  /// The header will be displayed in all lowercase.
  lowercase,

  /// The header will be displayed in all uppercase.
  uppercase,

  /// The header will be displayed as is.
  none,
}
