import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class PageSelectionGrid extends StatelessWidget {
  final Function(int page) onPageSelected;
  final List<int> pages = List.generate(8, (index) => index + 9);

  PageSelectionGrid({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: pages.length,
      itemBuilder: (context, index) {
        final page = pages[index];
        return _PageCard(page: page, onTap: () => onPageSelected(page));
      },
    );
  }
}

class _PageCard extends StatelessWidget {
  final int page;
  final VoidCallback onTap;

  const _PageCard({required this.page, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppTheme.surfaceContainer,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            '$page',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
