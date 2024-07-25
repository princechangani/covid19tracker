import 'package:covid19tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;

  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .067),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black12,
                          height: 60,
                        ),
                        Divider(
                          height: 2,
                          thickness: 1.5,
                          color: Colors.grey,
                        ),
                        InfoRow(
                          title: ' Total Cases',
                          value: widget.totalCases.toString(),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1.5,
                          color: Colors.grey,
                        ),
                        InfoRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString(),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1.5,
                          color: Colors.grey,
                        ),
                        InfoRow(
                          title: 'Recovered',
                          value: widget.todayRecovered.toString(),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1.5,
                          color: Colors.grey,
                        ),
                        InfoRow(
                          title: 'Active',
                          value: widget.active.toString(),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1.5,
                          color: Colors.grey,
                        ),
                        InfoRow(
                          title: 'Critical',
                          value: widget.critical.toString(),
                        ),
                        Divider(height: 2,
                          thickness: 1.5,
                          color: Colors.grey,
                        ),
                        InfoRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString(),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1.5,
                          color: Colors.grey,
                        ),
                        InfoRow(
                          title: 'Test',
                          value: widget.test.toString(),
                        ),

                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
