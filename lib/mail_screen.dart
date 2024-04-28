import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' as vector;

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen>
    with SingleTickerProviderStateMixin {
  double valor = 90;
  double begin = 90;
  double end = 0.0;
  double radius = 10.0;
  late AnimationController controller;
  late Animation<double> animation;
  bool isOpen = true;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    animation = Tween(
      begin: begin,
      end: end,
    ).animate(
      controller,
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD2D5CE),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform(
                  alignment: Alignment.bottomCenter,
                  transform: matrix4Custom(animation.value),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: matrix4Custom(-animation.value),
                        child: CardExample(
                          borderRadius: borderRadiusVertical(top: radius),
                          child: const Text(
                            'Reto: Carta plegable\n\nDonec interdum ipsum in neque vestibulum, vel gravida magna elementum.',
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      CardExample(
                        color: Color.lerp(
                          Colors.white,
                          const Color(0xffC0C1BD),
                          ((animation.value * 100) / begin) / 100,
                        )!,
                        child: const Text(
                          'Donec interdum ipsum in neque vestibulum, vel gravida magna elementum. Sed eu nisl eu leo cursus mattis id ac leo. Nam maximus tortor in purus eleifend elementum. Suspendisse efficitur',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform(
                  alignment: Alignment.topCenter,
                  transform: matrix4Custom(-animation.value),
                  child: CardExample(
                    borderRadius: borderRadiusVertical(bottom: radius),
                    child: const Text(
                      'vel gravida magna elementum. Sed eu nisl eu leo cursus mattis id ac leo. Nam maximus tortor in purus eleifend elementum. Suspendisse efficitur',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          isOpen ? controller.forward(from: 0.0) : controller.reverse();
          isOpen = !isOpen;
        }),
        child: Icon(
          isOpen ? Icons.email_outlined : Icons.drafts_outlined,
        ),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final Widget child;
  const CardExample({
    this.child = const SizedBox(),
    this.color = Colors.white,
    this.borderRadius = BorderRadius.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 60),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

Matrix4 matrix4Custom(double radian) => Matrix4.identity()
  ..setEntry(3, 2, 0.001)
  ..rotateX(
    vector.radians(
      radian,
    ),
  );

BorderRadius borderRadiusVertical({
  double top = 0,
  double bottom = 0,
}) =>
    BorderRadius.vertical(
      top: Radius.circular(
        top,
      ),
      bottom: Radius.circular(
        bottom,
      ),
    );
