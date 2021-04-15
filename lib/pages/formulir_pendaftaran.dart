import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan_us/services/firestore.dart';

class Formulir extends StatefulWidget {
  @override
  _FormulirState createState() => _FormulirState();
}

class _FormulirState extends State<Formulir> {
  final TextEditingController nis = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController tempatLahir = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  final TextEditingController asalSekolah = TextEditingController();
  final TextEditingController kelas = TextEditingController();
  final TextEditingController jurusan = TextEditingController();
  var jenisKelamin;
  DateTime tanggalLahir;
  String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nis,
                    decoration: InputDecoration(hintText: 'NIS'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: nama,
                    decoration: InputDecoration(hintText: 'Nama'),
                  ),
                  Container(
                    width: double.infinity,
                    child: DropdownButton(
                      hint: Text('Jenis Kelamin'),
                      value: jenisKelamin,
                      items: [
                        DropdownMenuItem(
                          child: Text("Laki - laki"),
                          value: 'laki-laki',
                        ),
                        DropdownMenuItem(
                          child: Text("Perempuan"),
                          value: 'perempuan',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value;
                        });
                      },
                    ),
                  ),
                  TextField(
                    controller: tempatLahir,
                    decoration: InputDecoration(hintText: 'Tempat Lahir'),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: (tanggalLahir == null)
                            ? 'Tanggal Lahir'
                            : formattedDate),
                    onTap: () async {
                      var result = await FirestoreServices.selectDate(context);
                      if (result != null) {
                        setState(() {
                          tanggalLahir = result;
                          formattedDate =
                              DateFormat('dd-MM-yyyy').format(tanggalLahir);
                        });
                      }
                    },
                  ),
                  TextField(
                    controller: alamat,
                    decoration: InputDecoration(hintText: 'Alamat'),
                  ),
                  TextField(
                    controller: asalSekolah,
                    decoration: InputDecoration(hintText: 'Asal Sekolah'),
                  ),
                  TextField(
                    controller: kelas,
                    decoration: InputDecoration(hintText: 'Kelas'),
                  ),
                  TextField(
                    controller: jurusan,
                    decoration: InputDecoration(hintText: 'Jurusan'),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                      onPressed: () async {
                        var result = await FirestoreServices.addSiswa(
                          nis.text,
                          nama.text,
                          jenisKelamin,
                          tempatLahir.text,
                          formattedDate,
                          alamat.text,
                          asalSekolah.text,
                          kelas.text,
                          jurusan.text,
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                      },
                      child: Text("Simpan"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
