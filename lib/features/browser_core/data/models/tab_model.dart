class TabModel {
  final String id;
  final String currentUrl;
  final String title;
  final String? faviconUrl;
  final bool isIncognito;
  final double loadingProgress;
  final DateTime? lastReload;

  TabModel({
    required this.id,
    required this.currentUrl,
    required this.title,
    this.faviconUrl,
    required this.isIncognito,
    this.loadingProgress = 0,
    this.lastReload,
  });

  TabModel copyWith({
    String? id,
    String? currentUrl,
    String? title,
    String? faviconUrl,
    bool? isIncognito,
    double? loadingProgress,
    DateTime? lastReload,
  }) {
    return TabModel(
      id: id ?? this.id,
      currentUrl: currentUrl ?? this.currentUrl,
      title: title ?? this.title,
      faviconUrl: faviconUrl ?? this.faviconUrl,
      isIncognito: isIncognito ?? this.isIncognito,
      loadingProgress: loadingProgress ?? this.loadingProgress,
      lastReload: lastReload ?? this.lastReload,
    );
  }
}
