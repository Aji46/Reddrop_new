import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Doner_view.dart';
import 'package:reddrop/widget/wigets.dart';
import 'package:share/share.dart';

class Home_search extends StatefulWidget {
  const Home_search({Key? key}) : super(key: key);

  @override
  State<Home_search> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<Home_search> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final CollectionReference donorCollection =
      FirebaseFirestore.instance.collection('Donor');

  List<String> items = List.generate(50, (index) => 'Item $index');
  late DocumentSnapshot donorSnap;

  List<String> bloodGroups = [];
  List<String> states = [];
  List<String> districts = [];
  int _currentIndex = 0;

  String? selectedState;
  String? selectedDistrict;
  String? selectedBloodGroup;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final donorSnapshot = await donorCollection.get();

    Set<String> uniqueBloodGroups = {};
    Set<String> uniqueStates = {};
    Set<String> uniqueDistricts = {};

    donorSnapshot.docs.forEach((doc) {
      uniqueBloodGroups.add(doc['group'] as String? ?? '');
      uniqueStates.add(doc['state'] as String? ?? '');
      uniqueDistricts.add(doc['district'] as String? ?? '');
    });

    setState(() {
      bloodGroups = uniqueBloodGroups.toList();
      states = uniqueStates.toList();
      districts = uniqueDistricts.toList();
    });
  }

  void shareContact(String contactDetails) {
    Share.share(contactDetails, subject: 'Contact Information');
  }

  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar();
    fetchData();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: Column(
            children: [
              buildDropdown(
                'Choose State',
                states,
                selectedState,
                (newValue) {
                  setState(() {
                    selectedState = newValue;
                    selectedDistrict = getDefaultSelection(newValue, districts);
                    selectedBloodGroup = getDefaultSelection(newValue, bloodGroups);
                  });
                  getFilteredStream();
                },
              ),

              buildDropdown(
                'Choose District',
                districts,
                selectedDistrict,
                (newValue) {
                  setState(() {
                    selectedDistrict = newValue;
                    selectedBloodGroup = getDefaultSelection(selectedBloodGroup, bloodGroups);
                    selectedDistrict = getDefaultSelection(selectedDistrict, districts);
                    selectedState = getDefaultSelection(selectedState, states);
                  });
                  getFilteredStream();
                },
              ),

              buildDropdown(
                'Choose Blood Group',
                bloodGroups,
                selectedBloodGroup,
                (newValue) {
                  setState(() {
                    selectedBloodGroup = newValue;
                    selectedDistrict = getDefaultSelection(selectedDistrict, districts);
                    selectedState = getDefaultSelection(selectedState, states);
                  });
                  getFilteredStream();
                },
              ),

              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getFilteredStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        // No donors available based on the selected criteria
                        return const Center(
                          child: Text('No available donors.'),
                        );
                      }

                      return buildDonorList(snapshot.data!.docs);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

Widget buildDropdown(String hintText, List<String> items, String? value, Function(String?) onChanged) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: value,
                hint: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    hintText,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onChanged: onChanged,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            if (value != null)
              IconButton(
                onPressed: () {
                  // Clear all dropdowns
                  clearDropdowns();
                },
                icon: Icon(Icons.clear),
              ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

void clearDropdowns() {
  setState(() {
    selectedState = null;
    selectedDistrict = null;
    selectedBloodGroup = null;
  });
  getFilteredStream(); // Refresh the stream after clearing dropdowns
}


  Widget buildDonorList(List<QueryDocumentSnapshot> donors) {
      if (donors.isEmpty) {
    return const Center(
      child: Text('No available donors.'),
    );
  }
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
        color: const Color.fromARGB(255, 252, 252, 252),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 255, 255, 255),
            blurRadius: 20,
          ),
        ],
      ),
      child: AnimatedList(
        key: _listKey,
        initialItemCount: donors.length,
        itemBuilder: (context, index, animation) {
           if (index >= donors.length) {
          return const SizedBox.shrink(); // Return an empty widget
        }
          final DocumentSnapshot donorSnap = donors[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ViewDonor(
                          arguments: {
                            'name': donorSnap['name'],
                            'phone': donorSnap['phone'].toString(),
                            'group': donorSnap['group'],
                            'place': donorSnap['place'],
                            'district': donorSnap['district'],
                            'state': donorSnap['state'],
                            'id': donorSnap.id,
                          },
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 5),
                      CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 190, 24, 24),
                        radius: 30,
                        child: Text(
                          donorSnap['group'] as String? ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              donorSnap['name'] as String? ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              donorSnap['phone'].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              shareContact(
                                '${donorSnap['name'] as String? ?? ''} ${donorSnap['phone']}',
                              );
                            },
                            tooltip: 'Share',
                            icon: const Icon(Icons.share_outlined),
                            color: const Color.fromARGB(255, 6, 135, 233),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> getFilteredStream() {
    Query filteredQuery = donorCollection.orderBy('name', descending: true);

    if (selectedState != null) {
      filteredQuery = filteredQuery.where('state', isEqualTo: selectedState);
    }

    if (selectedDistrict != null) {
      filteredQuery = filteredQuery.where('district', isEqualTo: selectedDistrict);
    }

    if (selectedBloodGroup != null) {
      filteredQuery = filteredQuery.where('group', isEqualTo: selectedBloodGroup);
    }

    return filteredQuery.snapshots();
  }

  String? getDefaultSelection(String? selectedValue, List<String> options) {
    return selectedValue != null && options.contains(selectedValue) ? selectedValue : options.first;
  }
}


class BloodCard extends StatelessWidget {
  const BloodCard({Key? key, required this.bloodGroup, required this.onTap})
      : super(key: key);

  final String bloodGroup;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 90,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 30,
            child: Text(
              bloodGroup,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
