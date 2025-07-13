import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmersearchList() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 20,
          ),
          title: Container(
            color: Colors.grey.shade300,
            height: 15,
            width: double.infinity,
          ),
          subtitle: Container(
            color: Colors.grey.shade300,
            height: 12,
            width: double.infinity,
          ),
          trailing: Container(
            color: Colors.grey.shade300,
            height: 20,
            width: 40,
          ),
        ),
      );
    },
  );
}

Widget buildShimmercard() {
  return ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SizedBox(
          width: 328.w,
          height: 220.h,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 8.0.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 95.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 100.w,
                                  height: 14.h,
                                  color: Colors.grey),
                              SizedBox(width: 8.0.w),
                              Container(
                                  width: 80.w,
                                  height: 14.h,
                                  color: Colors.grey),
                              const Spacer(),
                              Container(
                                  width: 50.w,
                                  height: 14.h,
                                  color: Colors.grey),
                            ],
                          ),
                          SizedBox(height: 8.0.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 80.w,
                                      height: 12.h,
                                      color: Colors.grey),
                                  SizedBox(height: 4.0.h),
                                  Row(
                                    children: [
                                      Container(
                                          width: 40.w,
                                          height: 12.h,
                                          color: Colors.grey),
                                      SizedBox(width: 3.0.w),
                                      Container(
                                          width: 60.w,
                                          height: 12.h,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 4.r,
                                    backgroundColor: Colors.grey,
                                  ),
                                  Container(
                                    width: 40.w,
                                    height: 2.h,
                                    color: Colors.grey,
                                  ),
                                  CircleAvatar(
                                    radius: 4.r,
                                    backgroundColor: Colors.grey,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      width: 80.w,
                                      height: 12.h,
                                      color: Colors.grey),
                                  SizedBox(height: 4.0.h),
                                  Row(
                                    children: [
                                      Container(
                                          width: 40.w,
                                          height: 12.h,
                                          color: Colors.grey),
                                      SizedBox(width: 3.0.w),
                                      Container(
                                          width: 60.w,
                                          height: 12.h,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0.h),
                    Row(
                      children: [
                        Icon(
                          Icons.chair_outlined,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                        SizedBox(width: 5.h),
                        Container(
                            width: 100.w, height: 14.h, color: Colors.grey),
                        const Spacer(),
                        Container(
                            width: 60.w, height: 14.h, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 12.0.h),
                    Container(
                      width: 120.w,
                      height: 40.h,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}