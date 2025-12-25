-- =====================================================
-- File        : create_tables.sql
-- Project     : Aplikasi Pencatatan Inventaris Sekolah
-- Deskripsi   : Script pembuatan seluruh tabel database
-- DBMS        : Microsoft SQL Server
-- Author      : Darryl Azzuri
-- =====================================================

-- =====================================================
-- STATUS FILE : LOCKED
-- Catatan     :
-- - Struktur tabel sudah final
-- - Tidak boleh diubah tanpa diskusi tim
-- =====================================================
CREATE DATABASE InventarisSekolahDB;
GO

USE InventarisSekolahDB;
GO

-- Menyimpan data murid yang dapat melakukan peminjaman
CREATE TABLE Murid (
    MuridId INT IDENTITY(1,1) PRIMARY KEY,
    NamaMurid VARCHAR(100) NOT NULL,
    Kelas VARCHAR(10) NOT NULL,
    Jurusan VARCHAR(10) NOT NULL
);

CREATE TABLE KategoriInventaris (
    KategoriId INT IDENTITY(1,1) PRIMARY KEY,
    NamaKategori VARCHAR(50) NOT NULL
);

CREATE TABLE LokasiPenyimpanan (
    LokasiId INT IDENTITY(1,1) PRIMARY KEY,
    NamaLokasi VARCHAR(50) NOT NULL,
    Keterangan VARCHAR(100)
);

CREATE TABLE KondisiInventaris (
    KondisiId INT IDENTITY(1,1) PRIMARY KEY,
    NamaKondisi VARCHAR(25) NOT NULL
);

CREATE TABLE Inventaris (
    InventarisId INT IDENTITY(1,1) PRIMARY KEY,
    KodeInventaris VARCHAR(30) NOT NULL UNIQUE,
    NamaInventaris VARCHAR(100) NOT NULL,
    KategoriId INT NOT NULL,
    LokasiId INT NOT NULL,
    KondisiId INT NOT NULL,
    TanggalPengadaan DATE NOT NULL,
    JumlahStok INT NOT NULL,
    StatusInventaris VARCHAR(30) NOT NULL,

    CONSTRAINT FK_Inventaris_Kategori
        FOREIGN KEY (KategoriId) REFERENCES KategoriInventaris(KategoriId),

    CONSTRAINT FK_Inventaris_Lokasi
        FOREIGN KEY (LokasiId) REFERENCES LokasiPenyimpanan(LokasiId),

    CONSTRAINT FK_Inventaris_Kondisi
        FOREIGN KEY (KondisiId) REFERENCES KondisiInventaris(KondisiId)
);

CREATE TABLE Peminjaman (
    PeminjamanId INT IDENTITY(1,1) PRIMARY KEY,
    TanggalPinjam DATE NOT NULL,
    TanggalRencanaKembali DATE NOT NULL,
    TanggalKembali DATE NULL,
    MuridId INT NOT NULL,
    StatusPeminjaman VARCHAR(30) NOT NULL,

    CONSTRAINT FK_Peminjaman_Murid
        FOREIGN KEY (MuridId) REFERENCES Murid(MuridId)
);

CREATE TABLE DetailPeminjaman (
    DetailPeminjamanId INT IDENTITY(1,1) PRIMARY KEY,
    PeminjamanId INT NOT NULL,
    InventarisId INT NOT NULL,
    JumlahPinjam INT NOT NULL,

    CONSTRAINT FK_DetailPeminjaman_Peminjaman
        FOREIGN KEY (PeminjamanId) REFERENCES Peminjaman(PeminjamanId),

    CONSTRAINT FK_DetailPeminjaman_Inventaris
        FOREIGN KEY (InventarisId) REFERENCES Inventaris(InventarisId)
);


