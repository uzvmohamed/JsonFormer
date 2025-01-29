String str = '''[
 { "field_name": "f1", "widget": "dropdown", "valid_values": ["A", "B"] },
 { "field_name": "f2", "widget": "textfield", "visible": "f1=='A'" },
 { "field_name": "f3", "widget": "textfield", "visible": "f1=='A'" },
 { "field_name": "f4", "widget": "textfield", "visible": "f1=='A'" },
 { "field_name": "f5", "widget": "textfield", "visible": "f1=='B'" },
 { "field_name": "f6", "widget": "textfield", "visible": "f1=='B'" }
]''';

String jsonStr = '''
{"fields": $str}
''';
