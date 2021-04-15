import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latihan_us/services/firestore.dart';

class EditFormulir extends StatefulWidget {
  @override
  _EditFormulirState createState() => _EditFormulirState();
}

class _EditFormulirState extends State<EditFormulir> {
  final TextEditingController nis = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController tempatLahir = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  final TextEditingController asalSekolah = TextEditingController();
  final TextEditingController kelas = TextEditingController();
  final TextEditingController jurusan = TextEditingController();
  var jenisKelamin;
  var tanggalLahir = 'kosong';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('siswa')
                    .doc(ModalRoute.of(context).settings.arguments)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      TextField(
                        controller: nis,
                        decoration:
                            InputDecoration(hintText: snapshot.data['nis']),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: nama,
                        decoration:
                            InputDecoration(hintText: snapshot.data['nama']),
                      ),
                      Container(
                        width: double.infinity,
                        child: DropdownButton(
                          hint: Text(snapshot.data['jenis_kelamin']),
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
                        decoration: InputDecoration(
                            hintText: snapshot.data['tempat_lahir']),
                      ),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: (tanggalLahir == 'kosong')
                                ? snapshot.data['tanggal_lahir']
                                : tanggalLahir),
                        onTap: () async {
                          var result =
                              await FirestoreServices.selectDate(context);
                          if (result != null) {
                            setState(() {
                              tanggalLahir = result.toString();
                            });
                          }
                        },
                      ),
                      TextField(
                        controller: alamat,
                        decoration:
                            InputDecoration(hintText: snapshot.data['alamat']),
                      ),
                      TextField(
                        controller: asalSekolah,
                        decoration: InputDecoration(
                            hintText: snapshot.data['asal_sekolah']),
                      ),
                      TextField(
                        controller: kelas,
                        decoration:
                            InputDecoration(hintText: snapshot.data['kelas']),
                      ),
                      TextField(
                        controller: jurusan,
                        decoration:
                            InputDecoration(hintText: snapshot.data['jurusan']),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                          onPressed: () async {
                            var result = await FirestoreServices.editSiswa(
                              snapshot.data.id,
                              (nis.text == '')
                                  ? snapshot.data['nis']
                                  : nis.text,
                              (nama.text == '')
                                  ? snapshot.data['nama']
                                  : nama.text,
                              (jenisKelamin == '' || jenisKelamin == null)
                                  ? snapshot.data['jenis_kelamin']
                                  : jenisKelamin,
                              (tempatLahir.text == '')
                                  ? snapshot.data['tempat_lahir']
                                  : tempatLahir.text,
                              (tanggalLahir == '')
                                  ? snapshot.data['tanggal_lahir']
                                  : tanggalLahir,
                              (alamat.text == '')
                                  ? snapshot.data['alamat']
                                  : alamat.text,
                              (asalSekolah.text == '')
                                  ? snapshot.data['asal_sekolah']
                                  : asalSekolah.text,
                              (kelas.text == '')
                                  ? snapshot.data['kelas']
                                  : kelas.text,
                              (jurusan.text == '')
                                  ? snapshot.data['jurusan']
                                  : jurusan.text,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(result)));
                            Navigator.popAndPushNamed(context, '/pendaftar');
                          },
                          child: Text("Simpan"))
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