-- Data Murid
INSERT INTO Murid (NamaMurid, Kelas, Jurusan) VALUES
('Ilham Saugi', 'XII', 'RPL'),
('Muhamad Nur Salam', 'XII', 'TKJ'),
('Afsal Prima Maula', 'X', 'RPL'),
('Billy Wicaksono', 'XI', 'TKJ'),
('Muhamad Phatur Rahman', 'XI', 'OTKP'),
('Yanto Santoso', 'XII', 'RPL'),
('Riski Pratama', 'XII', 'TKJ'),
('Muhammad Raehan', 'X', 'RPL'),
('Akbar Putra Pamungkas', 'XI', 'TKJ'),
('Siti Maimunah', 'XI', 'OTKP'),
('Sabrina', 'XII', 'RPL'),
('Ali Fauzi', 'XII', 'TKJ'),
('Muhammad Thoriq', 'X', 'RPL'),
('Rifky Pratama', 'XI', 'TKJ'),
('Khoirun Rozan', 'XI', 'OTKP'),
('Reza Putra', 'XII', 'RPL'),
('Raffi Ahmad', 'XII', 'TKJ'),
('Bahllil Ilahi', 'X', 'RPL'),
('Rafli Rahman', 'XI', 'TKJ'),
('Rafii Khoirun', 'XI', 'OTKP'),
('Arneu Samsul', 'XII', 'RPL'),
('Vicka Aulia', 'XII', 'TKJ'),
('Nazala Qisti', 'X', 'RPL'),
('Areva', 'XI', 'TKJ'),
('Aditya Frahaz', 'XI', 'OTKP'),
('Daril', 'XII', 'RPL'),
('Denis', 'XII', 'TKJ'),
('Prima Maula', 'X', 'RPL'),
('Pratama Arhan', 'XI', 'TKJ'),
('Farel', 'XI', 'OTKP');

-- Data Kategori Inventaris
INSERT INTO KategoriInventaris (NamaKategori) VALUES
('Buku Fiksi'), 
('Buku Pelajaran'), 
('Alat Olahraga'),
('Alat Musik'), 
('Perangkat TI'), 
('Alat Kebersihan'), 
('Elektronik'), 
('Alat Praktik TKJ'),
('Alat Praktik RPL'), 
('Alat Praktik OTKP'),
('Furniture'), 
('Alat Tulis Kantor'),
('Media Pembelajaran'), 
('Alat Seni Lukis'),
('Alat Pertukangan'),
('Kamera & Video'),
('Kabel & Jaringan'),
('Komponen Robotik'), 
('Alat Laboratorium'),
('Perlengkapan UKS'),
('Kostum Tari'), 
('Peralatan Masak'), 
('Peralatan Pramuka'), 
('Peralatan Paskibra'),
('Alat Ukur'), 
('Aksesori Komputer'), 
('Storage Device'),
('Proyektor'),
('Sound System'), 
('Alat Taman');

-- Data Lokasi Penyimpanan
INSERT INTO LokasiPenyimpanan (NamaLokasi, Keterangan) VALUES
('Perpustakaan', 'Lantai 1 Gedung A'),
('Lab Komputer', 'Lantai 2 Gedung A'),
('Ruang Olahraga', 'Samping Lapangan'),
('Gedung Aula', 'Lantai 1 Tengah'),
('RPS TKJ', 'Lantai 1 Gedung B'),
('RPS OTKP', 'Lantai 2 Gedung B'),
('RPS RPL', 'Lantai 2 Gedung C'),
('Ruang Musik', 'Lantai 2 Gedung A'),
('Ruang Guru', 'Lantai 1 Gedung B'),
('Gudang Utama', 'Belakang Sekolah'),
('Ruang OSIS', 'Gedung Kesiswaan'),
('Lab Kimia', 'Lantai 3 Gedung C'),
('Lab Fisika', 'Lantai 3 Gedung C'),
('Ruang Kepala Sekolah', 'Lantai 1 Gedung A'),
('Ruang UKS', 'Samping Kantin'),
('Kantin', 'Area Belakang'),
('Pos Satpam', 'Gerbang Depan'),
('Ruang Server', 'Lantai 2 Gedung B'),
('Sanggar Seni', 'Lantai 3 Gedung A'),
('Bengkel Otomotif', 'Area Belakang Gedung B'),
('Ruang Rapat', 'Lantai 1 Gedung A'),
('Studio Green Screen', 'Lantai 2 Gedung C'),
('Taman Literasi', 'Area Depan Perpustakaan'),
('Gudang Olahraga', 'Dekat Lapangan Basket'),
('Koperasi', 'Lantai 1 Gedung B'),
('Masjid', 'Area Samping Sekolah'),
('Ruang Piket', 'Lobby Utama'),
('Pantry Guru', 'Lantai 1 Gedung B'),
('Gudang Alat Bersih', 'Bawah Tangga Gedung A'),
('Ruang Arsip', 'Lantai 2 Gedung B');

