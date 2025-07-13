import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../corec/sharde/font_responsive.dart';
import '../../../InvoiceCollection/manager/invoice_collection_cubit.dart';
import '../../../InvoiceCollection/manager/invoice_collection_state.dart';
import '../../../../../corec/utils/widget/default_button.dart';
import '../../../setting/Login/widget/text_form_field.dart';
import '../manager/search_cubit.dart';
import '../manager/search_state.dart';

class AddAccount extends StatelessWidget {
  final String? value;
  num? patternID;
  AddAccount({super.key, this.value, this.patternID});
  var keyForm = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  final mobileController = TextEditingController();
  final streetController = TextEditingController();
  final houseController = TextEditingController();
  final governorateNameController = TextEditingController();
  final placeNameController = TextEditingController();
  final sectionController = TextEditingController();
  final districtController = TextEditingController();
  final gadaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: value ?? "");
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff1E40AF),
        centerTitle: true,
        title: InkWell(
          onTap: () {},
          child: Text(
            'add_customer'.tr(),
            style: GoogleFonts.almarai(
              color: Colors.white,
              fontSize: getFontSize(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => SearchCubit(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth <= 600;

            return Center(
              child: SizedBox(
                width:
                    isMobile
                        ? MediaQuery.of(context).size.width * 0.9
                        : MediaQuery.of(context).size.width * 0.7,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.verticalSpace,

                      CustomTextFormField(
                        hintText: 'account_name'.tr(),
                        textInputType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_name'.tr();
                          }
                          return null;
                        },

                        controller: nameController,
                      ),
                      const SizedBox(width: 15),
                      CustomTextFormField(
                        hintText: 'governorate_name'.tr(),
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_mobile_number'.tr();
                          }
                          return null;
                        },
                        controller: governorateNameController,
                      ),

                      const SizedBox(width: 15),
                      if (patternID == null)
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'branch'.tr(),
                                    style: GoogleFonts.almarai(
                                      color: Colors.black,
                                      fontSize: getFontSize(context, 14),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width,

                                    child: BlocBuilder<
                                      InvoiceCollectionCubit,
                                      InvoiceCollectionState
                                    >(
                                      builder: (context, state) {
                                        InvoiceCollectionCubit itemBloc2 =
                                            BlocProvider.of<
                                              InvoiceCollectionCubit
                                            >(context);

                                        return DropdownSearch<
                                          Map<dynamic, dynamic>
                                        >(
                                          items:
                                              itemBloc2.allCompanyBranchesList0,
                                          popupProps: const PopupProps.menu(
                                            showSelectedItems: false,
                                            showSearchBox: true,
                                          ),
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8.0,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                              width: 2,
                                                            ),
                                                      ),
                                                      hintText:
                                                          "select_branch".tr(),
                                                      hintStyle:
                                                          const TextStyle(
                                                            color: Color(
                                                              0xff333333,
                                                            ),
                                                            fontFamily:
                                                                'Raleway',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                              ),
                                          onChanged: (
                                            Map<dynamic, dynamic>? selectedItem,
                                          ) {
                                            if (selectedItem != null) {
                                              final branchId =
                                                  selectedItem["ID"];
                                              itemBloc2.updateBranchId(
                                                newData: branchId,
                                              );
                                              itemBloc2
                                                  .getInvoiceSettingByBranchID(
                                                    branchId: branchId,
                                                  );
                                              BlocProvider.of<SearchCubit>(
                                                context,
                                              ).updateBranchId(
                                                newData: branchId,
                                              );
                                            }
                                          },
                                          selectedItem: null,
                                          itemAsString:
                                              (Map<dynamic, dynamic>? item) =>
                                                  item?['BraName'] ?? '',
                                          dropdownBuilder: (
                                            context,
                                            Map<dynamic, dynamic>? selectedItem,
                                          ) {
                                            String branchName =
                                                "select_branch"
                                                    .tr(); // Default value
                                            if (selectedItem != null) {
                                              branchName =
                                                  currentLanguageCode == 'ar'
                                                      ? selectedItem['BraName'] ??
                                                          branchName
                                                      : selectedItem['BranchEName'] ??
                                                          branchName;
                                            }
                                            return Text(
                                              branchName,
                                              style: GoogleFonts.almarai(
                                                color: const Color(0xff333333),
                                                fontSize: getFontSize(
                                                  context,
                                                  16,
                                                ),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            );
                                          },
                                          clearButtonProps:
                                              const ClearButtonProps(
                                                isVisible: true,
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            5.verticalSpace,
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'pattern'.tr(),
                                    style: GoogleFonts.almarai(
                                      color: Colors.black,
                                      fontSize: getFontSize(context, 16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width,

                                    child: BlocBuilder<
                                      InvoiceCollectionCubit,
                                      InvoiceCollectionState
                                    >(
                                      builder: (context, state) {
                                        InvoiceCollectionCubit itemBloc2 =
                                            BlocProvider.of<
                                              InvoiceCollectionCubit
                                            >(context);

                                        return DropdownSearch<
                                          Map<dynamic, dynamic>
                                        >(
                                          items:
                                              itemBloc2
                                                  .allInvoiceSettingByBranchIDList,
                                          popupProps: const PopupProps.menu(
                                            showSelectedItems: false,
                                            showSearchBox: true,
                                          ),
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8.0,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                              width: 2,
                                                            ),
                                                      ),
                                                      hintText: "اختر النمط",
                                                      hintStyle:
                                                          const TextStyle(
                                                            color: Color(
                                                              0xff333333,
                                                            ),
                                                            fontFamily:
                                                                'Raleway',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                              ),
                                          onChanged: (
                                            Map<dynamic, dynamic>? selectedItem,
                                          ) {
                                            if (selectedItem != null) {
                                              BlocProvider.of<SearchCubit>(
                                                context,
                                              ).updatePatternID(
                                                newDataId:
                                                    selectedItem['PatternID'],
                                              );

                                              print(
                                                BlocProvider.of<SearchCubit>(
                                                  context,
                                                ).patternID,
                                              );
                                            }
                                          },
                                          selectedItem: null,
                                          itemAsString:
                                              (Map<dynamic, dynamic>? item) =>
                                                  item?['PatternName'] ?? '',
                                          dropdownBuilder: (
                                            context,
                                            Map<dynamic, dynamic>? selectedItem,
                                          ) {
                                            return Text(
                                              selectedItem?['PatternName'] ??
                                                  "النمط",
                                              style: GoogleFonts.almarai(
                                                color: const Color(0xff333333),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            );
                                          },
                                          clearButtonProps:
                                              const ClearButtonProps(
                                                isVisible: true,
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      CustomTextFormField(
                        hintText: 'place_name'.tr(),
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_mobile_number'.tr();
                          }
                          return null;
                        },
                        controller: placeNameController,
                      ),
                      const SizedBox(width: 15),
                      CustomTextFormField(
                        hintText: 'section'.tr(),
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_mobile_number'.tr();
                          }
                          return null;
                        },
                        controller: sectionController,
                      ),
                      const SizedBox(width: 15),
                      CustomTextFormField(
                        hintText: 'phone1'.tr(),
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_mobile_number'.tr();
                          }
                          return null;
                        },
                        controller: mobileController,
                      ),

                      const SizedBox(width: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CustomTextFormField(
                              hintText: 'jada'.tr(),
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_gada'.tr();
                                }
                                return null;
                              },
                              controller: gadaController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: CustomTextFormField(
                              hintText: 'street'.tr(),
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_street'.tr();
                                }
                                return null;
                              },
                              controller: streetController,
                            ),
                          ),
                          const SizedBox(width: 10), // إضافة مسافة بين العناصر
                          Flexible(
                            child: CustomTextFormField(
                              hintText: 'house'.tr(),
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_house'.tr();
                                }
                                return null;
                              },
                              controller: houseController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: CustomTextFormField(
                              hintText: 'district'.tr(),
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_floor'.tr();
                                }
                                return null;
                              },
                              controller: districtController,
                            ),
                          ),
                        ],
                      ),
                      50.verticalSpace,

                      BlocConsumer<SearchCubit, SearchViewState>(
                        listener: (context, state) {
                          if (state is AddAccountSuccess) {
                            if (state.dataState?.contains(
                                  "No Account were Found",
                                ) ??
                                false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'account_not_added_try_again'.tr(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            } else {
                              Navigator.pop(context, value);
                            }
                          }
                        },
                        builder: (context, state) {
                          return ConditionalBuilder(
                            condition: state is! AddAccountLoading,
                            fallback:
                                (context) => SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset(
                                    'assets/images/loading.json',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            builder:
                                (context) => DefaultButton(
                                  showIcon: false,
                                  text: 'add_customer'.tr(),
                                  function: () {
                                    BlocProvider.of<SearchCubit>(
                                      context,
                                    ).addAccount(
                                      accountName: nameController.text,
                                      governorateName:
                                          governorateNameController.text,
                                      placeName: placeNameController.text,
                                      section: sectionController.text,
                                      house: houseController.text,
                                      street: streetController.text,
                                      district: districtController.text,
                                      gada: gadaController.text,
                                      mobile: mobileController.text,
                                      patternID:
                                          patternID ??
                                          BlocProvider.of<SearchCubit>(
                                            context,
                                          ).patternID,
                                    );
                                  },
                                  backgroundColor: const Color(0xff2269A6),
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
