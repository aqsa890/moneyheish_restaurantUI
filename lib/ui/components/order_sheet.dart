import 'package:flutter/material.dart';
import '../theme.dart';
import 'heist_button.dart';
import 'menu_card.dart';

void showOrderSheet(BuildContext context, MenuItem item) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: HeistTheme.gunmetal,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => _OrderSheet(item: item),
  );
}

class _OrderSheet extends StatefulWidget {
  final MenuItem item;
  const _OrderSheet({required this.item});

  @override
  State<_OrderSheet> createState() => _OrderSheetState();
}

class _OrderSheetState extends State<_OrderSheet> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final total = (item.price * qty);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item.imageAsset,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('Quantity', style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                _QtyButton(
                  icon: Icons.remove,
                  onTap: () => setState(() {
                    if (qty > 1) qty--;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '$qty',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _QtyButton(
                  icon: Icons.add,
                  onTap: () => setState(() {
                    qty++;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white24),
                    color: HeistTheme.iron,
                  ),
                  child: Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: HeistTheme.gold),
                  ),
                ),
                const Spacer(),
                HeistButton(
                  label: 'Confirm',
                  icon: Icons.lock,
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: HeistTheme.iron,
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              'Heist secured: ${item.name} x$qty!',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
          color: HeistTheme.iron,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
