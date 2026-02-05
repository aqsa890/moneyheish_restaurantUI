import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import 'heist_button.dart';

class MenuItem {
  final String imageAsset;
  final String name;
  final String description;
  final double price;
  final String? badge; // e.g., Hot Deal / Chef's Choice

  const MenuItem({
    required this.imageAsset,
    required this.name,
    required this.description,
    required this.price,
    this.badge,
  });
}

class MenuCard extends StatefulWidget {
  final MenuItem item;
  final VoidCallback? onOrder;

  const MenuCard({super.key, required this.item, this.onOrder});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(item.imageAsset, fit: BoxFit.cover),
                      ),
                      if (item.badge != null)
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: HeistTheme.scarlet,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [HeistTheme.glow()],
                            ),
                            child: Text(
                              item.badge!,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _PriceTag(
                      price: item.price,
                    ).animate().shimmer(duration: 1400.ms),
                    const Spacer(),
                    HeistButton(
                      label: 'Order Now',
                      icon: Icons.lock_open,
                      onPressed: widget.onOrder,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
        color: HeistTheme.iron,
      ),
      child: Text(
        '\$${price.toStringAsFixed(2)}',
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: HeistTheme.gold),
      ),
    );
  }
}
