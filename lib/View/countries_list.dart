import 'package:covid19tracker/Services/Utilities/state_services.dart';
import 'package:covid19tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  late Future<List<dynamic>> futureCountriesData;

  @override
  void initState() {
    super.initState();
    futureCountriesData = StateServices().countriesListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: futureCountriesData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 10, // Show 10 shimmer placeholders
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: ListTile(
                            leading: Container(
                              height: 60,
                              width: 60,
                              color: Colors.white,
                            ),
                            title: Container(
                              height: 10,
                              width: 90,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 90,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    var countriesData = snapshot.data!;
                    return ListView.builder(
                      itemCount: countriesData.length,
                      itemBuilder: (context, index) {
                        var country = countriesData[index];
                        var countryFlag = country['countryInfo'];
                        String name = country['country'];
                        if (searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  image: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalRecovered: snapshot.data![index]
                                      ['recovered'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]
                                      ['todayRecovered'],
                                  critical: snapshot.data![index]['critical'],
                                ),
                              ));
                            },
                            child: ListTile(
                              leading: Container(
                                  height: 60,
                                  width: 60,
                                  child: Image.network(countryFlag['flag'])),
                              title: Text(country['country']),
                              subtitle: Text('Cases: ${country['cases']}'),
                            ),
                          );
                        } else if (name.toLowerCase().startsWith(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  image: snapshot.data![index]['countryInfo']
                                  ['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalRecovered: snapshot.data![index]
                                  ['recovered'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]
                                  ['todayRecovered'],
                                  critical: snapshot.data![index]['critical'],
                                ),
                              ));
                            },
                            child: ListTile(
                              leading: Container(
                                  height: 60,
                                  width: 60,
                                  child: Image.network(countryFlag['flag'])),
                              title: Text(country['country']),
                              subtitle: Text('Cases: ${country['cases']}'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
