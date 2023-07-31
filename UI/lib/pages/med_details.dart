import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Astral/models/Med.dart';

class MedDetailsPage extends StatefulWidget {
  const MedDetailsPage({required this.med, Key? key}) : super(key: key);

  final Med med;

  @override
  State<MedDetailsPage> createState() => _MedDetailsPageState();
}

class _MedDetailsPageState extends State<MedDetailsPage> {
  bool favorite = false;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leadingWidth: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            color: Colors.black,
            padding: const EdgeInsets.only(top: 60.0, bottom: 15.0),
            child: Hero(
              tag: widget.med.medName,
              child: Image.asset(widget.med.image),
            ),
          ),
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.58,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.med.medName,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Text(
                                '₹${widget.med.medPrice * quantity}0',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              StarRating(
                                stars: 5.0,
                                size: 16.0,
                                onChanged: (value) {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Medical Disclaimer',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 20.0),
                          child: Text(
                            'Please consult your physician for personalized medical advice. Always seek the advice of a physician or other qualified healthcare provider with any questions regarding a medical condition. Never disregard or delay seeking professional medical advice or treatment.',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          child: Row(
                            children: [
                              MedMetricsWidget(
                                title: 'Composition',
                                value: widget.med.medComp,
                                icon: Icons.medical_information_rounded,
                              ),
                              MedMetricsWidget(
                                title: 'Dosage',
                                value: widget.med.medDose,
                                icon: Icons.all_inbox_rounded,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({
    required this.min,
    required this.max,
    required this.initial,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final int min;
  final int max;
  final int initial;
  final Function(int) onChanged;

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  @override
  void initState() {
    quantity = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.0,
      width: 95.0,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onChanged(
                      quantity != widget.min ? --quantity : widget.min);
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
          Align(
            child: Text(
              '$quantity',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onChanged(
                      quantity != widget.max ? ++quantity : widget.max);
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MedMetricsWidget extends StatelessWidget {
  const MedMetricsWidget({
    required this.title,
    required this.value,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      padding: const EdgeInsets.only(right: 28.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 28.0,
            child: Icon(
              icon,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Align(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int scale;
  final double stars;
  final Color? color;
  final double? size;
  final Function(double)? onChanged;

  const StarRating({
    this.scale = 5,
    this.stars = 0.0,
    this.size,
    this.color = Colors.orange,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    if (index >= stars) {
      icon = Icons.star_border;
    } else if (index > stars - 1 && index < stars) {
      icon = Icons.star_half;
    } else {
      icon = Icons.star;
    }
    return GestureDetector(
      onTap: () => onChanged!(index + 1.0),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        scale,
        (index) => buildStar(context, index),
      ),
    );
  }
}
