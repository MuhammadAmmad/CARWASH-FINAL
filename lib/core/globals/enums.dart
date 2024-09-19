enum ControllerStatus {
  sold,
  notSold,
}

extension ProductStatusExtension on ControllerStatus {
  String get stringValue {
    switch (this) {
      case ControllerStatus.sold:
        return "sold";
      case ControllerStatus.notSold:
        return "not sold";
    }
  }

  static ControllerStatus fromString(String status) {
    switch (status) {
      case "sold":
        return ControllerStatus.sold;
      case "not sold":
        return ControllerStatus.notSold;
      default:
        throw ArgumentError("Invalid product status: $status");
    }
  }
}