import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

Shimmer getShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //location
            Container(
              height: 40,
              width: 150,
              color: Colors.white,
            ).box.rounded.make(),
            13.heightBox,
            //short status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  height: 80,
                  width: 80,
                ).box.rounded.make(),
                Container(
                  height: 40,
                  color: Colors.white,
                ).box.rounded.make(),
              ],
            ),
            //highest and lowest temp
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 15,
                  color: Colors.white,
                ).box.rounded.make(),
                Container(
                  height: 15,
                  color: Colors.white,
                ).box.rounded.make(),
              ],
            ),
            8.heightBox,
            //cloud humadity wind persents
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        width: 60,
                        height: 60,
                      )
                          .box
                          .padding(const EdgeInsets.all(8))
                          .gray200
                          .rounded
                          .make(),
                      8.heightBox,
                      Container(
                        height: 10,
                        color: Colors.white,
                      ).box.rounded.make()
                    ],
                  );
                },
              ),
            ),
            8.heightBox,
            const Divider(),
            8.heightBox,
            //next 7hours update
            Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Container(
                              height: 10,
                              color: Colors.white,
                            ),
                            Container(
                              width: 80,
                              color: Colors.white,
                            ),
                            Container(
                              height: 15,
                              color: Colors.white,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                8.heightBox,
                const Divider(),
                8.heightBox,
                //next 7 days text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20,
                      color: Colors.white,
                    ),
                    Container(
                      height: 20,
                      color: Colors.white,
                    )
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Container(
                              height: 30,
                              color: Colors.white,
                            )),
                            Expanded(
                                child: Container(
                              height: 20,
                              width: 40,
                              color: Colors.white,
                            )),
                            Container(
                              height: 15,
                              color: Colors.white,
                            ),
                            Container(
                              height: 15,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
