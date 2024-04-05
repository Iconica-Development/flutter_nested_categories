import "package:flutter/material.dart";
import "package:flutter_nested_categories/flutter_nested_categories.dart";

/// This widget displays a list of categories. Each category can contain
/// content, which can be an empty list, but also nested categories. The
/// nested categories are the same type as the parent category which allows
/// for infinite nesting.
///
/// The content of the categories is displayed in the order it is given in
/// the list. If a category has nested categories, the content of the nested
/// categories is displayed after the content of the parent category.
class CategoryList extends StatelessWidget {
  const CategoryList({
    required this.content,
    this.headerStyling,
    this.headerCentered = false,
    this.customTitle,
    this.title,
    this.titleStyle,
    this.titleCentered = false,
    this.isCategoryCollapsible = true,
    this.categoryDepth = 0,
    super.key,
  });

  /// Optional title for the category list. This will be displayed at the
  /// top of the list.
  final String? title;

  /// Optional custom title widget for the category list. This will be
  /// displayed at the top of the list. If set, the text title will be
  /// ignored.
  final Widget? customTitle;

  /// Optional title style for the title of the category list. This will
  /// be applied to the title of the category list. If not set, the default
  /// text style will be used.
  final TextStyle? titleStyle;

  /// Configure if the title should be centered.
  ///
  /// Default is false.
  final bool titleCentered;

  /// Optional header styling for the categories. This will be applied to
  /// the name of the categories. If not set, the default text style will
  /// be used.
  final CategoryHeaderStyling? headerStyling;

  /// Configure if the category header should be centered.
  ///
  /// Default is false.
  final bool headerCentered;

  /// Configure if the category should be collapsible.
  ///
  /// Default is true.
  final bool isCategoryCollapsible;

  /// The depth of the category list. This is used to keep track of
  /// the depth of the categories. This is used internally and should
  /// not be set manually.
  final int categoryDepth;

  /// The content of the category list. This is a list of categories.
  final List<Category> content;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null || customTitle != null)
              titleCentered
                  ? Center(
                      child: _CategoryTitle(
                        title: title,
                        titleStyle: titleStyle,
                        customTitle: customTitle,
                      ),
                    )
                  : _CategoryTitle(
                      title: title,
                      titleStyle: titleStyle,
                      customTitle: customTitle,
                    ),
            ...content.map(
              (category) => _CategoryColumn(
                category: category,
                headerCentered: headerCentered,
                headerStyling: headerStyling,
                collapsible: isCategoryCollapsible,
                categoryDepth: categoryDepth,
              ),
            ),
          ].toList(),
        ),
      );
}

class _CategoryTitle extends StatelessWidget {
  const _CategoryTitle({
    this.customTitle,
    this.title,
    this.titleStyle,
  }) : assert(
          customTitle != null || title != null,
          "Either customTitle or title must be set.",
        );

  final String? title;
  final Widget? customTitle;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var styleOfTitle = titleStyle ?? theme.textTheme.titleLarge;

    return customTitle ??
        Text(
          title!,
          style: styleOfTitle,
        );
  }
}

class _CategoryColumn extends StatefulWidget {
  const _CategoryColumn({
    required this.category,
    required this.categoryDepth,
    required this.headerCentered,
    this.headerStyling,
    this.collapsible = true,
  });

  final Category category;
  final CategoryHeaderStyling? headerStyling;
  final bool headerCentered;
  final int categoryDepth;
  final bool collapsible;

  @override
  State<_CategoryColumn> createState() => _CategoryColumnState();
}

class _CategoryColumnState extends State<_CategoryColumn> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var styleOfCategory =
        widget.headerStyling?.headerStyles[widget.categoryDepth] ??
            widget.headerStyling?.defaultStyle ??
            theme.textTheme.titleMedium ??
            const TextStyle();

    String? formatCategoryName() {
      var name = widget.category.name;
      if (name == null) return null;

      switch (widget.headerStyling?.capitalization) {
        case CategoryHeaderCapitalization.capitalizeFirstLetter:
          return name[0].toUpperCase() + name.substring(1);
        case CategoryHeaderCapitalization.lowercase:
          return name.toLowerCase();
        case CategoryHeaderCapitalization.uppercase:
          return name.toUpperCase();
        case CategoryHeaderCapitalization.none:
        default:
          return name;
      }
    }

    Widget buildCollapsibleHeader(TextStyle styleOfCategory) => InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: widget.headerCentered
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              ExpandIcon(
                onPressed: (value) => setState(() {
                  _isExpanded = !_isExpanded;
                }),
                isExpanded: _isExpanded,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 8),
              if (widget.category.customTitle != null)
                widget.category.customTitle!
              else
                Text(
                  formatCategoryName()!,
                  style: styleOfCategory,
                ),
            ],
          ),
        );

    Widget buildNonCollapsibleHeader(TextStyle styleOfCategory) =>
        widget.headerCentered
            ? Center(
                child: widget.category.customTitle != null
                    ? widget.category.customTitle!
                    : Text(
                        formatCategoryName()!,
                        style: styleOfCategory,
                      ),
              )
            : widget.category.customTitle != null
                ? widget.category.customTitle!
                : Text(
                    formatCategoryName()!,
                    style: styleOfCategory,
                  );

    Widget buildNestedCategoryList() => CategoryList(
          content: widget.category.nestedCategories,
          headerCentered: widget.headerCentered,
          headerStyling: widget.headerStyling,
          isCategoryCollapsible: widget.collapsible,
          categoryDepth: widget.categoryDepth + 1,
        );

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.collapsible) ...[
            buildCollapsibleHeader(styleOfCategory),
          ] else ...[
            buildNonCollapsibleHeader(styleOfCategory),
          ],
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.category.content.isNotEmpty)
                  ...widget.category.content,
                if (widget.category.nestedCategories.isNotEmpty)
                  buildNestedCategoryList(),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
