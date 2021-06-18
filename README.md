# phone_form_field_plus

A lightweight phone number text field fro Flutter

## Getting Started

![](https://github.com/crawlinknetworks/phone_form_field_plus/blob/master/screenshots/screen1.png?raw=true)
![](https://github.com/crawlinknetworks/phone_form_field_plus/blob/master/screenshots/screen2.png?raw=true)

## Install

##### pubspec.yaml
```
phone_form_field_plus: <latest_version>
```

Sample Usage
```

ValueNotifier<PhoneNumber> _phoneCtrl =
      ValueNotifier(PhoneNumber('', Country.isoCode("US")));

// ...


PhoneFormField(
decoration: InputDecoration(
    labelText: "Phone Number", border: OutlineInputBorder()),
controller: _phoneCtrl,
),

```
