class ListingFilters{
  String name;
  dynamic value;
  int? valueMin;
  int? valueMax;
  String? type;
  ListingFilters({
    required this.name,
    this.value,
    this.type = 'equal',
    this.valueMax,
    this.valueMin
  });
}