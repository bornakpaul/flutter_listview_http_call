import 'package:flutter/material.dart';
import 'package:flutter_listview/model/ModelData.dart';
import 'package:flutter_listview/controller/network_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelData> modelData = [];
  ScrollController _scrollController = new ScrollController();
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTenDatas();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page += 1;
        fetchTenDatas();
        print(_scrollController.position.pixels);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  fetchTenDatas() {
    for (int i = 0; i < 10; i++) {
      NetworkRequest.fetchPosts().then((value) {
        setState(() {
          modelData = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http request"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(10),
            itemCount: modelData.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'User-Id : ' + '${modelData[index].userId}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Card-Id : ' + '${modelData[index].id}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Title : '.toUpperCase() + '${modelData[index].title}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Description : '.toUpperCase() +
                            '${modelData[index].body}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
