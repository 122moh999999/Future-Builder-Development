
// import 'package:get_it/get_it.dart';
// import 'package:odoo_hr/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:odoo_hr/features/home/presentation/cubit/home_cubit.dart';
// import 'package:odoo_hr/features/notifications/data/repo/notifications_repository.dart';
// import 'package:odoo_hr/features/requests/presentation/cubit/requests_cubit.dart';
// import 'package:odoo_hr/features/salary/presentation/cubit/salary_cubit.dart';

// final locator = GetIt.instance;

// void initDependencyInjection(){
//   // AuthCubit
//   locator.registerLazySingleton<AuthCubit>(() => AuthCubit());
//   // SalaryCubit
//   locator.registerLazySingleton<SalaryCubit>(() => SalaryCubit());
//   // RequestsCubit
//   locator.registerLazySingleton<RequestsCubit>(() => RequestsCubit());
  
//   // HomeCubit
//   locator.registerLazySingleton<HomeCubit>(() => HomeCubit());

//   // Notification Repo
//   locator.registerLazySingleton<NotificationsRepositoryImpl>(()=>NotificationsRepositoryImpl());

// }