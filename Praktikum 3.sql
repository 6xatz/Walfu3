CREATE DATABASE Praktikum3;
USE Praktikum3;

CREATE TABLE Mahasiswa (
  nim VARCHAR(10) PRIMARY KEY,
  nama VARCHAR(50) NOT NULL,
  jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
  tgl_lahir DATE NOT NULL,
  jalan VARCHAR(100) DEFAULT NULL,
  kota VARCHAR(50) DEFAULT NULL,
  kodepos VARCHAR(10)DEFAULT NULL,
  no_hp VARCHAR(20) DEFAULT NULL,
  kd_ds VARCHAR(10) DEFAULT NULL,
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

INSERT INTO Dosen (kd_ds, nama) VALUES
('DS001', 'Johnny'),
('DS002', 'Jake'),
('DS003', 'Hanny'),
('DS004', 'Karina'),
('DS005', 'Eric');
select * from Dosen;

INSERT INTO Mahasiswa (nim, nama, jenis_kelamin, tgl_lahir, jalan, kota, kodepos, no_hp, kd_ds) VALUES
('11223344', 'Ari Santoso', 'Laki-laki', '1979-08-31', NULL, 'Bekasi', NULL, NULL, 'DS001'),
('11223345', 'Ario Talib', 'Laki-laki', '1999-11-16', NULL, 'Cikarang', NULL, NULL, 'DS002'),
('11223347', 'Lisa Ayu', 'Perempuan', '1996-01-02', NULL, 'Bekasi', NULL, NULL, 'DS003'),
('11223348', 'Tiara Wahidah', 'Perempuan', '1908-02-05', NULL, 'Bekasi', NULL, NULL, 'DS004'),
('11223349', 'Anton Sinaga', 'Laki-laki', '1988-03-10', NULL, 'Cikarang', NULL, NULL, 'DS005');
select * from Mahasiswa;

DELETE FROM Dosen WHERE kd_ds = 'DS002';

ALTER TABLE Mahasiswa DROP FOREIGN KEY FK_DosenWali;
ALTER TABLE Mahasiswa ADD CONSTRAINT FK_DosenMahasiswa FOREIGN KEY (kd_ds) REFERENCES Dosen(kd_ds) ON UPDATE CASCADE ON DELETE RESTRICT;

UPDATE Dosen SET kd_ds = 'DS007' WHERE kd_ds = 'DS005';

DELETE FROM Dosen WHERE kd_ds = 'DS001';

ALTER TABLE Mahasiswa DROP FOREIGN KEY FK_DosenMahasiswa;
ALTER TABLE Mahasiswa ADD CONSTRAINT FK_DosenWali FOREIGN KEY (kd_ds) REFERENCES Dosen(kd_ds) ON UPDATE CASCADE ON DELETE SET NULL;

DELETE FROM Dosen WHERE kd_ds = 'DS004';