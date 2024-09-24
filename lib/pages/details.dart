// ignore_for_file: prefer_const_constructors

import 'package:e_comarance_app/model/item.dart';
import 'package:e_comarance_app/provider/cart.dart';
import 'package:e_comarance_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class details extends StatefulWidget {
  Items prodect;
  details({required this.prodect});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  bool showmore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: screen,
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text("Details"),
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                      child: Consumer<Cart>(
                          builder: ((context, classInstancee, child) {
                        return Text(
                          "${classInstancee.selectitems.length}",
                          style: TextStyle(),
                        );
                      })),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: BTNblue,
                          shape: BoxShape.circle)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
                ],
              ),
              Consumer<Cart>(builder: ((context, classInstancee, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text("\$ ${classInstancee.total}"),
                );
              }))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.prodect.imglink),
            Text(
              "\$ ${widget.prodect.price}",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: BTNpink),
                      child: Text(
                        "New",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 251, 193, 0),
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 251, 193, 0),
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 251, 193, 0),
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 251, 193, 0),
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 251, 193, 0),
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.edit_location,
                      size: 26,
                      color: Color.fromARGB(168, 3, 65, 27),
                      // color: Color.fromARGB(255, 186, 30, 30),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.prodect.location,
                      style: TextStyle(fontSize: 19),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 33,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  "Details : ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                )),
            SizedBox(
              height: 12,
            ),            Text(
"HardwareiPhone 14 and 14 Plus are available in three internal storage configurations: 128, 256, and 512 GB. Both models have 6 GB of RAM, an increase over the previous iPhone 13 and 13 mini models' 4 GB of RAM. The iPhone 14 and 14 Plus have the same IP68 rating for dust and water resistance as their predecessors.[6]ChipsetThe iPhone 14 and 14 Plus use a 5-nanometer Apple-designed system on a chip, the A15 Bionic, while the iPhone 14 Pro and 14 Pro Max have a faster A16 Bionic.[27][28The iPhone 14's A15 chip has a 6-core CPU, 5-core GPU, and a 16-core Neural Engine. It is identical to the A15 in the previous year's iPhone 13 Pro and 13 Pro Max,[27][28] which has more memory and an additional GPU core compared to the A15 in the non-Pro iPhone 13 models.[29][30]The iPhone 14 was the first flagship model since the 2008 iPhone 3G whose chip was unchanged from the previous year.[27] The Verge's Mitchell Clark attributed the unchanged chip to an attempt to maintain costs during the ongoing chip shortage and inflation surge. Clark also said the A15 still outperforms the latest chips from Qualcomm and Google in most benchmarks, though the older chip may lead to the iPhone 14 receiving fewer updates, similar to what happened with the iPhone 5C from 2013.[27][28]DisplayThe iPhone 14 features a 6.1-inch (155 mm) display with Super Retina XDR OLED technology at a resolution of 2532 × 1170 pixels and a pixel density of about 460 PPI with a refresh rate of 60 Hz. The iPhone 14 Plus features a 6.7-inch (170 mm) display with the same technology at a resolution of 2778 × 1284 pixels and a pixel density of about 458 PPI. Both models have typical brightness of up to 800 nits, and a max brightness of up to 1200 nits.[6]CamerasThe iPhone 14 and 14 Plus feature the same camera system with two cameras: one front-facing camera (12MP f/1.9), and two back-facing cameras: a wide (12MP f/1.5) and ultra-wide (12MP f/2.4) camera, with the wide and front-facing cameras having a faster aperture than the iPhone 13. The front-facing camera also has autofocus for the first time.[31]The cameras use Apple's latest computational photography engine, called Smart HDR 4. Users can also choose from a range of photographic styles during capture, including rich contrast, vibrant, warm, and cool. Apple clarifies this is different from a filter because it works intelligently with the image processing algorithm during capture to apply local adjustments to an image, and the effects will be baked into the photos, unlike filters which can be removed after alying.[6]The camera app contains Cinematic Mode, which allows users to rack focus between subjects and create (simulate) shallow depth of field using software algorithms. It is supported on wide and front-facing cameras in 4K at 30 fps.[6]Batterythe iPhone 14 is equipped with slightly longer battery life compared to the iPhone 13. According to Apple, the iPhone 14 (3,279 mAh) can provide up to 20 hours of video playback,[32] 16 hours of streaming video playback, and 80 hours of audio playback. Its predecessor, the iPhone 13 (3,240 mAh), is rated for up to 19 hours of video playback, 15 hours of streaming video playback, and 75 hours of audio playback. The larger iPhone 14 Plus (4,325 mAh) variant provides up to 26 hours of video playback.[33]SoftwareSee also: iOS 16 and iOS 17The iPhone 14 and 14 Plus originally shipped with iOS 16. The upcoming iOS 17, which was revealed at Apple's WWDC 2023 event and is scheduled to be released to the public in the fall of 2023, will be compatible with the iPhone 14 and 14 Plus.[34]",
              style: TextStyle(fontSize: 18),
              maxLines: showmore ? null : 4,
              overflow: TextOverflow.fade,
            ),
            SizedBox(
              height: 7,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    showmore = !showmore;
                  });
                },
                child: Text(
                  showmore ? "show less" : "show more",
                  style: TextStyle(fontSize: 22),
                ))
          ],
        ),
      ),
    );
  }
}
