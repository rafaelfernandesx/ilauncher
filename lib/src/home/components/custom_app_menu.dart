import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppMenu extends StatelessWidget {
  const CustomAppMenu({
    super.key,
    this.onTap,
    this.onLongPress,
    this.svgPath,
    required this.label,
  });

  final void Function()? onTap;
  final void Function()? onLongPress;
  final String? svgPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 75,
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SvgPicture.asset(
                  'assets/icons/svg/settings-icon.svg',
                  semanticsLabel: 'Acme Logo',
                  width: 55,
                  height: 55,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(61, 0, 0, 0),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
