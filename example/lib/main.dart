import "package:flutter/material.dart";
import "package:flutter_nested_categories/flutter_nested_categories.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Nested Categories Example"),
        ),
        body: CategoryList(
          title: "This is the title of the list",
          titleCentered: true,
          headerCentered: false,
          isCategoryCollapsible: true,
          headerStyling: CategoryHeaderStyling(
            headerStyles: {
              0: theme.textTheme.titleLarge?.copyWith(color: Colors.red),
              2: theme.textTheme.titleLarge?.copyWith(color: Colors.blue),
            },
            defaultStyle:
                theme.textTheme.titleLarge!.copyWith(color: Colors.green),
            capitalization: CategoryHeaderCapitalization.uppercase,
          ),
          content: [
            Category(
              name: "category 1",
              content: [
                const Text("Content 1"),
                Image.network(
                    "https://via.placeholder.com/150?text=Content+2+Image",),
              ],
              nestedCategories: [
                const Category(
                  name: "Category 1.1",
                  content: [
                    Text("Content 1.1"),
                    Text("Content 1.2"),
                  ],
                  nestedCategories: [
                    Category(
                      name: "Category 1.1.1",
                      content: [
                        Text("Content 1.1.1"),
                        Text("Content 1.1.2"),
                      ],
                    ),
                    Category(
                      name: "Category 1.1.2",
                      content: [
                        Text("Content 1.1.2"),
                        Text("Content 1.1.2"),
                      ],
                    ),
                  ],
                ),
                const Category(
                  name: "Category 1.2",
                  content: [
                    Text("Content 1.2"),
                    Text("Content 1.2"),
                  ],
                ),
              ],
            ),
            const Category(
              name: "Category 2",
              content: [
                Text("Content 2"),
                Text("Content 2"),
              ],
              nestedCategories: [
                Category(
                  name: "Category 2.1",
                  content: [
                    Text("Content 2.1"),
                    Text("Content 2.2"),
                  ],
                  nestedCategories: [
                    Category(
                      name: "Category 2.1.1",
                      content: [
                        Text("Content 2.1.1"),
                        Text("Content 2.1.2"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
