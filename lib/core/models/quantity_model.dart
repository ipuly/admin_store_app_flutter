import 'package:flutter/cupertino.dart';

class Quantity with ChangeNotifier {
  int _totalBelaja = 0;
  int _stokBarang = 10;
  int _angka = 0;

  int get angka {
    return _angka;
  }

  int get stock {
    return _stokBarang;
  }

  int get totalBelanja {
    return _totalBelaja;
  }

  void set angkaTambah(int value) {
    _angka += value;
    notifyListeners();
  }

  void set angkaKurang(int value) {
    _angka -= value;
    notifyListeners();
  }

  void set tombolTambah(int value) {
    _stokBarang -= value;
    notifyListeners();
  }

  void set hargaPlus(int harga) {
    _totalBelaja += harga;
    notifyListeners();
  }

  void set kurang(int value) {
    _stokBarang += value;
    notifyListeners();
  }

  void set kurangHarga(int harga) {
    _totalBelaja -= harga;
    notifyListeners();
  }
}
