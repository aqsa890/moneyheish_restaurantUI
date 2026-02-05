import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/header_hero.dart';
import '../components/deal_banner.dart';
import '../components/menu_card.dart';
import '../components/heist_button.dart';
import '../components/order_sheet.dart';

class HeistMenuPage extends StatelessWidget {
  const HeistMenuPage({super.key});

  List<MenuItem> get items => const [
    MenuItem(
      imageAsset: 'assets/professor.jpg',
      name: "Professor's Pasta",
      description: 'Handmade tagliatelle, truffle cream, and shaved parmesan.',
      price: 18.90,
      badge: "Chef's Choice",
    ),
    MenuItem(
      imageAsset: 'assets/vault.jpg',
      name: 'Berlin Steak',
      description: 'Dry-aged ribeye, pepper crust, smoked garlic butter.',
      price: 29.50,
      badge: 'Hot Deal',
    ),
    MenuItem(
      imageAsset: 'assets/bags.jpg',
      name: 'Tokyo Tacos',
      description: 'Wagyu beef, pickled jalapeño, gold dust crisp.',
      price: 16.00,
    ),
    MenuItem(
      imageAsset: 'assets/money.png',
      name: 'Rio Ramen',
      description: 'Spicy miso broth, soft-boiled egg, charred corn.',
      price: 14.75,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Bella Ciao Bistro', style: theme.textTheme.titleLarge),
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 320,
              child: const HeaderHero(
                title: 'Bella Ciao Bistro',
                tagline: 'Every bite is part of the plan',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DealBanner(
                title: 'Operation Tonight: 30% Off',
                subtitle: 'Secure the vault of flavors before midnight',
                endTime: DateTime.now().add(
                  const Duration(hours: 2, minutes: 15, seconds: 43),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black87,
                      content: Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Deal secured — prepare the plan!',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    MenuCard(
                          item: item,
                          onOrder: () => showOrderSheet(context, item),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.15, end: 0)
                        .then(delay: Duration(milliseconds: 60 * index)),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Center(
                child: HeistButton(
                  label: 'Start the Heist',
                  icon: Icons.play_arrow_rounded,
                  onPressed: () => Navigator.of(context).pushNamed('/plan'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 24)),
        ],
      ),
    );
  }
}
