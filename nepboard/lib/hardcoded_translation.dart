Map<String, String> eng_subba = {
  "thank you" : "Nogen"
};

Map<String, String> eng_newa = {
  
};

String translate({required Map translationMap, String? eng, String? indigLang}) {
  if (eng!.isNotEmpty) {
    return translationMap[eng] ?? "";
  }

  for (String indi in translationMap.keys) {

    if (translationMap[indi] == indigLang) {
      return indi;
    }
  }
  return "ERROR";
}
