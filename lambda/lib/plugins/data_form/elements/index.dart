import 'package:flutter/material.dart';
import 'checkbox.dart';
import 'element_option.dart';
import 'input.dart';
import 'select.dart';
import 'radio.dart';
import 'dateTime.dart';
import 'subForm/subForm.dart';
import '../rule.dart';

Widget element(
    Map<String, dynamic> form,
    Map<dynamic, dynamic> meta,
    /*InputDecoration decoration,*/ void Function(
            String component, dynamic value)
        onChange,
    {String type = "",
    String key = "",
    String label = "",
    List<FormFieldValidator>? rules,
    dynamic relations}) {
  switch (type) {
    case "SubForm":
      {
        return new SubformWidget(ElementOption(
          key,
          label,
          form,
          meta,
          onChange,
          rules: rules,
        ));
      }

    case "Text":
      {
        return new InputWidget(ElementOption(
          key,
          label,
// decoration,
          form,
          meta,

          onChange,
          rules: rules,
        ));
      }

    case "Textarea":
      {
        return new InputWidget(
          ElementOption(
            key,
            label,
// decoration,
            form,
            meta,

            onChange,
            rules: rules,
          ),
          maxLines: 4,
        );
      }

    case "CK":
      {
        return new InputWidget(
          ElementOption(
            key,
            label,
            //     decoration,
            form,
            meta,

            onChange,
            rules: rules,
          ),
          maxLines: 4,
        );
      }

    case "Number":
      {
        return new InputWidget(
          ElementOption(
            key,
            label,
// decoration,
            form,
            meta,

            onChange,
            rules: rules,
          ),
          keyboardType: TextInputType.number,
        );
      }

    case "Password":
      {
        return new InputWidget(
          ElementOption(
            key,
            label,
// decoration,
            form,
            meta,

            onChange,
            rules: rules,
          ),
          obscureText: true,
        );
      }

    case "Email":
      {
        var emailValidation = getRule("email");
        return new InputWidget(ElementOption(
          key,
          label,
          //    decoration,
          form,
          meta,

          onChange,
          rules:
              rules != null ? [...rules, emailValidation] : [emailValidation],
        ));
      }

    case "Select":
      {
        return new SelectWidget(ElementOption(
          key,
          label,
          //    decoration,
          form,
          meta,

          onChange,
          rules: rules,
          relations: relations,
        ));
      }

    case "ISelect":
      {
        return new SelectWidget(ElementOption(
          key,
          label,
          //    decoration,
          form,
          meta,

          onChange,
          rules: rules,
          relations: relations,
        ));
      }

    case "Radio":
      {
        return new RadioWidget(ElementOption(
          key,
          label,
          //    decoration,
          form,
          meta,

          onChange,
          rules: rules,
        ));
      }

    case "Checkbox":
      {
        return new CheckboxWidget(ElementOption(
          key,
          label,
          //     decoration,
          form,
          meta,

          onChange,
          rules: rules,
        ));
      }

    case "Date":
      {
        return new DateTimePickerWidget(ElementOption(
          key,
          label,
          //      decoration,
          form,
          meta,

          onChange,
          rules: rules,
        ));
      }

    case "DateTime":
      {
        return new DateTimePickerWidget(
          ElementOption(
            key,
            label,
            //      decoration,
            form,
            meta,

            onChange,
            rules: rules,
          ),
          dateTimeMode: true,
        );
      }

    default:
      {
        return Container();
      }
  }
}
