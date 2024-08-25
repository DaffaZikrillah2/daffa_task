import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_dashatar_app/detail.dart';

class Jurnalpage extends StatefulWidget {
  const Jurnalpage({super.key});

  @override
  State<Jurnalpage> createState() => _JurnalpageState();
}

class _JurnalpageState extends State<Jurnalpage> {
  int currentPage = 0;
  final int itemsPerPage = 6;

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;

    // Get the current page's data
    final paginatedData =
        jurnalData.skip(currentPage * itemsPerPage).take(itemsPerPage).toList();
    final totalPages = (jurnalData.length / itemsPerPage).ceil();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Kegiatan Santri',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              _buildHeader(lebar),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Laporan Kegiatan',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: _buildJurnalList(paginatedData),
              ),
              _buildPaginationControls(totalPages),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double lebar) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        width: lebar,
        decoration: BoxDecoration(
          // image: const DecorationImage(
          //     image: AssetImage('images/Background.png'), fit: BoxFit.cover),
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
            {'judul': 'Hadir', 'jumlah': 10, 'route': '/route1'},
            {'judul': 'Sakit', 'jumlah': 2, 'route': '/route2'},
            {
              'judul': 'Alpa',
              'jumlah': 2,
              'route': '/route3',
              'isHadir': false
            },
            {'judul': 'Jumlah Jurnal', 'jumlah': 20, 'route': '/route4'},
          ],
        ),
      ),
    );
  }

  Widget _buildJurnalList(List<Jurnal> paginatedData) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Wrap(
          children: List.generate(
            paginatedData.length,
            (index) {
              final jurnal = paginatedData[index];

              Color statusColor;

              switch (jurnal.status) {
                case 'Hadir':
                  statusColor = Colors.green.shade400;
                  break;
                case 'Sakit':
                  statusColor = Colors.orange.shade400;
                  break;
                case 'Alpa':
                  statusColor = Colors.red.shade400;
                  break;
                default:
                  statusColor = Colors.grey.shade400;
              }

              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailJurnalPage(jurnal: jurnal),
                    )),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 90.0,
                              height: 65.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: jurnal.gambar != null &&
                                          jurnal.gambar!.isNotEmpty
                                      ? AssetImage(jurnal.gambar!)
                                      : const AssetImage(
                                          'images/default_image.png'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(
                                        0.2), // Menggelapkan gambar
                                    BlendMode
                                        .darken, // Mode blending untuk menggelapkan
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // top: 5.0,
                              // left: 4.0,
                              child: ClipPath(
                                clipper: WaveClipperOne(),
                                child: Container(
                                  height: 42,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.7),
                                  ),
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 5, right: 14, top: 2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.event_busy,
                                        color: Colors.white,
                                        size: 11.0,
                                      ),
                                      Text(
                                        jurnal.status ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                jurnal.title ?? 'No Title',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  jurnal.deskripsi ?? 'No Title',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 61,
                              height: 27,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                jurnal.tanggal ?? 'No Date',
                                style: TextStyle(
                                  fontSize: 9.0,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            // Container(
                            //   width: 40,
                            //   height: 40,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //       width: 0.2,
                            //     ),
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   child: IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(
                            //       Icons.edit,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls(int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 0
              ? () {
                  setState(() {
                    currentPage--;
                  });
                }
              : null,
          icon: const Icon(Icons.arrow_back, color: Colors.green),
        ),
        Text('${currentPage + 1} / $totalPages'),
        IconButton(
          onPressed: currentPage < totalPages - 1
              ? () {
                  setState(() {
                    currentPage++;
                  });
                }
              : null,
          icon: const Icon(Icons.arrow_forward, color: Colors.green),
        ),
      ],
    );
  }
}

Widget generateHeader(BuildContext context,
    {required List<Map<String, dynamic>> headers}) {
  return Wrap(
    alignment: WrapAlignment.center,
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
        } else if (judul == 'Alpa') {
          backgroundColor = Colors.red;
          borderColor = Colors.red;
        } else {
          backgroundColor = Colors.green.shade400;
          borderColor = Colors.green.shade400;
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print(header['route']);
            },
            child: Container(
              width: 130,
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundColor,
              ),
              child: Column(
                children: [
                  Text(
                    header['judul'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: textColor,
                    ),
                  ),
                  Text(
                    header['jumlah'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
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
  );
}

class Jurnal {
  String? title;
  String? tanggal;
  String? status;
  String? gambar;
  String? deskripsi;

  Jurnal({
    this.title,
    this.tanggal,
    this.status,
    this.gambar,
    this.deskripsi,
  });

  factory Jurnal.fromJson(Map<String, dynamic> json) => Jurnal(
        title: json["title"],
        tanggal: json["tanggal"],
        status: json["status"],
        gambar: json["gambar"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "tanggal": tanggal,
        "status": status,
        "gambar": gambar,
        "deskripsi": deskripsi,
      };
}

List<Jurnal> jurnalData = [
  Jurnal(
    title: 'Membaca Al-Quran',
    tanggal: '10/08/2024',
    status: 'Hadir',
    gambar: 'images/download.jpeg',
    deskripsi: 'Kegiatan membaca Al-Quran bersama.',
  ),
  Jurnal(
    title: 'Shalat Dhuha',
    tanggal: '10/08/2024',
    status: 'Hadir',
    gambar: 'images/download.jpeg',
    deskripsi: 'Melaksanakan shalat dhuha.',
  ),
  Jurnal(
    title: 'Membaca Al-Quran',
    tanggal: '10/08/2024',
    status: 'Sakit',
    gambar: 'images/download.jpeg',
    deskripsi: 'Kegiatan membaca Al-Quran bersama.',
  ),
  Jurnal(
    title: 'Shalat Dhuha',
    tanggal: '10/08/2024',
    status: 'Hadir',
    gambar: 'images/download.jpeg',
    deskripsi: 'Melaksanakan shalat dhuha.',
  ),
  Jurnal(
    title: 'Membaca Al-Quran',
    tanggal: '10/08/2024',
    status: 'Sakit',
    gambar: 'images/download.jpeg',
    deskripsi: 'Kegiatan membaca Al-Quran bersama.',
  ),
  Jurnal(
    title: 'Shalat Dhuha',
    tanggal: '10/08/2024',
    status: 'Alpa',
    gambar: 'images/download.jpeg',
    deskripsi: 'Melaksanakan shalat dhuha.',
  ),
  Jurnal(
    title: 'Membaca Al-Quran',
    tanggal: '10/08/2024',
    status: 'Hadir',
    gambar: 'images/download.jpeg',
    deskripsi: 'Kegiatan membaca Al-Quran bersama.',
  ),
  Jurnal(
    title: 'Shalat Dhuha',
    tanggal: '10/08/2024',
    status: 'Alpa',
    gambar: 'images/download.jpeg',
    deskripsi: 'Melaksanakan shalat dhuha.',
  ),
];
