import 'package:flutter_bloc/flutter_bloc.dart';

import 'Logic/Location/location_cubit.dart';

class StateInjector {
  static final blocProviders = <BlocProvider>[
    BlocProvider<LocationCubit>(
      create: (context) => LocationCubit(),
    ),
  ];
}
