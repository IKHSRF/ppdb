import 'package:flutter/material.dart';
import 'package:latihan_us/services/firestore.dart';

class ListPendaftaran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirestoreServices.streamSiswa(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('NIS')),
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Jenis Kelamin')),
                  DataColumn(label: Text('Tempat Lahir')),
                  DataColumn(label: Text('Alamat')),
                  DataColumn(label: Text('Asal Sekolah')),
                  DataColumn(label: Text('Kelas')),
                  DataColumn(label: Text('Jurusan')),
                  DataColumn(label: Text('Action')),
                ],
                rows: snapshot.data.docs.map<DataRow>((document) {
                  return DataRow(cells: <DataCell>[
                    DataCell(Text(document['nis'])),
                    DataCell(Text(document['nama'])),
                    DataCell(Text(document['jenis_kelamin'])),
                    DataCell(Text(document['tanggal_lahir'])),
                    DataCell(Text(document['alamat'])),
                    DataCell(Text(document['asal_sekolah'])),
                    DataCell(Text(document['kelas'])),
                    DataCell(Text(document['jurusan'])),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit',
                              arguments: document.id,
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            FirestoreServices.removeSiswa(document.id);
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
