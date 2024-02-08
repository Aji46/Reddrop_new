import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/database/database.dart';
import 'package:reddrop/widget/widgets2.dart';
import 'package:reddrop/widget/wigets.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({Key? key}) : super(key: key);

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  final FirebaseService firebaseService = FirebaseService();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final CollectionReference donorCollection = FirebaseFirestore.instance.collection('Donor');

  List<String> items = List.generate(50, (index) => 'Item $index');
  late DocumentSnapshot donorSnap;
  List<String> bloodGroups = [], states = [], districts = [];
  String? selectedState, selectedDistrict, selectedBloodGroup;

  @override
  void initState() {
    super.initState();
    fetchData(donorCollection, setData);
  }

  void dispose() {

  super.dispose();
}

void setData(List<String> uniqueBloodGroups, List<String> uniqueStates, List<String> uniqueDistricts) {
  if (mounted) {
    setState(() {
      bloodGroups = uniqueBloodGroups;
      states = uniqueStates;
      districts = uniqueDistricts;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    fetchData(donorCollection, setData);
    return Scaffold(
      appBar: CustomAppBar().buildAppBar(context),
      body: Column(
        children: [
          for (var dropdown in [
            {'hintText': 'Choose State', 'items': states, 'value': selectedState},
            {'hintText': 'Choose District', 'items': districts, 'value': selectedDistrict},
            {'hintText': 'Choose Blood Group', 'items': bloodGroups, 'value': selectedBloodGroup},
          ])
            buildDropdown(
              dropdown['hintText'] as String,
              dropdown['items'] as List<String>,
              dropdown['value'] as String?,
              (newValue) {
                setState(() {
                  if (states.contains(newValue)) selectedState = newValue;
                  if (districts.contains(newValue)) selectedDistrict = newValue;
                  if (bloodGroups.contains(newValue)) selectedBloodGroup = newValue;
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
                  return snapshot.data!.docs.isEmpty
                      ? const Center(child: Text('No available donors.'))
                      : buildDonorList(snapshot.data!.docs);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
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
                  onPressed: () => clearDropdowns(),
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
      selectedState = selectedDistrict = selectedBloodGroup = null;
    });
    getFilteredStream();
  }

  Widget buildDonorList(List<QueryDocumentSnapshot> donors) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
        color: const Color.fromARGB(255, 252, 252, 252),
        boxShadow: const [BoxShadow(color: Color.fromARGB(255, 255, 255, 255), blurRadius: 20)],
      ),
      child: DonorListWidget(
        listKey: _listKey,
        donors: donors,
      ),
    );
  }

  Stream<QuerySnapshot> getFilteredStream() {
    return firebaseService.getFilteredStream(selectedState, selectedDistrict, selectedBloodGroup);
  }
}
