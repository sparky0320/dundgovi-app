import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import 'news_detail.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewsDetailPage());
      },
      child: Container(
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const NewsDetailPage()),
        //   );
        // },

        // borderRadius: BorderRadius.circular(8),

        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(bannerRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 12.w,
                  bottom: 12.w,
                  left: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Мэдээ".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.w,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Биеийн галбираа хадгалах амаргүй бөгөөд хүн бүр сайхан галбиртай байхыг хүсдэг. Гэхдээ биеийн галбираа хадгалахын тулд өдөр бүр бялдаржуулах төвд хичээллэх эсвэл  өдөрт 5 км гүйх шаардлагатай гэсэн үг биш. ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.w,
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
            SvgPicture.asset(arrowForwardSvg),
          ],
        ),
      ),
    );
  }
}
