import 'package:flutter/material.dart';
import 'package:my_dashatar_app/detail.dart';

class Jurnalpage extends StatefulWidget {
  const Jurnalpage({super.key});

  @override
  State<Jurnalpage> createState() => _JurnalpageState();
}

class _JurnalpageState extends State<Jurnalpage> {
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Kegiatan Santri',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  width: lebar,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('images/Background.png'),
                        fit: BoxFit.cover),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: generateHeader(
                    context,
                    headers: [
                      {
                        'judul': 'Hadir',
                        'jumlah': 10,
                        'route': '/route1',
                      },
                      {
                        'judul': 'Sakit',
                        'jumlah': 2,
                        'route': '/route2',
                      },
                      {
                        'judul': 'Alpa',
                        'jumlah': 2,
                        'route': '/route3',
                        'isHadir': false, // Set to false for red border
                      },
                      {
                        'judul': 'Jumlah Jurnal',
                        'jumlah': 20,
                        'route': '/route4',
                      },
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                width: lebar,
                height: tinggi,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('images/Background.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dividerThickness: 0,
                        columnSpacing: lebar * 0.05,
                        columns: const [
                          DataColumn(
                              label: Expanded(
                                  child: Text(
                            "Kegiatan",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ))),
                          DataColumn(
                              label: Expanded(
                                  child: Text(
                            "Tanggal",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ))),
                          DataColumn(
                              label: Expanded(
                                  child: Text(
                            "Status",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ))),
                          DataColumn(
                              label: Expanded(
                                  child: Text(
                            "Action",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ))),
                        ],
                        rows: jurnalData.map((jurnal) {
                          return DataRow(
                            cells: [
                              DataCell(ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade100,
                                  backgroundImage: jurnal.thumb != null &&
                                          jurnal.thumb!.isNotEmpty
                                      ? NetworkImage(jurnal.thumb!)
                                      : null,
                                  child: jurnal.thumb == null ||
                                          jurnal.thumb!.isEmpty
                                      ? const Icon(
                                          Icons.book,
                                          color: Colors.blue,
                                        )
                                      : null,
                                ),
                                title: SizedBox(
                                  width: 95,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    jurnal.title ?? 'N/A',
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ),
                              )),
                              DataCell(Text(
                                jurnal.tanggal ?? 'N/A',
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.white),
                              )),
                              DataCell(Text(
                                jurnal.status ?? 'N/A',
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.white),
                              )),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DetailJurnalPage(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_circle_right_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget generateHeader(BuildContext context,
    {required List<Map<String, dynamic>> headers}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        headers.length,
        (index) {
          final header = headers[index];
          bool isHadir = header['isHadir'] ?? true;
          String judul = header['judul'] ?? '';
          Color backgroundColor;
          Color borderColor;
          Color? textColor = Colors.white;

          if (judul == 'Sakit') {
            backgroundColor = Colors.orange;
            borderColor = Colors.orange;
          } else if (judul == 'Jumlah Jurnal') {
            backgroundColor = Colors.blue.shade300;
            borderColor = Colors.blue.shade700;
          } else if (judul == 'Alpa') {
            backgroundColor = Colors.red;
            borderColor = Colors.red;
          } else {
            backgroundColor = Colors.green.shade400;
            borderColor = Colors.grey.shade300;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                print(header['route']);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 3, 1, 1),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: borderColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      header['judul'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      header['jumlah'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class Jurnal {
  String? title;
  String? tanggal;
  String? status;
  String? gambar;
  String? thumb;
  String? deskripsi;

  Jurnal({
    this.title,
    this.tanggal,
    this.status,
    this.gambar,
    this.thumb,
    this.deskripsi,
  });

  factory Jurnal.fromJson(Map<String, dynamic> json) => Jurnal(
        title: json["title"],
        tanggal: json["tanggal"],
        status: json["status"],
        gambar: json["gambar"],
        thumb: json["thumb"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "tanggal": tanggal,
        "status": status,
        "gambar": gambar,
        "thumb": thumb,
        "deskripsi": deskripsi,
      };
}

List<Jurnal> jurnalData = [
  Jurnal(
    title: 'Bela Diri Karate',
    tanggal: '2024-08-13',
    status: 'Hadir',
    gambar: '',
    thumb: 'https://cdn-icons-png.freepik.com/512/5252/5252910.png',
    deskripsi: 'Kegiatan Bela Diri Karate Setiap Hari Ahad.',
  ),
  Jurnal(
    title: 'Shalat Dhuha',
    tanggal: '2024-08-12',
    status: 'Tidak Hadir',
    gambar: '',
    thumb: 'https://cdn-icons-png.flaticon.com/512/2320/2320012.png',
    deskripsi: 'Melaksanakan Shalat Dhuha Di Masjid Secara Mandiri.',
  ),
  Jurnal(
    title: 'Membaca Buku',
    tanggal: '2024-08-11',
    status: 'Hadir',
    gambar: '',
    thumb:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7HGEp9WoWBu1_6BZstqmNV21BC0Keic8blw&s',
    deskripsi: 'Kegiatan Membaca Buku di Perpustakaan',
  ),
  Jurnal(
    title: 'Membaca Al-Quran',
    tanggal: '2024-08-13',
    status: 'Hadir',
    gambar: '',
    thumb:
        'https://png.pngtree.com/png-clipart/20220125/original/pngtree-gambar-anak-mengaji-membaca-al-quran-png-image_7229719.png',
    deskripsi:
        'Kegiatan membaca Al-Quran bersama di masjid setelah shalat subuh.',
  ),
];
