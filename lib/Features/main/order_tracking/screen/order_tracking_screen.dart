import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:theonepos/Features/main/order_tracking/screen/widget/sub_track.dart';

import '../manager/order_tracking_state.dart';
import '../manager/order_tracking_cubit.dart';

class OrderTrackingScreen extends StatelessWidget {
  OrderTrackingScreen({super.key});
  final formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingCubit(),
      child: BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 1,
            child: Scaffold(
              body: SafeArea(
                child: Form(
                  key: formKey,
                  child: Builder(
                    builder:
                        (context) => SizedBox.expand(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: const Color(0xff007BFF),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          (1.2 / 100),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              (1.2 / 100),
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              (5.91 / 100),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_back_ios,
                                              color: Color(0xff343A40),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  (1.3 / 100),
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Color(0xffF8F9FA),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    decoration: InputDecoration(
                                                      hintText: 'id',
                                                      hintStyle:
                                                          const TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                              0xff6C757D,
                                                            ),
                                                          ),
                                                      border: InputBorder.none,
                                                      prefixIcon: SizedBox(
                                                        width:
                                                            MediaQuery.of(
                                                              context,
                                                            ).size.height *
                                                            (1.72 / 100),
                                                        height:
                                                            MediaQuery.of(
                                                              context,
                                                            ).size.height *
                                                            (1.72 / 100),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                15.0,
                                                              ),
                                                          child: SvgPicture.asset(
                                                            'assets/icons/search1.svg',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(
                                                            context,
                                                          ).size.height *
                                                          (5.72 / 100),
                                                      height:
                                                          MediaQuery.of(
                                                            context,
                                                          ).size.height *
                                                          (5.72 / 100),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              15.0,
                                                            ),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/scan1.svg',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          (1.2 / 100),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height *
                                    (1.1 / 100),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(5, (index) {
                                      return Card(
                                        elevation: 10,
                                        shadowColor: const Color(0xffF7F7FB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              (4.2 / 100),
                                          vertical:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              (2.4 / 100),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        (4.2 / 100),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size.width *
                                                              (4.2 / 100),
                                                        ),
                                                        Text(
                                                          'Dummy Shipment Code [$index]', // Display dummy data here
                                                          style:
                                                              const TextStyle(
                                                                color: Color(
                                                                  0xff007BFF,
                                                                ),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                          ),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size.width *
                                                              (5.0 / 100),
                                                          vertical:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size.width *
                                                              (2.0 / 100),
                                                        ),
                                                    child: Text(
                                                      'Status $index', // Display dummy status here
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    (MediaQuery.of(
                                                          context,
                                                        ).size.height *
                                                        (2.2 / 100)) /
                                                    3,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        (4.2 / 100),
                                                  ),
                                                  Expanded(
                                                    child: StepTracker(
                                                      title:
                                                          'From Address $index', // Dummy address
                                                      icon: null,
                                                      isLast: false,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        (4.2 / 100),
                                                  ),
                                                  Expanded(
                                                    child: StepTracker(
                                                      title:
                                                          'To Address $index', // Dummy address
                                                      icon: null,
                                                      isLast: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    (4.2 / 100),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        (3.2 / 100),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.width *
                                                                (1 / 100),
                                                            vertical:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                (2.4 / 100),
                                                          ),
                                                      child: const Text('date'),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.width *
                                                                (1 / 100),
                                                            vertical:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                (2.4 / 100),
                                                          ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        'الحالة',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        (3.2 / 100),
                                                  ),
                                                ],
                                              ),
                                              ListView.builder(
                                                itemCount:
                                                    3, // Adjust the number of logs if needed
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (
                                                      context,
                                                      logIndex,
                                                    ) => Container(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.width *
                                                                (3.2 / 100),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    MediaQuery.of(
                                                                      context,
                                                                    ).size.width *
                                                                    (1 / 100),
                                                                vertical:
                                                                    MediaQuery.of(
                                                                      context,
                                                                    ).size.height *
                                                                    (2.4 / 100),
                                                              ),
                                                              child: Text(
                                                                'Date $logIndex', // Dummy date
                                                                style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    MediaQuery.of(
                                                                      context,
                                                                    ).size.width *
                                                                    (1 / 100),
                                                                vertical:
                                                                    MediaQuery.of(
                                                                      context,
                                                                    ).size.height *
                                                                    (2.4 / 100),
                                                              ),
                                                              child: Text(
                                                                'Status $logIndex', // Dummy log status
                                                                style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                    0xff007BFF,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.width *
                                                                (3.2 / 100),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildCurrentUI(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // فرضاً عدد الشحنات
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                if (index == 0)
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  const Text(
                                    'Shipment Code [Type]',
                                    style: TextStyle(
                                      color: Colors.blue, // يمكن تخصيص الألوان
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: const Text(
                                'Status', // الحالة
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            const Expanded(
                              child: Text(
                                'From Address', // العنوان المرسل منه
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            const Expanded(
                              child: Text(
                                'Receiver Address', // العنوان المستلم
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            if (index % 2 == 0) // مثال لوجود مهمة أو لا
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                            if (index % 2 == 0)
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                            if (index % 2 == 0)
                              const Text(
                                'In Mission', // في المهمة
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.04,
                              ),
                              child: const Text(
                                'Payment Type', // نوع الدفع
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const Visibility(
          visible: true, // هنا يمكنك تفعيل أو إخفاء اللودينج بناءً على الحالة
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    ),
  );
}
