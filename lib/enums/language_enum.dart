
import 'dart:convert';

import 'package:flutter/material.dart';

enum Language { english, farsi }

extension LanguageExtension on Language {
  Locale get locale {
    switch (this) {
      case Language.english:
        return const Locale('en');
      case Language.farsi:
        return const Locale('fa');
      default:
        throw Exception("Unsupported language");
    }
  }

  AssetImage get flag {
    switch (this) {
      case Language.english:
        return const AssetImage('assets/icons/uk_flag.png');
      case Language.farsi:
        return const AssetImage('assets/icons/iran_flag.png');
      default:
        throw Exception("Unsupported language");
    }
  }

  String get text {
    switch (this) {
      case Language.english:
        return 'English';
      case Language.farsi:
        return 'فارسی';
      default:
        throw Exception("Unsupported language");
    }
  }
}

// extension LanguageToJson on Language {
//   Map<String, dynamic> toJson() {
//     return {
//       'value': this.index,
//     };
//   }
// }
//
// extension LanguageFromJson on Language {
//   static Language? fromJson(String jsonString) {
//     try {
//       Map<String, dynamic> json = jsonDecode(jsonString);
//       int index = json['value'];
//       return Language.values[index];
//     } catch (e) {
//       print('Error parsing JSON: $e');
//       return null;
//     }
//   }
// }

  Map<String, dynamic> languageToJson(Language language) {
    return {
      'value': language.index,
    };
  }

  Language? languageFromJson(String jsonString) {
    try {
      Map<String, dynamic> json = jsonDecode(jsonString);
      int index = json['value'];
      return Language.values[index];
    } catch (e) {
      debugPrint('Error parsing JSON: $e');
      return null;
    }

}

// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
//
//
// enum Language {
//
//   english(
//     Locale('en'),
//     AssetImage('assets/icons/uk_flag.png'),
//     'English',
//   ),
//   farsi(
//     Locale('fa'),
//     AssetImage('assets/icons/iran_flag.png'),
//     'فارسی',
//   );
//
//
//   /// Add another languages support here
//   const Language(this.value, this.flag, this.text);
//
//   final Locale value;
//   final AssetImage flag;
//   final String text; // Optional: this properties used for ListTile details
// }
//
// // import 'dart:ui';
// //
// // // import '../../../../gen/assets.gen.dart';
// //
// // enum Language {
// //   english(
// //     Locale('en', 'US'),
// //     '🇺🇸',
// //     'English',
// //   ),
// //   indonesia(
// //     Locale('fa'),
// //     '🇮🇷',
// //     'فارسی',
// //   );
// //
// //   /// Add another languages support here
// //   // const Language(this.value, this.image, this.text);
// //   const Language(this.value, this.flag, this.text);
// //
// //   final Locale value;
// //
// //   // final AssetGenImage image; // Optional: this properties used for ListTile details
// //   final String flag;
// //   final String text; // Optional: this properties used for ListTile details
// // }
