import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';

import 'package:provider/provider.dart';
import 'package:universtyapp/features/favorites/providers/favorites_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String? _selectedCity;
  String? _selectedProgramType;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;
    final filteredUniversities = favorites.where((uni) {
      if (_selectedCity != null && uni.city != _selectedCity) return false;
      if (_selectedProgramType != null) {
        return uni.programs.any((program) => program.type == _selectedProgramType);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        title: const Text(
          'Favorilerim',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // İstatistik kartları
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  title: 'Toplam Favori',
                  value: favorites.length.toString(),
                  icon: Icons.favorite,
                ),
                _buildStatCard(
                  title: 'Devlet',
                  value: favorites.where((u) => u.type == UniversityType.state).length.toString(),
                  icon: Icons.school,
                ),
                _buildStatCard(
                  title: 'Vakıf',
                  value: favorites.where((u) => u.type == UniversityType.private).length.toString(),
                  icon: Icons.account_balance,
                ),
              ],
            ),
          ),

          // Aktif filtreler
          if (_selectedCity != null || _selectedProgramType != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (_selectedCity != null)
                      _buildFilterChip(
                        label: _selectedCity!,
                        onDeleted: () => setState(() => _selectedCity = null),
                      ),
                    if (_selectedProgramType != null)
                      _buildFilterChip(
                        label: _selectedProgramType!,
                        onDeleted: () => setState(() => _selectedProgramType = null),
                      ),
                  ],
                ),
              ),
            ),

          // Favori üniversiteler listesi
          Expanded(
            child: filteredUniversities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            size: 48,
                            color: Colors.blue.shade200,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz favori üniversiteniz yok',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Üniversiteleri Keşfedin',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredUniversities.length,
                    itemBuilder: (context, index) {
                      final university = filteredUniversities[index];
                      return _buildUniversityCard(university);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildUniversityCard(University university) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Hero(
          tag: 'university_${university.id}',
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(university.logoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          university.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  university.city,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      university.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            context.read<FavoritesProvider>().removeFavorite(university.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Favorilerden çıkarıldı'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.red.shade700,
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: onDeleted,
        backgroundColor: Colors.blue.shade50,
        labelStyle: TextStyle(color: Colors.blue.shade700),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filtreleme',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Şehir filtresi
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'Şehir',
                  border: OutlineInputBorder(),
                ),
                items: ['İstanbul', 'Ankara', 'İzmir']
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedCity = value);
                  if (mounted) {
                    this.setState(() {});
                  }
                },
              ),
              const SizedBox(height: 16),
              // Program türü filtresi
              DropdownButtonFormField<String>(
                value: _selectedProgramType,
                decoration: const InputDecoration(
                  labelText: 'Program Türü',
                  border: OutlineInputBorder(),
                ),
                items: ['Lisans', 'Yüksek Lisans', 'Doktora']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedProgramType = value);
                  if (mounted) {
                    this.setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 