class TypographyItem {
  final double size;
  final String label;

  const TypographyItem({required this.size, required this.label});
}

class TypographyFamily {
  final String title;
  final String fontFamily;
  final List<TypographyItem> items;

  const TypographyFamily({
    required this.title,
    required this.fontFamily,
    required this.items,
  });
}
