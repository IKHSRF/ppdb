import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _siswa = _firestore.collection('siswa');

  static Future<String> addSiswa(
    String nis,
    String nama,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String alamat,
    String asalSekolah,
    String kelas,
    String jurusan,
  ) async {
    try {
      await _siswa.add({
        'nis': nis,
        'nama': nama,
        'jenis_kelamin': jenisKelamin,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'alamat': alamat,
        'asal_sekolah': asalSekolah,
        'kelas': kelas,
        'jurusan': jurusan,
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Stream streamSiswa() => _siswa.snapshots();

  static Future<void> removeSiswa(String id) async {
    _siswa.doc(id).delete();
    return 'berhasil';
  }

  static Future<String> editSiswa(
    String id,
    String nis,
    String nama,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String alamat,
    String asalSekolah,
    String kelas,
    String jurusan,
  ) async {
    try {
      _siswa.doc(id).set({
        'nama': nama,
        'nis': nis,
        'jenis_kelamin': jenisKelamin,
        'tempat_lahir': tempatLahir,
        'alamat': alamat,
        'asal_sekolah': asalSekolah,
        'kelas': kelas,
        'jurusan': jurusan,
      }, SetOptions(merge: true));
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<DateTime> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picker = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2023),
    );
    if (picker != null) {
      selectedDate = picker;
    }
    return selectedDate;
  }
}
