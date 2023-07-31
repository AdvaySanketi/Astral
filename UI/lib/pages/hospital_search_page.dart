import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Astral/components/curve.dart';
import 'package:Astral/data.dart';
import 'package:Astral/models/Hospital.dart';
import 'package:Astral/models/recently_viewed_hospital.dart';
import 'package:Astral/pages/hospital_details_page.dart';

class HospitalSearchPage extends StatefulWidget {
  const HospitalSearchPage({Key? key}) : super(key: key);

  @override
  State<HospitalSearchPage> createState() => _HospitalSearchPageState();
}

class _HospitalSearchPageState extends State<HospitalSearchPage> {
  int selected = 0;
  List hosp = rechosp;
  List hosps = [rechosp, ratehosp, costhosp, disthosp];

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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Search For Any Hospital',
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
                      hintText: 'Search Hospitals',
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
                  CategorySelector(
                    selected: selected,
                    categories: const [
                      'Recommended',
                      'Rating',
                      'Cost',
                      'Distance',
                    ],
                    onTap: (index) {
                      setState(() {
                        selected = index;
                        hosp = hosps[index];
                      });
                    },
                  ),
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
                              itemCount: hosp.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 20.0);
                              },
                              itemBuilder: (context, index) {
                                return HospCard(
                                  stars: hosp[index].stars,
                                  hospName: hosp[index].hospName,
                                  hospPrice: hosp[index].hospPrice,
                                  image: Image.asset(
                                    hosp[index].image,
                                    alignment: Alignment.topLeft,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HospitalDetailsPage(
                                                hosp: hosp[index],
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
                            itemCount: viewedhosp.length,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return RecentlyViewedCard(
                                hospName: viewedhosp[index].hospName,
                                hospInfo: viewedhosp[index].hospInfo,
                                image: AssetImage(viewedhosp[index].image),
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
    required this.hospName,
    required this.hospInfo,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String hospName;
  final String hospInfo;
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
              hospName,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              hospInfo,
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

class HospCard extends StatelessWidget {
  const HospCard({
    required this.stars,
    required this.hospName,
    required this.hospPrice,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final double stars;
  final String hospName;
  final String hospPrice;
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
            width: 200.0,
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
            bottom: 95.0,
            child: Container(
              color: Colors.white,
              constraints:
                  const BoxConstraints(maxWidth: 140.0, maxHeight: 240.0),
              child: Hero(tag: hospName, child: image),
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
                          const SizedBox(height: 2.0),
                          Expanded(
                            child: Text(
                              hospName,
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
                        '₹${hospPrice}0',
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

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.selected,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  final int selected;
  final List<String> categories;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < categories.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.symmetric(
                vertical: selected == i ? 8.0 : 0.0,
                horizontal: selected == i ? 12.0 : 0.0,
              ),
              decoration: BoxDecoration(
                color: selected == i ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: GestureDetector(
                onTap: () {
                  onTap(i);
                },
                child: Align(
                  child: Text(
                    categories[i],
                    style: TextStyle(
                      color: selected == i ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
