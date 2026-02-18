import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class NavElement extends StatelessWidget {
  final int pageNumber;
  final String label;
  final int currentPage;
  final Function(int) onTap;

  const NavElement(
    this.pageNumber,
    this.label, {
    super.key,
    required this.currentPage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: GestureDetector(
        onTap: () => onTap(pageNumber),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xs),
          child: Column(
            children: [
              Text(
                label,
                style: (currentPage == pageNumber)
                    ? Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    : Theme.of(context).textTheme.titleLarge,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                height: 3,
                width: (currentPage == pageNumber) ? 20 : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
