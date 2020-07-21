import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_me/widget/particle/particle_model.dart';

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;
  Color color;

  ParticlePainter(this.particles, this.time, {this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint=Paint()..color=color.withAlpha(50);
    particles.forEach((element) {
      var progress=element.animationProgress.progress(time);
      final animation=element.tween.transform(progress);
      final position=Offset(animation["x"]*size.width, animation["y"]*size.height);
      canvas.drawCircle(position, size.width*0.2*element.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
