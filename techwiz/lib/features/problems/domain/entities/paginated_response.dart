class PaginatedResponse<T> {
  final List<T> content;
  final int totalPages;
  final int totalElements;
  final int currentPage;
  final int pageSize;
  final bool isFirst;
  final bool isLast;

  const PaginatedResponse({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.currentPage,
    required this.pageSize,
    required this.isFirst,
    required this.isLast,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final List<dynamic> contentJson = json['content'] ?? [];
    return PaginatedResponse(
      content: contentJson.map((item) => fromJsonT(item)).toList(),
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      currentPage: json['number'] ?? 0,
      pageSize: json['size'] ?? 10,
      isFirst: json['first'] ?? true,
      isLast: json['last'] ?? false,
    );
  }
}
