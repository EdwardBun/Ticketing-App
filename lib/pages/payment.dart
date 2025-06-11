import 'package:flutter/material.dart';
import 'package:flutter_project/pages/paymentsuccess.dart';


class PaymentPage extends StatefulWidget {
  final String nama;
  final String tipe;
  final int harga;

  const PaymentPage({
    super.key,
    required this.nama,
    required this.tipe,
    required this.harga,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = 'Bank Transfer';
  String selectedBank = '';
  String selectedWallet = '';
    String cardNumber = ''; // <- tambahkan ini

  final List<String> paymentMethods = [
    'Bank Transfer',
    'E-Wallet',
    'Kartu Kredit',
  ];

  void showConfirmationDialog() {
    List<Widget> content = [];

    if (selectedMethod == 'Bank Transfer') {
      content = [
        const Text('Pilih Bank:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: ['BRI', 'Mandiri', 'BCA', 'BNI'].map((bank) {
            final isSelected = selectedBank == bank;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(bank),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.check, size: 16, color: Colors.green),
                  ],
                ],
              ),
              selected: isSelected,
              selectedColor: Colors.blue.shade100,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) {
                setState(() {
                  selectedBank = bank;
                });
              },
            );
          }).toList(),
        ),
        if (selectedBank.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Bank "${selectedBank}" telah dipilih.',
              style: const TextStyle(color: Colors.green),
            ),
          ),
      ];
    } else if (selectedMethod == 'E-Wallet') {
      content = [
        const Text('Pilih E-Wallet:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: ['Ovo', 'Gopay', 'Dana', 'ShopeePay'].map((wallet) {
            final isSelected = selectedWallet == wallet;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(wallet),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.check, size: 16, color: Colors.green),
                  ],
                ],
              ),
              selected: isSelected,
              selectedColor: Colors.green.shade100,
              backgroundColor: Colors.grey.shade200,
              onSelected: (_) {
                setState(() {
                  selectedWallet = wallet;
                });
              },
            );
          }).toList(),
        ),
        if (selectedWallet.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'E-Wallet "${selectedWallet}" telah dipilih.',
              style: const TextStyle(color: Colors.green),
            ),
          ),
      ];
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Konfirmasi Pembayaran - $selectedMethod'),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              List<Widget> content = [];

              if (selectedMethod == 'Bank Transfer') {
                content = [
                  const Text('Pilih Bank:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: ['BRI', 'Mandiri', 'BCA', 'BNI'].map((bank) {
                      final isSelected = selectedBank == bank;
                      return ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(bank),
                            if (isSelected) ...[
                              const SizedBox(width: 6),
                              const Icon(Icons.check, size: 16, color: Colors.green),
                            ],
                          ],
                        ),
                        selected: isSelected,
                        selectedColor: Colors.blue.shade100,
                        backgroundColor: Colors.grey.shade200,
                        onSelected: (_) {
                          setState(() {
                            selectedBank = bank;
                          });
                          setStateDialog(() {}); 
                        },
                      );
                    }).toList(),
                  ),
                  if (selectedBank.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Bank "$selectedBank" telah dipilih.',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                ];
              } else if (selectedMethod == 'E-Wallet') {
                content = [
                  const Text('Pilih E-Wallet:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: ['Ovo', 'Gopay', 'Dana', 'ShopeePay'].map((wallet) {
                      final isSelected = selectedWallet == wallet;
                      return ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(wallet),
                            if (isSelected) ...[
                              const SizedBox(width: 6),
                              const Icon(Icons.check, size: 16, color: Colors.green),
                            ],
                          ],
                        ),
                        selected: isSelected,
                        selectedColor: Colors.green.shade100,
                        backgroundColor: Colors.grey.shade200,
                        onSelected: (_) {
                          setState(() {
                            selectedWallet = wallet;
                          });
                          setStateDialog(() {}); 
                        },
                      );
                    }).toList(),
                  ),
                  if (selectedWallet.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'E-Wallet "$selectedWallet" telah dipilih.',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                ];
              } else if (selectedMethod == 'Kartu Kredit') {
  content = [
    const Text('Masukkan Nomor Kartu Kredit:', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 12),
    TextField(
      keyboardType: TextInputType.number,
      maxLength: 16,
      
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'xxxx-xxxx-xxxx-xxxx',
      ),
      onChanged: (value) {
        setState(() {
          cardNumber = value;
        });
        setStateDialog(() {}); // untuk update tampilan real-time
      },
    ),
    if (cardNumber.length == 16)
      const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Nomor kartu valid.',
          style: TextStyle(color: Colors.green),
        ),
      ),
    if (cardNumber.isNotEmpty && cardNumber.length != 16)
      const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Nomor kartu harus 16 digit.',
          style: TextStyle(color: Colors.red),
        ),
      ),
  ];
}


              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3366FF),
                foregroundColor: Colors.white, 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentSuccessPage(
                      namaTiket: widget.nama,
                      totalTagihan: widget.harga,
                    ),
                  ),
                );
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Detail Tiket", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama: ${widget.nama}", style: const TextStyle(fontSize: 16)),
                  Text("Tipe: ${widget.tipe}", style: const TextStyle(fontSize: 16)),
                  Text(
                    "Harga: Rp. ${widget.harga.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text("Metode Pembayaran", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Column(
              children: paymentMethods.map((method) {
                return RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value!;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: showConfirmationDialog,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF3366FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Bayar Sekarang", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
