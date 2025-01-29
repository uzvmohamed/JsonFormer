import 'dart:convert';

class Fields {
  final List<Field>? fields;

  Fields({
    this.fields,
  });

  factory Fields.fromRawJson(String str) =>
      Fields.fromJson(json.decode(str), str);

  String toRawJson() => json.encode(toJson());

  factory Fields.fromJson(Map<String, dynamic> json, param1) => Fields(
        fields: json["fields"] == null
            ? []
            : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fields": fields == null
            ? []
            : List<dynamic>.from(fields!.map((x) => x.toJson())),
      };
}

class Field {
  final String? fieldName;
  final String? widget;
  final List<String>? validValues;
  final String? visible;

  Field({
    this.fieldName,
    this.widget,
    this.validValues,
    this.visible,
  });

  factory Field.fromRawJson(String str) => Field.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        fieldName: json["field_name"],
        widget: json["widget"],
        validValues: json["valid_values"] == null
            ? []
            : List<String>.from(json["valid_values"]!.map((x) => x)),
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "field_name": fieldName,
        "widget": widget,
        "valid_values": validValues == null
            ? []
            : List<dynamic>.from(validValues!.map((x) => x)),
        "visible": visible,
      };
}
