import 'package:covid19tracker/Services/Utilities/state_services.dart';
import 'package:covid19tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  final AnimationController controller;
  WorldStates({super.key, required this.controller});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> {
  final ColorList = <Color>[
    Colors.redAccent,
    Colors.blue,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top:100,right: 20,left: 20),
          child: Column(
            children: [
              FutureBuilder(
                future: stateServices.fectWorkedStatesReords(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 30,
                        controller: widget.controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'total': double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(snapshot.data!.recovered!.toString()),
                            'death': double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: LegendOptions(legendPosition: LegendPosition.left),
                          animationDuration: Duration(milliseconds: 1000),
                          chartType: ChartType.ring,
                          colorList: ColorList,
                        ),
                        SizedBox(height: 20),
                       Container(
                         padding: EdgeInsets.only(bottom: 0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.black12
                         ),
                         child: Column(


                           children: [
                             InfoRow(title: 'total', value: snapshot.data!.cases.toString()),
                             Divider(height: 2, thickness: 1.5, color: Colors.grey,),

                             InfoRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                             Divider(height: 2, thickness: 1.5, color: Colors.grey,),

                             InfoRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                             Divider(height: 2, thickness: 1.5, color: Colors.grey,),

                             InfoRow(title: 'active', value: snapshot.data!.active.toString()),
                             Divider(height: 2, thickness: 1.5, color: Colors.grey,),

                             InfoRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                             Divider(height: 2, thickness: 1.5, color: Colors.grey,),

                             InfoRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                             Divider(height: 2, thickness: 1.5, color: Colors.grey,),

                             InfoRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                           ],
                         ),
                       ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountriesList()));
                          },
                          child: Container(

                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 15,bottom: 15),
      decoration: BoxDecoration(

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
