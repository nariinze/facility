import 'package:flutter/material.dart';

import '../models/facility.dart';

// StatefulWidget menyimpan status reservasi yang mengubah tampilan halaman.
class FacilityDetailPage extends StatefulWidget {
  final FacilityModel facility;

  const FacilityDetailPage({super.key, required this.facility});

  @override
  State<FacilityDetailPage> createState() => _FacilityDetailPageState();
}

class _FacilityDetailPageState extends State<FacilityDetailPage> {
  bool _isReserved = false;

  String get _formattedPrice {
    if (widget.facility.pricePerHour == 0) return 'Gratis';
    return 'Rp ${widget.facility.pricePerHour} / jam';
  }

  @override
  Widget build(BuildContext context) {
    final facility = widget.facility;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Fasilitas')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                facility.imageUrl,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 240,
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported, size: 48),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facility.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    _DetailRow(label: 'Lokasi', value: facility.location),
                    _DetailRow(
                      label: 'Kapasitas',
                      value: '${facility.capacity} orang',
                    ),
                    _DetailRow(label: 'Harga', value: _formattedPrice),
                    _DetailRow(
                      label: 'Status',
                      value: facility.isAvailable ? 'Tersedia' : 'Penuh',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Deskripsi',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(facility.description),
                    const SizedBox(height: 24),
                    if (_isReserved) ...[
                      const Text(
                        'Reservasi berhasil dikonfirmasi.',
                        key: Key('reservationConfirmation'),
                        style: TextStyle(color: Colors.green),
                      ),
                      const SizedBox(height: 12),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        key: const Key('reserveButton'),
                        onPressed: facility.isAvailable && !_isReserved
                            ? () => setState(() => _isReserved = true)
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: facility.isAvailable
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                        child: Text(
                          _isReserved
                              ? '✅ Reservasi Berhasil'
                              : 'Reservasi Sekarang',
                        ),
                      ),
                    ),
                    if (_isReserved) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          key: const Key('backToListButton'),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Kembali ke Daftar'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
