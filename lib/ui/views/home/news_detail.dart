import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_to_earn/core/constants/sizes.dart';
import 'package:move_to_earn/ui/component/backrounds/backColor.dart';
import 'package:move_to_earn/ui/component/buttons/back_arrow.dart';
import 'package:move_to_earn/ui/component/headers/header_for_page.dart';

import 'package:move_to_earn/utils/theme/widget_theme/text_theme.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackColor(),
          HeaderForPage(
            backArrow: BackArrow(),
            text: "Мэдээ",
          ),
          Container(
            padding: EdgeInsets.only(top: viewTopSpaceSize.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [1, 2, 3].map((e) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                            margin: EdgeInsets.only(right: 16),
                            width: bannerWidth.w,
                            height: bannerHeight.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/coupon_images/banner.png",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 29.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Алхах эрүүл мэндэд ямар тустай вэ?".toUpperCase(),
                            style: TTextTheme.darkTextTheme.displaySmall),
                        SizedBox(
                          height: 32.h,
                        ),
                        Text(
                          "Биеийн галбираа хадгалах амаргүй бөгөөд хүн бүр сайхан галбиртай байхыг хүсдэг. Гэхдээ биеийн галбираа хадгалахын тулд өдөр бүр бялдаржуулах төвд хичээллэх эсвэл  өдөрт 5 км гүйх шаардлагатай гэсэн үг биш. Харин тогтмол алхах нь эрүүл мэндэд тустайгаас гадна биеийн галбираа хадгалахад тусалдаг. Явган алхах нь сэтгэл санаа, зүрх судасны эрүүл мэндийг сайжруулахаас гадна агаарт гарахад уушиг хүчилтөрөгчөөр хангагдаж, тодорхой хэмжээгээр витамин Д авах боломжтой байдаг. Гэртээ суулгүй гадаа гарч эргэн тойрноо ажиглан алхах нь сэтгэл санааг өргөж өгдөг.",
                          textAlign: TextAlign.justify,
                          style: TTextTheme.darkTextTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 160,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
