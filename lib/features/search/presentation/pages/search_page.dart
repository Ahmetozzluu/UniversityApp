import 'package:flutter/material.dart';
import 'package:universtyapp/features/search/presentation/widgets/search_filters_bottom_sheet.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Arama başlığı ve geri butonu
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Üniversite veya bölüm ara...',
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.search_rounded,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_searchQuery.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _searchQuery = '';
                                  });
                                },
                              ),
                            IconButton(
                              icon: Icon(
                                Icons.tune_rounded,
                                color: Colors.blue.shade700,
                                size: 20,
                              ),
                              onPressed: () => _showFilterBottomSheet(context),
                            ),
                          ],
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue.shade100),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // İçerik
            Expanded(
              child: _searchQuery.isEmpty
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Popüler Aramalar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSearchTags(),
                          const SizedBox(height: 24),
                          const Text(
                            'Öne Çıkan Bölümler',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDepartmentList(),
                        ],
                      ),
                    )
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildSearchChip('Bilgisayar Mühendisliği', Icons.computer),
        _buildSearchChip('Tıp', Icons.local_hospital),
        _buildSearchChip('İstanbul', Icons.location_on),
        _buildSearchChip('Devlet Üniversiteleri', Icons.school),
        _buildSearchChip('İngilizce Eğitim', Icons.language),
        _buildSearchChip('Hukuk', Icons.gavel),
      ],
    );
  }

  Widget _buildSearchChip(String label, IconData icon) {
    return ActionChip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: Colors.white,
      side: BorderSide(color: Colors.grey.shade300),
      onPressed: () {
        setState(() {
          _searchController.text = label;
          _searchQuery = label;
        });
      },
    );
  }

  Widget _buildDepartmentList() {
    final departments = [
      {
        'name': 'Bilgisayar Mühendisliği',
        'count': '120+ Program',
        'icon': Icons.computer,
        'color': Colors.blue
      },
      {
        'name': 'Tıp',
        'count': '85+ Program',
        'icon': Icons.local_hospital,
        'color': Colors.red
      },
      {
        'name': 'İşletme',
        'count': '150+ Program',
        'icon': Icons.business,
        'color': Colors.orange
      },
      {
        'name': 'Hukuk',
        'count': '95+ Program',
        'icon': Icons.gavel,
        'color': Colors.purple
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final dept = departments[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (dept['color'] as MaterialColor).shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                dept['icon'] as IconData,
                color: dept['color'] as MaterialColor,
              ),
            ),
            title: Text(
              dept['name'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              dept['count'] as String,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              setState(() {
                _searchController.text = dept['name'] as String;
                _searchQuery = dept['name'] as String;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _getFilteredResults().length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final result = _getFilteredResults()[index];
        return _buildSearchResultItem(result);
      },
    );
  }

  List<String> _getFilteredResults() {
    final results = [
      'Boğaziçi Üniversitesi',
      'Bilkent Üniversitesi',
      'Bilgisayar Mühendisliği',
      'Bilgi Üniversitesi',
    ];
    return results
        .where((result) => result.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Widget _buildSearchResultItem(String result) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(Icons.school, color: Colors.blue.shade700),
      ),
      title: Text(result),
      subtitle: Text(
        'İstanbul • Devlet Üniversitesi',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
      onTap: () {
        // Üniversite detay sayfasına git
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const SearchFiltersBottomSheet(),
    );
  }
}