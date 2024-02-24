import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placeResultsProvider = ChangeNotifierProvider<PlaceResults>((ref) {
  return PlaceResults();
});

class PlaceResults extends ChangeNotifier{

}