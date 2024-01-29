import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:weather_app/about/about_page.dart';
import 'package:weather_app/consts/colors.dart';
import 'package:weather_app/consts/images.dart';
import 'package:weather_app/consts/strings.dart';
import 'package:weather_app/controller/home_controller.dart';
import 'package:weather_app/models/currentweather_moder.dart';
import 'package:weather_app/widzet/shimmer_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var theme = Theme.of(context);
    var controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      //appbar section
      appBar: AppBar(
        title: date.text.color(theme.primaryColor).make(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  controller.changeTheme();
                },
                icon: Icon(
                  controller.isDark.value ? Icons.light_mode : Icons.dark_mode,
                  color: theme.iconTheme.color,
                )),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const AboutPage());
            },
            icon: Icon(
              Icons.info,
              color: theme.iconTheme.color,
            ),
          )
        ],
      ),
      body: Obx(
        () => controller.isloaded.value == true
            ? Container(
                padding: const EdgeInsets.all(12),
                child: FutureBuilder(
                  future: controller.currentWeatherData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return getShimmerLoading();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'No internet connection !',
                          style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return const Text('No Data');
                    } else {
                      CurrentweatherData data = snapshot.data;
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //location
                            "${data.name}"
                                .text
                                .uppercase
                                .fontFamily("Poppins_bold")
                                .size(28)
                                .color(theme.iconTheme.color)
                                .letterSpacing(3)
                                .make(),
                            //short status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/weather/${data.weather![0].icon}.png",
                                  height: 80,
                                  width: 80,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${data.main!.temp}",
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 64,
                                          fontFamily: "poppins",
                                        ),
                                      ),
                                      TextSpan(
                                        text: "  ${data.weather![0].main}",
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 14,
                                          letterSpacing: 3,
                                          fontFamily: "poppins",
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            //highest and lowest temp
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.expand_less,
                                      color: theme.iconTheme.color,
                                    ),
                                    label: "${data.main!.tempMax}$degree"
                                        .text
                                        .color(theme.iconTheme.color)
                                        .make()),
                                TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.expand_more,
                                    color: theme.iconTheme.color,
                                  ),
                                  label: "${data.main!.tempMin}$degree"
                                      .text
                                      .color(theme.iconTheme.color)
                                      .make(),
                                ),
                              ],
                            ),
                            8.heightBox,
                            //cloud humadity wind persents
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                3,
                                (index) {
                                  var iconsList = [clouds, humidity, windspeed];
                                  var values = [
                                    "${data.clouds!.all}",
                                    "${data.main!.humidity}",
                                    "${data.wind!.speed} km/h"
                                  ];
                                  return Column(
                                    children: [
                                      Image.asset(
                                        iconsList[index],
                                        width: 60,
                                        height: 60,
                                      )
                                          .box
                                          .padding(const EdgeInsets.all(8))
                                          .gray200
                                          .roundedSM
                                          .make(),
                                      8.heightBox,
                                      values[index].text.gray400.make()
                                    ],
                                  );
                                },
                              ),
                            ),
                            8.heightBox,
                            const Divider(),
                            8.heightBox,
                            //next 7hours update
                            FutureBuilder(
                              future: controller.hourlyweatherData,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return getShimmerLoading();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData) {
                                  return const Text('No Data');
                                } else {
                                  // Since it's a single data point, you can access it directly
                                  var hourlyData = snapshot.data;
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: hourlyData.list!.length > 8
                                              ? 8
                                              : hourlyData.list!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var time = DateFormat.jm().format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        hourlyData.list![index]
                                                                .dt!
                                                                .toInt() *
                                                            1000));
                                            return Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(
                                                  right: 4),
                                              decoration: BoxDecoration(
                                                  color: cardColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Column(
                                                children: [
                                                  time.text.gray200.make(),
                                                  Image.asset(
                                                    "assets/weather/${hourlyData.list![index].weather![0].icon}.png",
                                                    width: 80,
                                                  ),
                                                  "${hourlyData.list![index].main!.temp}$degree"
                                                      .text
                                                      .white
                                                      .make(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          "Next 5 Days"
                                              .text
                                              .size(18)
                                              .semiBold
                                              .color(theme.primaryColor)
                                              .make(),
                                        ],
                                      ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var day = DateFormat("EEEE").format(
                                              DateTime.now().add(
                                                  Duration(days: index + 1)));
                                          return Card(
                                            color: const Color(0xff83c8e4),
                                            child: ClipOval(
                                              clipBehavior: Clip.antiAlias,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff83c8e4),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: day.text.semiBold
                                                            .color(theme
                                                                .primaryColor)
                                                            .make()),
                                                    Expanded(
                                                      child: TextButton.icon(
                                                        onPressed: null,
                                                        icon: Image.asset(
                                                          "assets/weather/${hourlyData.list![index + 8].weather![0].icon}.png",
                                                          width: 30,
                                                        ),
                                                        label:
                                                            "${hourlyData.list![index + 8].main!.temp}$degree"
                                                                .text
                                                                .color(theme
                                                                    .primaryColor)
                                                                .make(),
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "${hourlyData.list![index + 8].main!.temp}$degree /",
                                                            style: TextStyle(
                                                                color: theme
                                                                    .primaryColor,
                                                                fontFamily:
                                                                    "poppins",
                                                                fontSize: 16),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                " ${hourlyData.list![index + 6].main!.temp}$degree",
                                                            style: TextStyle(
                                                                color: theme
                                                                    .primaryColor,
                                                                fontFamily:
                                                                    "poppins",
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              )
            : getShimmerLoading(),
      ),
    );
  }
}
