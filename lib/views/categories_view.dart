import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/news_service.dart';
import '../viewmodels/home_viewmodel.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final NewsService _service = NewsService();
  List<String> _sites = [];
  String? _selected;

  @override
  void initState() {
    super.initState();
    _loadSites();
  }

  Future<void> _loadSites() async {
    final sites = await _service.fetchAvailableSites(limit: 100);
    setState(() => _sites = sites);
  }

  @override
  Widget build(BuildContext context) {
    final homeVm = Provider.of<HomeViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categorias (por news site)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (_sites.isEmpty) const Center(child: CircularProgressIndicator()),
          if (_sites.isNotEmpty)
            Wrap(
              spacing: 8,
              children: _sites.map((s) {
                final selected = _selected == s;
                return ChoiceChip(
                  label: Text(s, overflow: TextOverflow.ellipsis),
                  selected: selected,
                  onSelected: (_) {
                    setState(() => _selected = selected ? null : s);
                    homeVm.applySiteFilter(selected ? null : s);
                  },
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
