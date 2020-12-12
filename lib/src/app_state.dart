
import 'api.dart';
import 'search_options.dart';

class AppState{
  final SearchOptions searchOptions=SearchOptions(
    location: zlocations.first,
    order: zorder.first,
    sort: zsort.first,
    count: zMaxCount
  );
}