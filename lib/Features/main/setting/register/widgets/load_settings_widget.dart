import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:theonepos/Corec/apis/dioHelper.dart';
import 'package:theonepos/Corec/utils/widget/default_button.dart';
import 'package:theonepos/Features/main/setting/register/manager/register_cubit.dart';
import 'package:theonepos/Features/main/setting/register/manager/register_state.dart';

class LoadSettingsWidget extends StatelessWidget {
  const LoadSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterViewState>(
      builder: (context, state) {
        RegisterCubit blocCubit = BlocProvider.of<RegisterCubit>(context);

        return ConditionalBuilder(
          condition: state is! GetNameDataBaseLoadingState,
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
                showIcon: true,
                text: 'Load Settings'.tr(),
                function: () {
                  DioHelper.init();
                  blocCubit.getNameDataBase(
                    serverName: blocCubit.controllerIpAddress.text,
                    userName: blocCubit.userNameController.text,
                    userPassword: blocCubit.passwordController.text,
                  );
                },
                backgroundColor: const Color(0xff2269A6),
              ),
        );
      },
    );
  }
}
