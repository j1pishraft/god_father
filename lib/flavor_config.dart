import 'package:flutter/material.dart';
import 'package:god_father/core/app_envs.dart';



class FlavorSettings {
  final Color appBarColor;
  final String appTitle;
  FlavorSettings({required this.appTitle, required this.appBarColor});
}
class FlavorConfig{
  final String env;
  final FlavorSettings settings;

  static FlavorConfig? _instance;

  factory FlavorConfig({required String env, required FlavorSettings settings}){
    return _instance ??= FlavorConfig._internal(env: env, settings: settings, );
  }

  FlavorConfig._internal({required  this.env, required  this.settings});

  static FlavorConfig get instance => _instance!;

  bool get isProd => _instance?.env == Environment.prod;
  bool get isDev => _instance?.env == Environment.dev;

  Color get appbarColor => _instance!.settings.appBarColor;
  String get appTitle => _instance!.settings.appTitle;

}
Map<String, FlavorSettings> baseMapSettings = {
  Environment.dev: FlavorSettings(appTitle: "God Father [dev]", appBarColor: Colors.red),
  Environment.prod: FlavorSettings(appTitle: "God Father", appBarColor: Colors.green),
};

























class Car{
  final String name;
  final String family;
  Car(this.name, this.family);
  Car._internal(this.name, this.family);
  factory Car.withName(String fullName) {
    final names = fullName.split(' ');
    return Car._internal(names[0], names[1]);
  }
}

// void main(){
  final car = Car('','');
//   print(car.name);
// }


String bracketCombinations(int num) {
  // Function to calculate factorial
  String factorial(int n) {

    print((n == 0 || n == 1) ? '1' : '$n * ${factorial(n - 1)}');
    return (n == 0 || n == 1) ? '1' : '$n * ${factorial(n - 1)}';
  }

  // Calculate the Catalan number using the formula
  return factorial(num);
}
// void main() {
//   // Example usage:
//   // debugPrint(bracketCombinations(3)); // Output: 5
//   print(returnDuplicateNum([1,1,2,2,2,2,3,3,1]));
//   // print(bracketCombinations1(3)); // Output: 5
// }

String returnDuplicateNum(List<int> intList){

  List<int> duplicatedNumber = [];
  var n =0;
  for(int num in intList){

    if(!duplicatedNumber.contains(num)){

      duplicatedNumber.add(num);
    }else{
      n++;
    }
  }
  return "$n";

}

String minWindowSubstring(List<String> strArr) {
  String strN = strArr[0];
  String strK = strArr[1];

  Map<String, int> charCountK = {};
  Map<String, int> charCountN = {};

  // Initialize charCountK with character counts from strK
  for (int i = 0; i < strK.length; i++) {
    // strK = aaed
    // 0 = a
    //charCountK[a] = 2
/*  {
    a : 2,
    e : 1,
    d : 1
  }*/

  // jsonData["person"] = "Jay"
  //charCountK[e] = charCountK.containsKey(e) ? ..... => charCountK[e] = 1
    charCountK[strK[i]] = charCountK.containsKey(strK[i]) ? charCountK[strK[i]]! + 1 : 1;
    print(charCountK[strK[i]]);
  }

  int start = 0; // Start index of the sliding window
  int minLength = 100;
  int minStart = 0;
  int charKFound = 0; // Count of characters in strK found in the current window

  for (int end = 0; end < strN.length; end++) {
    // Update charCountN for the current character in the window
    charCountN[strN[end]] = charCountN.containsKey(strN[end]) ? charCountN[strN[end]]! + 1 : 1;

    // Check if the current character is in strK and found in the current window
    if (charCountK.containsKey(strN[end]) && charCountN[strN[end]]! <= charCountK[strN[end]]!) {
      charKFound++;
    }

    // Check if all characters in strK are found in the current window
    while (charKFound == strK.length) {
      // Update the minimum window length and start index
      if (end - start + 1 < minLength) {
        minLength = end - start + 1;
        minStart = start;
      }

      // Move the start index to the right to try to shrink the window
      charCountN[strN[start]] = charCountN[strN[start]]! - 1;

      // Check if a character in strK is no longer in the window
      if (charCountK.containsKey(strN[start]) && charCountN[strN[start]]! < charCountK[strN[start]]!) {
        charKFound--;
      }

      start++;
    }
  }

  // Return the smallest substring containing all characters in strK
  return minLength == double.infinity ? "" : strN.substring(minStart, minStart + minLength);
}
String MinWindowSubstring(List<String> strArr) {
  String N = strArr[0];
  String K = strArr[1];

  Map<String, int> charCount = {};

  for (int i = 0; i < K.length; i++) {
    charCount[K[i]] = charCount[K[i]] != null ? charCount[K[i]]! + 1 : 1;
  }

  int left = 0;
  int right = 0;
  int minLen = 100;
  String minWindow = "";

  while (right < N.length) {
    if (charCount.containsKey(N[right])) {
      charCount[N[right]] = charCount[N[right]]! - 1;
    }

    while (charCount.values.every((count) => count <= 0)) {
      if (right - left + 1 < minLen) {
        minLen = right - left + 1;
        minWindow = N.substring(left, right + 1);
      }

      if (charCount.containsKey(N[left])) {
        charCount[N[left]] = charCount[N[left]]! + 1;
      }

      left++;
    }

    right++;
  }

  return minWindow;
}

void main() {
  List<String> strArr1 = ["aaabaaddae", "aed"];
  List<String> strArr2 = ["faabdccdbcacd", "aad"];

  // String result1 = MinWindowSubstring(strArr1);
  String result2 = MinWindowSubstring(strArr2);
 var a= 'adfadsfads';
 print (a.substring(1, 3));
 int b;

    // print(result1); // Output: "dae"
  // print(result2); // Output: "aabd"
}

// void main() {
//   // Example usage:
//   print(minWindowSubstring(["aaabaaddae", "aaed"])); // Output: "dae"
//   // print(minWindowSubstring(["aabdccdbcacd", "aad"])); // Output: "aabd"
//   // print(minWindowSubstring(["ahffaksfajeeubsne", "jefaa"])); // Output: "aksfaje"
// }
