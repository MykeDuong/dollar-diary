import 'dart:ui';

import 'package:dollar_diary/components/avatar.dart';
import 'package:dollar_diary/components/bar_chart.dart';
import 'package:dollar_diary/components/screen_safe_area.dart';
import 'package:dollar_diary/components/surface_card.dart';
import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/constants/styles.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dollar_diary/components/round_icon_button.dart';

class HomePage extends ConsumerWidget {
  static const id = "homePageId";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);
    final chosenUnit = ref.watch(chosenComparisonUnitProvider);
    return Scaffold(
      backgroundColor: kAppSurfaceColor,
      body: ScreenSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Avatar(),
                    const SizedBox(width: 16.0),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          'Hi Minh,',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        Text(
                          'How are you doing?',
                          style: TextStyle(color: kMutedGreyColor),
                        ),
                      ],
                    ),
                  ],
                ),
                RoundIconButton(
                  icon: SvgPicture.asset(
                    'assets/images/SettingIcon.svg',
                    colorFilter: const ColorFilter.mode(
                      kMutedGreyColor,
                      BlendMode.srcIn,
                    ),
                    semanticsLabel: 'Setting Icon',
                  ),
                )
              ],
            ),
            const SizedBox(height: 30.0),
            const Text(
              'Your Current Balance:',
              style: TextStyle(
                fontSize: 20,
                color: kMutedGreyColor,
              ),
            ),
            Text(
              '\$1230.23',
              style: const TextStyle(
                fontSize: 54.0,
                color: kCoolGreyColor,
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  child: SurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24.0,
                          backgroundColor: kOverlaySurfaceColor,
                          child: SvgPicture.asset(
                            'assets/images/SpendIcon.svg',
                            colorFilter: ColorFilter.mode(
                                highlightColor, BlendMode.srcIn),
                            semanticsLabel: 'Spend Icon',
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Total Spend',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: kCoolGreyColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '\$160.94',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: kCoolGreyColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'That\'s',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: kMutedGreyColor,
                          ),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              '32 ',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: kMutedGreyColor,
                              ),
                            ),
                            Image.asset(
                              chosenUnit.imageAsset,
                              height: 15.0,
                              width: 15.0,
                            ),
                            Text(
                              ' ${chosenUnit.name}!',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: kMutedGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: SurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24.0,
                          backgroundColor: kOverlaySurfaceColor,
                          child: SvgPicture.asset(
                            'assets/images/ReceivedIcon.svg',
                            colorFilter: ColorFilter.mode(
                                highlightColor, BlendMode.srcIn),
                            semanticsLabel: 'Received Icon',
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Total Received',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: kCoolGreyColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '\$352.92',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: kCoolGreyColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Let\'s order',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: kMutedGreyColor,
                          ),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              '70 ',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: kMutedGreyColor,
                              ),
                            ),
                            Image.asset(
                              chosenUnit.imageAsset,
                              height: 15.0,
                              width: 15.0,
                            ),
                            Text(
                              ' ${chosenUnit.name}!',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: kMutedGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            SurfaceCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Analytics',
                        style: kHeadingTextStyle,
                      ),
                      Text(
                        'July - December',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kMutedGreyColor,
                        ),
                      ),
                      RoundIconButton(
                        icon: SvgPicture.asset(
                          'assets/images/AltSettingIcon.svg',
                          colorFilter: ColorFilter.mode(
                            highlightColor,
                            BlendMode.srcIn,
                          ),
                          semanticsLabel: 'Setting Icon',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 250.0,
                    child: BarChart(
                      observations: [
                        Observation(value: 100000.0, period: 'Jul'),
                        Observation(value: 124839.4, period: 'Aug'),
                        Observation(value: 284749.0, period: 'Sep'),
                        Observation(value: 149523.0, period: 'Oct'),
                        Observation(value: 194540.0, period: 'Nov'),
                        Observation(value: 394823.3, period: 'Dec'),
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
