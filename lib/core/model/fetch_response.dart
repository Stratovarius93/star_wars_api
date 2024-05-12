class FetchResponse<T> {
  final List<T> list;
  final int totalItems;
  final int totalPages;
  FetchResponse(
      {this.list = const [], this.totalItems = 0, this.totalPages = 0});
}
