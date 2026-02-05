import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';

class HeistButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;

  const HeistButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Colors.white,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );

    final button = Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        gradient: filled
            ? const LinearGradient(
                colors: [HeistTheme.scarlet, Color(0xFF8B0000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: filled ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: HeistTheme.scarlet, width: 1.2),
        boxShadow: filled ? [HeistTheme.glow()] : null,
      ),
      child: child,
    );

    return GestureDetector(
      onTap: onPressed,
      child: button
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.02, 1.02))
          .shimmer(duration: 1800.ms),
    );
  }
}
