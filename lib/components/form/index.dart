import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

Widget renderFormItem(FormBaseOption item) {
  Widget right;
  Widget child;
  dynamic value = item.value;
  double max = item.max;
  double min = item.min;
  List<String Function(dynamic)> validators = item.validators;

  switch (item.type) {
    case 'input':
      right = FormBuilderTextField(
        attribute: item.attr,
        textAlign: TextAlign.right,
        initialValue: value,
        validators: validators,
        decoration: InputDecoration(border: InputBorder.none),
      );
      break;
    case 'number':
      child = FormBuilderSlider(
        attribute: item.attr,
        min: min,
        max: max,
        // textAlign: TextAlign.right,
        initialValue: value,
        valueTransformer: (value) {
          if (value == null || value == '') return 0;

          double val = math.max(min, math.min(max, value));
          return val;
        },
        validators: [
          FormBuilderValidators.numeric(),
          ...validators
        ],
        decoration: InputDecoration(border: InputBorder.none),
      );
      break;
    case 'switch':
      right = FormBuilderSwitch(
        attribute: item.attr,
        label: Text(''),
        initialValue: value,
        validators: validators,
        decoration: InputDecoration.collapsed(hintText: ''),
      );
      break;
  }

  return child ?? ListTile(
    title: Text(item.title),
    trailing: SizedBox(
      width: 200.0,
      child: right,
    ),
  );
}

class FormBaseOption<T> {
  String title;
  String attr;
  String type;
  T value;
  List<String Function(dynamic)> validators;
  double min;
  double max;

  FormBaseOption({
    this.title = '',
    this.attr = '',
    this.type = 'switch',
    this.value,
    this.validators = const [],
    this.min = 0,
    this.max = 100,
  });
}