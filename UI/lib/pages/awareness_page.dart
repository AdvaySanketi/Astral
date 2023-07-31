import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Astral/components/curve.dart';
import 'package:Astral/data.dart';
import 'package:Astral/models/Med.dart';
import 'package:Astral/models/recently_viewed_med.dart';
import 'package:Astral/pages/med_details.dart';

class AwarenessPage extends StatefulWidget {
  const AwarenessPage({Key? key}) : super(key: key);

  @override
  State<AwarenessPage> createState() => _AwarenessPageState();
}

class _AwarenessPageState extends State<AwarenessPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Let\'s find your meds!',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.green,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.green),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search Medicines',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.green,
                        size: 26.0,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.mic),
                        color: Colors.green,
                        iconSize: 26.0,
                        splashRadius: 20.0,
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250.0,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 220.0,
                            child: ListView.separated(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: meds.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 20.0);
                              },
                              itemBuilder: (context, index) {
                                return MedCard(
                                  medComp: meds[index].medComp,
                                  medName: meds[index].medName,
                                  medPrice: meds[index].medPrice,
                                  image: Image.asset(
                                    meds[index].image,
                                    alignment: Alignment.topLeft,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MedDetailsPage(
                                                med: meds[index],
                                              )),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 16.0),
                          child: Text(
                            'Recently Viewed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                          child: ListView.separated(
                            itemCount: viewed.length,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return RecentlyViewedCard(
                                medName: viewed[index].medName,
                                medInfo: viewed[index].medInfo,
                                image: AssetImage(viewed[index].image),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 20.0);
                            },
                          ),
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
    );
  }
}

class RecentlyViewedCard extends StatelessWidget {
  const RecentlyViewedCard({
    required this.medName,
    required this.medInfo,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String medName;
  final String medInfo;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(width: 24.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              medName,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              medInfo,
              style: GoogleFonts.poppins(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class MedCard extends StatelessWidget {
  const MedCard({
    required this.medComp,
    required this.medName,
    required this.medPrice,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String medComp;
  final String medName;
  final double medPrice;
  final Image image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 230.0,
            width: 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          Positioned(
            // height: 240.0,
            // width: 124.0,
            left: 8.0,
            bottom: 70.0,
            child: Container(
              color: Colors.white,
              constraints:
                  const BoxConstraints(maxWidth: 140.0, maxHeight: 240.0),
              child: Hero(tag: medName, child: image),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              width: 185,
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medComp,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Expanded(
                            child: Text(
                              medName,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 35, 147, 4),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      constraints: const BoxConstraints(maxWidth: 90.0),
                      child: Text(
                        '₹${medPrice}0',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
