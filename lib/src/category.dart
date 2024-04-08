import "package:flutter/widgets.dart";

/// One of the categories in the list. Each category can contain content,
/// which can be an empty list, but also nested categories. The nested
/// categories are the same type as the parent category which allows for
/// infinite nesting.
class Category {
  /// Creates a category.
  ///
  /// The [name] is the name of the category. This will be displayed at the
  /// top of the category. If the [customTitle] is set, this will be ignored.
  /// Inside of the [content] you can put any widget you want. This will be
  /// displayed after the title of the category. If the category has nested
  /// categories, the content will be displayed before the nested categories.
  /// The [nestedCategories] are the nested categories of this category. This
  /// can be an empty list if there are no nested categories.
  const Category({
    this.name,
    this.customTitle,
    this.content = const <Widget>[],
    this.nestedCategories = const <Category>[],
  }) : assert(
          name != null || customTitle != null,
          "A name or a custom title must be set",
        );

  /// The name of the category.
  final String? name;

  /// Optional custom title widget for the category. This will be displayed
  /// at the top of the category. If set, the text title will be ignored.
  /// This will be displayed before the content of the category.
  final Widget? customTitle;

  /// The content of the category. This can be anything, but is usually
  /// a list of widgets.
  ///
  /// Default is an empty list.
  ///
  /// If the category has nested categories, it will show this content
  /// before the nested categories.
  final List<Category> nestedCategories;

  /// The nested categories of this category. This can be an empty list
  /// if there are no nested categories.
  ///
  /// Default is an empty list.
  final List<Widget> content;
}