-- Data Kondisi Inventaris
INSERT INTO KondisiInventaris (NamaKondisi) VALUES 
('Sangat Baik'), 
('Baik '), 
('Rusak Ringan'), 
('Rusak Berat'), 
('Hilang/Lenyap'),
('Sedang Diservis'), 
('Menunggu Suku Cadang'), 
('Lecet Pemakaian'), 
('Baterai Drop'),
('Layar Bergaris'), 
('Tombol Tidak Responsif'), 
('Kabel Terkelupas'), 
('Perlu Kalibrasi Ulang'), 
('Berjamur (Lensa/Buku)'),
('Halaman Robek'), 
('Sampul Rusak'), 
('Tinta Habis'), 
('Overheat'), 
('Engsel Longgar'), 
('Korslet'),
('Pecah/Retak'), 
('Berkarat'), 
('Dimakan Rayap'), 
('Usang (Out of Date)'), 
('Tidak Terdeteksi'),
('Kotor/Perlu Pembersihan'), 
('Penyok'), 
('Suara Sember (Audio)'), 
('Sensor Tidak Akurat'), 
('Unit Kanibal');

-- Data Inventaris
INSERT INTO Inventaris (KodeInventaris, NamaInventaris, KategoriId, LokasiId, KondisiId, TanggalPengadaan, JumlahStok, StatusInventaris) VALUES
('BK01', 'Novel Perahu Kertas', 1, 1, 1, '2025-01-15', 5, 'Tersedia'),
('BK02', 'Ensiklopedia Sains', 2, 1, 2, '2024-12-01', 10, 'Tersedia'),
('EL01', 'Laptop ASUS ROG', 5, 7, 1, '2024-11-10', 15, 'Tersedia'),
('EL02', 'Router Cisco v2', 8, 5, 2, '2024-10-20', 5, 'Tersedia'),
('OR01', 'Bola Basket Spalding', 3, 3, 3, '2024-09-15', 8, 'Tersedia'),
('MS01', 'Gitar Akustik Yamaha', 4, 8, 1, '2024-08-12', 4, 'Tersedia'),
('EL03', 'Kamera Canon 80D', 16, 22, 1, '2024-07-05', 3, 'Tersedia'),
('EL04', 'Proyektor Epson', 28, 2, 2, '2024-06-22', 12, 'Tersedia'),
('EL05', 'Microphone Shure', 29, 8, 1, '2024-05-18', 6, 'Tersedia'),
('EL06', 'Switch TP-Link', 17, 18, 1, '2024-04-10', 10, 'Tersedia'),
('ME01', 'Kursi Kantor', 11, 14, 2, '2024-03-05', 20, 'Tersedia'),
('ME02', 'Meja Komputer', 11, 2, 1, '2024-02-14', 20, 'Tersedia'),
('AT01', 'Papan Tulis Putih', 13, 7, 2, '2024-01-30', 5, 'Tersedia'),
('EL07', 'Scanner Brother', 30, 9, 3, '2023-12-25', 2, 'Tersedia'),
('EL08', 'Printer HP Laserjet', 30, 9, 2, '2023-11-12', 4, 'Tersedia'),
('OR02', 'Matras Yoga', 3, 15, 1, '2023-10-10', 10, 'Tersedia'),
('OR03', 'Bola Voli Molten', 3, 3, 1, '2023-09-01', 12, 'Tersedia'),
('MS02', 'Keyboard Roland', 4, 8, 1, '2023-08-20', 2, 'Tersedia'),
('EL09', 'Monitor LG 24 Inch', 5, 7, 1, '2023-07-15', 25, 'Tersedia'),
('EL10', 'UPS APC 650VA', 5, 18, 2, '2023-06-10', 8, 'Tersedia'),
('TK01', 'Crimping Tool', 8, 5, 2, '2023-05-05', 15, 'Tersedia'),
('RP01', 'Arduino Nano', 18, 12, 1, '2023-04-20', 30, 'Tersedia'),
('RP02', 'Raspberry Pi 4', 18, 12, 1, '2023-03-15', 10, 'Tersedia'),
('OT01', 'Mesin Ketik Elektrik', 10, 6, 3, '2023-02-28', 5, 'Tersedia'),
('SN01', 'Kanvas Lukis A3', 14, 19, 1, '2023-01-10', 50, 'Tersedia'),
('LB01', 'Mikroskop Cahaya', 19, 12, 1, '2022-12-05', 15, 'Tersedia'),
('LB02', 'Tabung Reaksi', 19, 12, 2, '2022-11-20', 100, 'Tersedia'),
('UK01', 'Stetoskop', 20, 15, 1, '2022-10-15', 5, 'Tersedia'),
('UK02', 'Timbangan Badan', 20, 15, 2, '2022-09-30', 2, 'Tersedia'),
('AT02', 'Stapler Besar', 12, 9, 1, '2022-08-25', 10, 'Tersedia');

