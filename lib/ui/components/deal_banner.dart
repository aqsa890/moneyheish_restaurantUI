import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import 'heist_button.dart';

class DealBanner extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? timeLeft; // Static text alternative
  final DateTime? endTime; // Live countdown target
  final VoidCallback? onTap;

  const DealBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.timeLeft,
    this.endTime,
    this.onTap,
  });

  @override
  State<DealBanner> createState() => _DealBannerState();
}

class _DealBannerState extends State<DealBanner> {
  late Timer? _timer;
  String _display = '';

  @override
  void initState() {
    super.initState();
    _computeDisplay();
    if (widget.endTime != null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    } else {
      _timer = null;
    }
  }

  void _tick() {
    if (!mounted) return;
    _computeDisplay();
  }

  void _computeDisplay() {
    if (widget.endTime == null) {
      _display = widget.timeLeft ?? '';
      setState(() {});
      return;
    }
    final now = DateTime.now();
    Duration remaining = widget.endTime!.difference(now);
    if (remaining.isNegative) remaining = Duration.zero;
    String two(int n) => n.toString().padLeft(2, '0');
    final h = two(remaining.inHours);
    final m = two(remaining.inMinutes % 60);
    final s = two(remaining.inSeconds % 60);
    _display = '$h:$m:$s';
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [HeistTheme.scarlet, Color(0xFF8B0000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [HeistTheme.glow()],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          if (_display.isNotEmpty)
            Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Text(
                    _display,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                )
                .animate()
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.03, 1.03),
                  duration: 1200.ms,
                )
                .then()
                .fadeIn(duration: 600.ms),
          const SizedBox(width: 12),
          HeistButton(
            label: 'Grab Deal',
            icon: Icons.local_fire_department,
            onPressed: widget.onTap,
          ),
        ],
      ),
    );
  }
}
