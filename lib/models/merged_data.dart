List<MergedData> mergedDataFromJSON(List<Map<String, dynamic>> mergedData) =>
    List<MergedData>.from(mergedData.map((x) => MergedData.fromJson(x)));

class MergedData {
  final String itemId;
  final String itemName;
  final double quantity;

  const MergedData({
    required this.itemId,
    required this.itemName,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemId': this.itemId,
      'itemName': this.itemName,
      'quantity': this.quantity,
    };
  }

  factory MergedData.fromJson(Map<String, dynamic> map) {
    return MergedData(
      itemId: map['item_id'].toString(),
      itemName: map['item_name'] as String,
      quantity: double.parse(map['quantity']),
    );
  }
}
