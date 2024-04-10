import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_1_contact_app/data/local_data/database_service.dart';

import 'package:flutter_bloc_task_1_contact_app/presentation/cubit/contact_cubit.dart';
import 'package:flutter_bloc_task_1_contact_app/presentation/screens/contacts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactCubit>(
          create: (context) => ContactCubit(DatabaseService()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ContactScreen(),
      ),
    );
  }
}
