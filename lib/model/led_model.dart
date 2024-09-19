class LedModel {
  String brightness;
  String color;
  String id;
  String name;
  String state;

  LedModel({
    required this.brightness,
    required this.color,
    required this.id,
    required this.name,
    required this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'brightness': brightness,
      'color': color,
      'id': id,
      'name': name,
      'state': state,
    };
  }

  factory LedModel.fromJson(Map<String, dynamic> json) {
    return LedModel(
      brightness: _ensureString(json['brightness']),
      color: _ensureString(json['color']),
      id: _ensureString(json['id']),
      name: _ensureString(json['name']),
      state: _ensureString(json['state']),
    );
  }

  // Helper method to ensure we always get a String
  static String _ensureString(dynamic value) {
    if (value == null) return '';
    return value is String ? value : value.toString();
  }
}