-- Data Peminjaman
INSERT INTO Peminjaman (TanggalPinjam, TanggalRencanaKembali, TanggalKembali, MuridId, StatusPeminjaman) VALUES
('2025-03-10', '2025-03-13', '2025-03-13', 1, 'Selesai'),
('2025-03-11', '2025-03-14', NULL, 2, 'Dipinjam'),
('2025-03-12', '2025-03-15', '2025-03-16', 3, 'Terlambat'),
('2025-03-13', '2025-03-16', NULL, 4, 'Dipinjam'),
('2025-03-14', '2025-03-17', '2025-03-17', 5, 'Selesai'),
('2025-03-15', '2025-03-18', NULL, 6, 'Dipinjam'),
('2025-03-16', '2025-03-19', '2025-03-19', 7, 'Selesai'),
('2025-03-17', '2025-03-20', NULL, 8, 'Dipinjam'),
('2025-03-18', '2025-03-21', '2025-03-21', 9, 'Selesai'),
('2025-03-19', '2025-03-22', NULL, 10, 'Dipinjam'),
('2025-03-20', '2025-03-23', '2025-03-23', 11, 'Selesai'),
('2025-03-21', '2025-03-24', NULL, 12, 'Dipinjam'),
('2025-03-22', '2025-03-25', '2025-03-25', 13, 'Selesai'),
('2025-03-23', '2025-03-26', NULL, 14, 'Dipinjam'),
('2025-03-24', '2025-03-27', '2025-03-27', 15, 'Selesai'),
('2025-03-25', '2025-03-28', NULL, 16, 'Dipinjam'),
('2025-03-26', '2025-03-29', '2025-03-29', 17, 'Selesai'),
('2025-03-27', '2025-03-30', NULL, 18, 'Dipinjam'),
('2025-03-28', '2025-03-31', '2025-03-31', 19, 'Selesai'),
('2025-03-29', '2025-04-01', NULL, 20, 'Dipinjam'),
('2025-03-30', '2025-04-02', '2025-04-02', 21, 'Selesai'),
('2025-03-31', '2025-04-03', NULL, 22, 'Dipinjam'),
('2025-04-01', '2025-04-04', '2025-04-04', 23, 'Selesai'),
('2025-04-02', '2025-04-05', NULL, 24, 'Dipinjam'),
('2025-04-03', '2025-04-06', '2025-04-06', 25, 'Selesai'),
('2025-04-04', '2025-04-07', NULL, 26, 'Dipinjam'),
('2025-04-05', '2025-04-08', '2025-04-08', 27, 'Selesai'),
('2025-04-06', '2025-04-09', NULL, 28, 'Dipinjam'),
('2025-04-07', '2025-04-10', '2025-04-10', 29, 'Selesai'),
('2025-04-08', '2025-04-11', NULL, 30, 'Dipinjam');

-- Data Detail Peminjaman
INSERT INTO DetailPeminjaman (PeminjamanId, InventarisId, JumlahPinjam) VALUES
(1, 1, 1), (2, 3, 1), (3, 5, 2), (4, 7, 1), (5, 9, 2),
(6, 11, 1), (7, 13, 1), (8, 15, 1), (9, 17, 1), (10, 19, 2),
(11, 21, 5), (12, 23, 1), (13, 25, 10), (14, 27, 2), (15, 29, 1),
(16, 2, 1), (17, 4, 1), (18, 6, 1), (19, 8, 1), (20, 10, 1),
(21, 12, 1), (22, 14, 1), (23, 16, 1), (24, 18, 1), (25, 20, 1),
(26, 22, 2), (27, 24, 1), (28, 26, 1), (29, 28, 1), (30, 30, 1);

SELECT * FROM Murid;
SELECT * FROM KategoriInventaris;
SELECT * FROM LokasiPenyimpanan;
SELECT * FROM KondisiInventaris;
SELECT * FROM Inventaris;
SELECT * FROM Peminjaman;
