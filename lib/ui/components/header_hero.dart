import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import '../theme.dart';

class HeaderHero extends StatelessWidget {
  final String title;
  final String tagline;

  const HeaderHero({super.key, required this.title, required this.tagline});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with dark overlay + subtle blur
        Positioned.fill(child: Image.asset('assets/bg.jpg', fit: BoxFit.cover)),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xCC000000), Color(0x99000000)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned.fill(child: const SizedBox.shrink()),
        // Red accent sweep
        Positioned.fill(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Color(0x22B71C1C)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        // Subtle noise overlay for cinematic texture
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.06,
              child: Image.asset(
                'assets/img.png',
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.white.withValues(alpha: 0.6),
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                tagline,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: HeistTheme.smoke),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _Chip(text: 'Premium'),
                  _Chip(text: 'Cinematic'),
                  _Chip(text: 'Minimal'),
                ],
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: HeistTheme.iron.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.labelLarge!.copyWith(color: Colors.white),
      ),
    );
  }
}
