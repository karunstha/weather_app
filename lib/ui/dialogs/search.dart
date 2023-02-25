import 'package:flutter/material.dart';

class DialogSearch extends StatefulWidget {
  const DialogSearch({Key? key}) : super(key: key);

  @override
  State<DialogSearch> createState() => _DialogSearchState();
}

class _DialogSearchState extends State<DialogSearch> {
  final _tecSearch = TextEditingController();
  @override
  void dispose() {
    _tecSearch.dispose();
    super.dispose();
  }

  void _submitSearch() {
    final query = _tecSearch.text.trim();
    Navigator.pop(context, query);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tecSearch,
              decoration: InputDecoration(
                hintText: 'City',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _submitSearch,
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _submitSearch(),
            ),
          ],
        ),
      ),
    );
  }
}
