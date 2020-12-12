import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'api.dart';


class SearchFilters extends StatefulWidget {

  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  
  @override
  Widget build(BuildContext context) {
    final state=Provider.of<AppState>(context);
    final api=Provider.of<ZomatoAPi>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter your search"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categories",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Wrap(
                    spacing:10 ,
                    children:  
                    List<Widget>.generate(api.categories.length, (index) {
                      final category=api.categories[index];
                      final isSelected=state.searchOptions.categories.contains(category.id);
                      return FilterChip(
                        label:Text(category.name),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:isSelected?Colors.white: Theme.of(context).textTheme.bodyText1.color
                          ),
                          selected: isSelected,
                          selectedColor: Colors.redAccent,
                          checkmarkColor: Colors.white,
                          onSelected: (bool selected){
                            setState(() {
                              if(selected){
                                state.searchOptions.categories.add(category.id);
                              }else{
                                 state.searchOptions.categories.remove(category.id);
                              }
                            });
                          },
                      );
                    })
                  ,),
                  SizedBox(height:30),
                  Text("Location Type",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: state.searchOptions.location,
                    items: api.locations.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value:value,child: Text(value),);
                      }
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          state.searchOptions.location=value;
                        });
                   }),
                  SizedBox(height:30),
                  Text("Order by",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  for(int indx=0;indx<api.order.length;indx++)
                  RadioListTile(
                    title: Text(api.order[indx]),
                    value: api.order[indx], 
                    groupValue: state.searchOptions.order, 
                    onChanged: (selection){
                      setState(() {
                        state.searchOptions.order=selection;
                      });
                  }),
                  SizedBox(height:30),
                  Text("Sort by",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Wrap(
                    spacing: 10,
                    children: api.sort.map<ChoiceChip>((sort) {
                    return ChoiceChip(
                      label: Text(sort), 
                      selected:state.searchOptions.sort==sort ,
                      onSelected: (selected){
                        setState(() {
                          state.searchOptions.sort=sort;
                        });
                      });
                  }).toList()
                  ,),
                  SizedBox(height:30),
                  Text("# of results to show",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  Slider(
                    value: state.searchOptions.count??5,
                    label: state.searchOptions.count?.round().toString(),
                    min: 5,
                    max: api.count,
                    divisions: 3, 
                    onChanged: (value){
                    setState(() {
                      state.searchOptions.count=value;
                      
                    });
                  })
                ],
              ),
            )
          ],
        )),
    );
  }
}

class SearchOptions{
  String location;
  String order;
  String sort;
  double count;
  List<int> categories=[];
  SearchOptions({this.location,this.order,this.sort,this.count});

  Map<String,dynamic> toJson()=>{
    'location':location,
    'sort':sort,
    'order':order,
    'count':count,
    'category':categories.join(',')
  };
}

