import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/theme/theme_cubit.dart';
import 'package:the_movies/utils/modified_text.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: context.read<ThemeCubit>().toggleTheme,
        child: const ModifiedText(
          text: 'Theme switcher',
          size: 24,
        ));
  }
}
