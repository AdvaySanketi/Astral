import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Astral/views/constants.dart';
import 'package:Astral/bloc/home_bloc.dart';
import 'package:Astral/widgets/notification_icon.dart';

class Greet extends StatelessWidget {
  const Greet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Text(
              'Hello ${state.mood}',
              style: greetText,
            );
          },
        ),
        const NotificationIcon()
      ],
    );
  }
}
