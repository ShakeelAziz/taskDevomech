import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/apiModel.dart';
import 'package:http/http.dart' as http;

class APIData extends StatefulWidget {
  const APIData({Key key}) : super(key: key);

  @override
  _APIDataState createState() => _APIDataState();
}

class _APIDataState extends State<APIData> {
  List<Item> data_list = [];
  var colors = [
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.blue,
    Colors.black,
    Colors.red,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.blue,
    Colors.black,
    Colors.red,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.blue,
    Colors.black,
    Colors.red,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.red,
    Colors.blue,
    Colors.black
  ];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data",
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<Item>>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: const CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Center(
                  child: const Text("Please Enable your Internet Connection!"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return const Center(
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: newList.length,
                    itemBuilder: (context, index) => Dismissible(
                        key: Key("delete"),
                        onDismissed: (direction) {

                            data_list.removeAt(index);
                            getNewList();
                        },
                        child: Card(
                            color: colors[index],
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Project:",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          data_list[index].project,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Article:",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          data_list[index].article,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Granularity: ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "${data_list[index].granularity}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Timestamp: ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "${data_list[index].timestamp}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Access: ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "${data_list[index].access}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Agent: ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "${data_list[index].agent}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Views: ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "${data_list[index].views}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))));
              }
            }
          },
        ),
      ),
    );
  }

  Future<List<Item>> getData() async {
    final response = await http.get(Uri.parse(
        'https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/en.wikipedia/all-access/all-agents/Tiger_King/daily/20210901/20210930'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)["items"];
      data_list = data.map((e) => Item.fromJson(e)).toList();
      getNewList();
      return data_list;
    }
  }
  var newList = [];
  getNewList(){
    newList.clear();
    newList.addAll(data_list);
  }
}
