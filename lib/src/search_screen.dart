import 'package:flutter/material.dart';
import 'package:flutter_zomato_api/src/api.dart';
import 'package:flutter_zomato_api/src/app_state.dart';
import 'package:provider/provider.dart';
import 'search_from.dart';
import 'restaurant_item.dart';


class SearchPage extends StatefulWidget {
  final String title;
 

  SearchPage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SearchPage> {
  String query;
 
  @override
  Widget build(BuildContext context) {
    final state=Provider.of<AppState>(context);
    final api=Provider.of<ZomatoAPi>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          InkWell(
            onTap: () {
             // Navigator.of(context).push(
             //   MaterialPageRoute(builder: (context) => SearchFilters()),
             // );
             Navigator.pushNamed(context, 'filters');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.tune),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchForm(onsearch: (q) {
              setState(() {
                query = q;
              });
            }),
            query == null
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black12,
                          size: 110,
                        ),
                        Text(
                          "No results to display",
                          style: TextStyle(
                              color: Colors.black12,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : FutureBuilder(
                    future: api.searchRestaurants(query,state.searchOptions),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView(
                            children: snapshot.data
                                .map<Widget>(
                                    (json) => RestaurantItem(Restaurant(json)))
                                .toList(),
                          ),
                        );
                      }
                      return Text(
                          "Error retrieving results : ${snapshot.error}");
                    },
                  )
          ],
        ),
      ),
    );
  }
}
