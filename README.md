## Mata Kuliah

Sebagai tugas praktikum: [3] Basis Data | Universitas Pelita Bangsa.

## Laporan Praktikum

- Bagian 1:

  > Kode berdasarkan ERD yang ditanyakan.

  <p align="left">
    <img src="/ss/soal.jpg" width="500">
  </p>

```
CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE Mahasiswa (
  nim VARCHAR(10) PRIMARY KEY,
  nama VARCHAR(50) NOT NULL,
  jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
  tgl_lahir DATE NOT NULL,
  jalan VARCHAR(100) DEFAULT NULL,
  kota VARCHAR(50) NOT NULL,
  kodepos VARCHAR(10) DEFAULT NULL,
  no_hp VARCHAR(20) DEFAULT NULL,
  kd_ds VARCHAR(10) NOT NULL,
  CONSTRAINT FK_DosenWali FOREIGN KEY (kd_ds) REFERENCES Dosen(kd_ds)
);

CREATE TABLE Dosen (
  kd_ds VARCHAR(10) PRIMARY KEY,
  nama VARCHAR(50) NOT NULL
);

CREATE TABLE MataKuliah (
  kd_mk VARCHAR(10) PRIMARY KEY,
  nama VARCHAR(50) NOT NULL,
  sks INT NOT NULL
);

CREATE TABLE JadwalMengajar (
  kd_ds VARCHAR(10) NOT NULL,
  kd_mk VARCHAR(10) NOT NULL,
  hari ENUM('Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu') NOT NULL,
  jam TIME NOT NULL,
  ruang VARCHAR(20) NOT NULL,
  PRIMARY KEY (kd_ds, kd_mk, hari, jam),
  CONSTRAINT FK_JadwalDosen FOREIGN KEY (kd_ds) REFERENCES Dosen(kd_ds),
  CONSTRAINT FK_JadwalMatakuliah FOREIGN KEY (kd_mk) REFERENCES MataKuliah(kd_mk)
);

CREATE TABLE KRSMahasiswa (
  nim VARCHAR(10) NOT NULL,
  kd_mk VARCHAR(10) NOT NULL,
  kd_ds VARCHAR(10) NOT NULL,
  semester VARCHAR(10) NOT NULL,
  nilai DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (nim, kd_mk),
  CONSTRAINT FK_KRSMahasiswa FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
  CONSTRAINT FK_KRSMataKuliah FOREIGN KEY (kd_mk) REFERENCES MataKuliah(kd_mk),
  CONSTRAINT FK_KRSDosen FOREIGN KEY (kd_ds) REFERENCES Dosen(kd_ds)
);
```

**Output :**
  <p align="left">
    <img src="/ss/1.jpg" width="500">
  </p>
  <p align="left">
    <img src="/ss/2.jpg" width="500">
  </p>
  
- Bagian 2:

  > Menambah Record Dosen dan Mahasiswa.
  
```
select * from Dosen;
INSERT INTO Dosen (kd_ds, nama) VALUES
('DS001', 'Nurul'),
('DS002', 'Fauzan'),
('DS003', 'Oktavia'),
('DS004', 'Fajar'),
('DS005', 'Bayu');

select * from Mahasiswa;
INSERT INTO Mahasiswa (nim, nama, jenis_kelamin, tgl_lahir, jalan, kota, kodepos, no_hp, kd_ds) VALUES
('11223344', 'Nurul', 'Perempuan', '2005-07-14', NULL, 'Cikarang', NULL, NULL, 'DS001'),
('11223345', 'Fauzan', 'Laki-laki', '2005-11-16', NULL, 'Cikarang', NULL, NULL, 'DS002'),
('11223347', 'Oktavia Rizkha', 'Perempuan', '2002-01-02', NULL, 'Bekasi', NULL, NULL, 'DS003'),
('11223348', 'Fajar', 'Laki-laki', '2005-02-05', NULL, 'Bekasi', NULL, NULL, 'DS004'),
('11223349', 'Bayu', 'Laki-laki', '2005-03-10', NULL, 'Cikarang', NULL, NULL, 'DS005');
```
  
- Bagian 3:

  > Menghapus Kode Dosen.
  
```
DELETE FROM Dosen WHERE kd_ds = 'DS002';
```

**Keterangan :** Terjadi ERROR dikarenakan `kd_ds` pada tabel Mahasiswa merupakan **FOREIGN KEY** dari tabel refensinya yaitu tabel Dosen. Dan pada tabel Dosen `kd_ds` merupakan **PRIMARY KEY**. Itu artinya, tabel Dosen sebagai tabel *parent/references* dan Mahasiswa sebagai tabel *child* maka dari itu saat menghapus satu record data pada tabel dosen terjadi error. 
  
- Bagian 4:

  > Merubah Foreign Key untuk Kode Dosen agar bisa dirubah.
  
```
ALTER TABLE Mahasiswa DROP FOREIGN KEY FK_DosenWali;
ALTER TABLE Mahasiswa ADD CONSTRAINT FK_DosenMahasiswa FOREIGN KEY (kd_ds) REFERENCES Dosen(kd_ds) ON UPDATE CASCADE ON DELETE RESTRICT;
```
  
- Bagian 5:

  > Menghapus baris Dosen berdasarkan Kode Dosen.
  
```
DELETE FROM Dosen WHERE kd_ds = 'DS001';
```

**Keterangan :** Terjadi ERROR dan `kd_ds` tidak dapat dihapus.
  
- Bagian 6:

  > Merubah Kondisi Kode Dosen agar bisa dirubah.
  
```
ALTER TABLE Mahasiswa DROP FOREIGN KEY FK_DosenMahasiswa;
ALTER TABLE Mahasiswa ADD CONSTRAINT FK_DosenWali FOREIGN KEY (kd_ds) REFERENCES Dosen(kd_ds) ON UPDATE CASCADE ON DELETE SET NULL;
```

**Keterangan :** `kd_ds` berhasil dihapus.

## Evaluasi dan Pertanyaan
Tulis semua perintah-perintah SQL percobaan di atas beserta outputnya!

- Syntax SQL: **SQL dan Output sudah disertakan diatas**.

- Apa bedanya penggunaan RESTRICT dan penggunaan CASCADE:

* **Restrict** = yaitu perubahan data dan penghapusan data tidak diijinkan pada tabel referensi (parent table) apabila pada tabel child sudah ada yang merujuk pada data tersebut.
* **Cascade** = yaitu perubahan atau penghapusan data pada tabel referensi (parent table) akan diikuti oleh tabel child.

Keduanya dapat ditambahkan pada action `ON UPDATE` dan `ON DELETE` selain itu, bisa juga digunakan action `SET NULL`.

- Berikan kesimpulan anda:

Dalam kesimpulannya, **RESTRICT** dan **CASCADE** digunakan untuk mengatur perilaku ketika ada perubahan atau penghapusan data pada tabel utama. Jika digunakan dengan benar, ini dapat membantu memastikan integritas referensial dan konsistensi data antara tabel-tabel yang saling berhubungan.

## Documentation

All associated resources. are licensed under the [MIT License](https://mit-license.org/).
