import 'package:flutter/material.dart';
import 'package:nova_ecommerce/models/faqs.dart';

class Faqs_widget extends StatelessWidget {
  final Faq faq;

  Faqs_widget({required this.faq});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(25),
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      height: 70,
      child: Column(
        children: [
          Text(faq.questionEn),
          Text(faq.questionAr),

        ],
      ),
    );
  }
}
