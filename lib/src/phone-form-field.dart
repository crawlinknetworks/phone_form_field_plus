import 'package:country_list/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_picker_dialog_plus/list_picker_dialog_plus.dart';

class PhoneNumber {
  String? number;
  Country country;
  PhoneNumber(this.number, this.country);

  @override
  String toString() {
    return '{number: $number, country: {name: ${country.name}, isoCode: ${country.isoCode}, dialCode: ${country.dialCode} } }';
  }
}

class PhoneFormField extends StatefulWidget {
  final ValueNotifier<PhoneNumber>? controller;
  final String? Function(PhoneNumber?)? validator;
  final void Function(PhoneNumber?)? onSave;
  final void Function(PhoneNumber?)? onChanged;
  final ValueChanged<PhoneNumber>? onFieldSubmitted;
  final int maxLength;
  final InputDecoration? decoration;

  PhoneFormField({
    Key? key,
    this.controller,
    this.validator,
    this.onSave,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLength = 10,
    this.decoration,
  }) : super(key: key);

  @override
  _PhoneFormFieldState createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  InputDecoration? _decoration;

  Country? _selectedCountry;

  TextEditingController _controller = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _selectedCountry = widget.controller!.value.country;
    } else {
      _selectedCountry = _findCountryByCode("US");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _decoration = _initDecoration();
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      maxLength: widget.maxLength,
      decoration: _decoration,
      validator: (str) {
        if (widget.validator != null) {
          String? number = (str ?? '').isNotEmpty
              ? '${_selectedCountry!.dialCode}$str'
              : null;
          widget.validator!(PhoneNumber(number, _selectedCountry!));
        }
      },
      onFieldSubmitted: (str) {
        if (widget.validator != null) {
          String? number =
              (str).isNotEmpty ? '${_selectedCountry!.dialCode}$str' : null;
          widget.onFieldSubmitted!(PhoneNumber(number, _selectedCountry!));
        }
      },
      onChanged: (str) {
        String? number =
            (str).isNotEmpty ? '${_selectedCountry!.dialCode}$str' : null;
        PhoneNumber phoneNumber = PhoneNumber(number, _selectedCountry!);
        if (widget.validator != null) {
          widget.onChanged!(phoneNumber);
        }
        if (widget.controller != null) {
          widget.controller!.value = phoneNumber;
        }
      },
      onSaved: (str) {
        if (widget.validator != null) {
          String? number = (str ?? '').isNotEmpty
              ? '${_selectedCountry!.dialCode}$str'
              : null;
          widget.onSave!(PhoneNumber(number, _selectedCountry!));
        }
      },
    );
  }

  _initDecoration() {
    return (widget.decoration ??
            InputDecoration(labelText: 'Phone', border: OutlineInputBorder()))
        .copyWith(
      counterText: "",
      prefix: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Text(_selectedCountry!.dialCode),
        ),
        onTap: () async {
          Country? res = await showListPicker<Country>(
              context: context,
              filterFn: (dynamic item, str) =>
                  item.name.toLowerCase().indexOf(str.toLowerCase()) >= 0,
              findFn: (str) async => Countries.list,
              listItemFn: (dynamic item, position, focused, selected, onTap) =>
                  ListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                          color: selected ? Colors.blue : Colors.black87),
                    ),
                    leading: Text(item.dialCode,
                        style: TextStyle(
                            color: selected ? Colors.blue : Colors.black87)),
                    tileColor: focused
                        ? Color.fromARGB(10, 0, 0, 0)
                        : Colors.transparent,
                    onTap: onTap,
                  ));

          if (res != null) {
            setState(() {
              _selectedCountry = res;
            });
          }
        },
      ),
    );
  }

  Country _findCountryByCode(String code) {
    return Countries.list.firstWhere((country) => country.isoCode == code);
  }
}
