import '/models/mahasiswa_model.dart';
import '/services/mahasiswa_service.dart';
import 'package:flutter/material.dart';

class FormMahasiswa extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  const FormMahasiswa({super.key, this.mahasiswa});

  @override
  // ignore: library_private_types_in_public_api
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  TextEditingController? nama;
  TextEditingController? nim;
  TextEditingController? email;
  TextEditingController? prodi;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.nama);

    nim = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.nim);

    email = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.email);

    prodi = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.prodi);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Form'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nim,
              decoration: InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: prodi,
              decoration: InputDecoration(
                  labelText: 'Prodi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                child: (widget.mahasiswa == null)
                    ? const Text(
                        'Add',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      )
                    : const Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                onPressed: () {
                  submitForm();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> submitForm() async {
    Mahasiswa mahasiswaData = Mahasiswa(
      id: widget.mahasiswa?.id,
      nim: nim!.text,
      nama: nama!.text,
      prodi: prodi!.text,
      email: email!.text,
    );

    String message;

    if (widget.mahasiswa != null) {
      message = await MahasiswaService.updateMahasiswa(mahasiswaData); //update
    } else {
      message = await MahasiswaService.createMahasiswa(mahasiswaData); //insert
    }

    // ignore: use_build_context_synchronously

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    Navigator.pop(context, 'save');
  }
}
