import 'package:flutter/material.dart';
import 'second_page.dart';
import 'local_storage_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _fnamecontroller = TextEditingController();
  final TextEditingController _lnamecontroller = TextEditingController();
  String? _selectedItem1;
  String? _selectedItem2;
  String? _selectedItem3;
  final List<String> _dropdownItems1 = ['Jawa Barat', 'Banten', 'Jakarta'];
  final List<String> _dropdownItems2 = ['Cianjur', 'Pagedangan', 'Pegadungan'];
  final List<String> _dropdownItems3 = ['Cipanas', 'Cisauk', 'Kalideres'];

  @override
  void initState() {
    super.initState();
    _loadAllSavedData();
  }

  Future<void> _loadAllSavedData() async {
    final firstName =
        await LocalStorageService.getInput(LocalStorageService.firstNameKey);
    final lastName =
        await LocalStorageService.getInput(LocalStorageService.lastNameKey);
    final provinsi =
        await LocalStorageService.getInput(LocalStorageService.provinsiKey);
    final kelurahan =
        await LocalStorageService.getInput(LocalStorageService.kelurahanKey);
    final kecamatan =
        await LocalStorageService.getInput(LocalStorageService.kecamatanKey);

    setState(() {
      _fnamecontroller.text = firstName ?? '';
      _lnamecontroller.text = lastName ?? '';
      _selectedItem1 = _dropdownItems1.contains(provinsi) ? provinsi : null;
      _selectedItem2 = _dropdownItems2.contains(kelurahan) ? kelurahan : null;
      _selectedItem3 = _dropdownItems3.contains(kecamatan) ? kecamatan : null;
    });
  }

  void _saveInput() async {
    await LocalStorageService.saveInput(
        LocalStorageService.firstNameKey, _fnamecontroller.text);
    await LocalStorageService.saveInput(
        LocalStorageService.lastNameKey, _lnamecontroller.text);
    if (_selectedItem1 != null) {
      await LocalStorageService.saveInput(
          LocalStorageService.provinsiKey, _selectedItem1!);
    }
    if (_selectedItem2 != null) {
      await LocalStorageService.saveInput(
          LocalStorageService.kelurahanKey, _selectedItem2!);
    }
    if (_selectedItem3 != null) {
      await LocalStorageService.saveInput(
          LocalStorageService.kecamatanKey, _selectedItem3!);
    }

    setState(() {
      _fnamecontroller.text;
      _lnamecontroller.text;
      _selectedItem1 = null;
      _selectedItem2 = null;
      _selectedItem3 = null;
    });
  }

  void _handleNextButtonPress() async {
    _saveInput();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _fnamecontroller,
              decoration: InputDecoration(
                labelText: 'First_Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lnamecontroller,
              decoration: InputDecoration(
                labelText: 'Last_Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Text';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedItem1,
              hint: Text('Provinsi'),
              decoration: InputDecoration(
                labelText: 'Provinsi',
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem1 = newValue;
                });
              },
              items: _dropdownItems1.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Provinsi';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedItem2,
              hint: Text('Kelurahan'),
              decoration: InputDecoration(
                labelText: 'Kelurahan',
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem2 = newValue;
                });
              },
              items: _dropdownItems2.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Kelurahan';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedItem3,
              hint: Text('Kecamatan'),
              decoration: InputDecoration(
                labelText: 'Kecamatan',
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem3 = newValue;
                });
              },
              items: _dropdownItems3.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Kecamatan';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveInput,
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: _handleNextButtonPress,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
