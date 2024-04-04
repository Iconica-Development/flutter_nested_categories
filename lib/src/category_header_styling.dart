import "package:flutter/widgets.dart";
import "package:flutter_nested_categories/src/category_header_capitalization.dart";

/// This class is used to style the headers of the categories in the list.
/// The headers are the names of the categories.
class CategoryHeaderStyling {
  const CategoryHeaderStyling({
    /// The default style for the headers. This will be used if the depth
    /// is not found in the [headerStyles].
    required this.defaultStyle,

    /// The capitalization of the headers. This is used to determine how the
    /// headers should be displayed.
    this.capitalization = CategoryHeaderCapitalization.none,

    /// The styles for the headers. The key is the depth of the category.
    /// The value is the text style for the header.
    this.headerStyles = const {},
  });

  final Map<int, TextStyle?> headerStyles;
  final CategoryHeaderCapitalization capitalization;
  final TextStyle defaultStyle;
}
