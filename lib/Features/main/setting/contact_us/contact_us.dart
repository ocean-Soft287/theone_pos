import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../corec/constans/app_assets.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7EAEF),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffE7EAEF),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SvgPicture.asset(AppAssets.logo2)),

              25.verticalSpace,
              Text(
                'info'.tr(),
                style: GoogleFonts.almarai(
                  color: const Color(0xff29568C),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              15.verticalSpace,
              InkWell(
                onTap: () async {
                  final url = Uri.parse('https://theonesystemco.com/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {}
                },
                child: Material(
                  color: Colors.white,
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/images/web_site.png', width: 40),

                      Container(
                        width: 1,
                        height: 24,
                        color: const Color(0xffF7BC74),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),

                      Column(
                        children: [
                          Text(
                            'website'.tr(),
                            style: GoogleFonts.almarai(
                              fontSize: 16,
                              color: const Color(0xff2269A6),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'https://theonesystemco.com/',
                            style: GoogleFonts.almarai(
                              fontSize: 16,
                              color: const Color(0xff2269A6),
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.circular(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset('assets/icons/location.svg'),

                    Container(
                      width: 1,
                      height: 24,
                      color: const Color(0xffF7BC74),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),

                    Column(
                      children: [
                        Text(
                          'location_kuwait'.tr(),
                          style: GoogleFonts.almarai(
                            fontSize: 16,
                            color: const Color(0xff2269A6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'location_egypt'.tr(),
                          style: GoogleFonts.almarai(
                            fontSize: 16,
                            color: const Color(0xff2269A6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              25.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2269A6),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/hotPhone.png'),
                        const SizedBox(width: 8),
                        Text(
                          'اتصل بنا',
                          style: GoogleFonts.almarai(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: InkWell(
                        onTap: () {
                          makePhoneCall(phone: '+96522281418');
                        },
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(6.0),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            child: Text(
                              '+965 2228 1418',

                              textAlign: TextAlign.center,
                              style: GoogleFonts.almarai(
                                fontSize: 16,
                                color: const Color(0xff2269A6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: InkWell(
                        onTap: () {
                          makePhoneCall(phone: '+201125727702');
                        },
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(6.0),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            child: Text(
                              '+20 1125 7277 02',
                              textAlign: TextAlign.center,

                              style: GoogleFonts.almarai(
                                fontSize: 16,
                                color: const Color(0xff2269A6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      'راسلنا عبر البريد الإلكتروني',
                      style: GoogleFonts.almarai(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    10.verticalSpace,
                    InkWell(
                      onTap: () {
                        sendEmail(email: 'sales@theonesystemco.com');
                      },
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * .7,
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(6.0),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            child: Text(
                              'sales@theonesystemco.com',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.almarai(
                                fontSize: 16,
                                color: const Color(0xff2269A6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: InkWell(
                        onTap: () {
                          sendEmail(email: 'salesegy@theonesystemco.com');
                        },
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(6.0),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            child: Text(
                              'salesegy@theonesystemco.com',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.almarai(
                                fontSize: 16.sp,
                                color: const Color(0xff2269A6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void makePhoneCall({required String phone}) async {
  final Uri phoneUri = Uri.parse('tel:$phone');
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}

void sendEmail({required String email}) async {
  final Uri emailUri = Uri(scheme: 'mailto', path: email);
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $emailUri';
  }
}
