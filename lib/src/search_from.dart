import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  SearchForm({this.onsearch});
  final void Function(String search) onsearch;
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  var _autoValidate = false;
  var _search;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formkey,
        autovalidate: _autoValidate,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefix: Icon(Icons.search),
                  hintText: "Enter search",
                  border: OutlineInputBorder(),
                  filled: true),
              onChanged: (value) {
                _search = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a term";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                  fillColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    final isValid = _formkey.currentState.validate();
                    if (isValid) {
                      //TODO Perform search
                      widget.onsearch(_search);
                      FocusManager.instance.primaryFocus.unfocus();
                    } else {
                      //Todo Set autovalidate==true
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Search",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

