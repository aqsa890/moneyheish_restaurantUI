import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../components/header_hero.dart';
import '../components/heist_button.dart';

class StartHeistPlanPage extends StatelessWidget {
  const StartHeistPlanPage({super.key});

  List<_PlanStep> get _steps => const [
    _PlanStep(
      icon: Icons.groups_rounded,
      title: 'Assemble the Crew',
      subtitle: 'Assign roles and confirm readiness',
    ),
    _PlanStep(
      icon: Icons.map_rounded,
      title: 'Scope the Target',
      subtitle: 'Blueprint, cameras, and guard shifts',
    ),
    _PlanStep(
      icon: Icons.handyman_rounded,
      title: 'Acquire the Gear',
      subtitle: 'Masks, tools, comms — all synced',
    ),
    _PlanStep(
      icon: Icons.schedule_send_rounded,
      title: 'Lock the Timeline',
      subtitle: 'Entry, execution, and exit windows',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Operation Plan', style: theme.textTheme.titleLarge),
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 280,
              child: const HeaderHero(
                title: 'Operation Plan',
                tagline: 'Synchronize crew, gear, and timeline',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _PlanMeta()
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 8)),
          SliverList.builder(
            itemCount: _steps.length,
            itemBuilder: (context, index) {
              final step = _steps[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: step
                    .animate()
                    .fadeIn(duration: 450.ms)
                    .slideY(begin: 0.15, end: 0)
                    .then(delay: Duration(milliseconds: 80 * index)),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  HeistButton(
                    label: 'Initiate Heist',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black87,
                          content: Row(
                            children: [
                              const Icon(
                                Icons.lock_open_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Plan armed — all systems go!',
                                style: theme.textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
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
                  const SizedBox(height: 14),
                  HeistButton(
                    label: 'Back to Menu',
                    icon: Icons.arrow_back_ios_new_rounded,
                    filled: false,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _PlanMeta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HeistTheme.gunmetal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x22FFFFFF)),
        boxShadow: [HeistTheme.glow(color: HeistTheme.gold)],
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time_rounded, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tonight, 23:45', style: theme.textTheme.titleSmall),
                Text(
                  'Duration 90m • Risk High • Channels encrypted',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: HeistTheme.scarlet,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'LIVE',
              style: theme.textTheme.labelLarge!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PlanStep({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HeistTheme.gunmetal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [HeistTheme.scarlet, Color(0xFF8B0000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [HeistTheme.glow()],
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(subtitle, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.check_circle_rounded,
            color: HeistTheme.gold.withValues(alpha: 0.9),
          ),
        ],
      ),
    );
  }
}
