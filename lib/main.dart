import 'dart:ui';

import 'package:assinador_invia/firebase_options.dart';
import 'package:assinador_invia/notifications/services/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page/views/phone/pages/pages.dart';
import 'home_page/views/tablet/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterLocalNotifications().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          scrollBehavior: const ScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(
              parent: FixedExtentScrollPhysics(),
            ),
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.nunito(
                fontSize: 22.sp,
                color: Colors.white,
              ),
              centerTitle: true,
              scrolledUnderElevation: 0.0,
              toolbarHeight: 50.h,
              systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.blueAccent,
                systemNavigationBarIconBrightness: Brightness.light,
                systemNavigationBarDividerColor: Colors.transparent,
                statusBarColor: Colors.blueAccent,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
              ),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              actionsIconTheme: IconThemeData(
                size: 22.sp,
                color: Colors.white,
              ),
              iconTheme: IconThemeData(
                size: 22.sp,
                color: Colors.white,
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
            textTheme: TextTheme(
              bodyLarge: GoogleFonts.nunito(
                fontSize: 22.sp,
                color: Colors.black,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: GoogleFonts.nunito(
                fontSize: 22.sp,
                color: Colors.black,
              ),
              fillColor: Colors.white,
              filled: true,
              labelStyle: GoogleFonts.nunito(
                fontSize: 22.sp,
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  width: 1.r,
                  color: Colors.black.withOpacity(
                    .75,
                  ),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  width: 1.r,
                  color: Colors.black.withOpacity(
                    .75,
                  ),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  width: 1.r,
                  color: Colors.redAccent.withOpacity(
                    .75,
                  ),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  width: 1.r,
                  color: Colors.redAccent.withOpacity(
                    .75,
                  ),
                ),
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              iconSize: 24.sp,
              foregroundColor: Colors.white,
              backgroundColor: Colors.redAccent,
              sizeConstraints: BoxConstraints(minHeight: 50.h, minWidth: 50.w),
              shape: CircleBorder(),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.blueAccent,
              unselectedItemColor: Colors.white.withOpacity(.65),
              unselectedLabelStyle: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.white.withOpacity(.85),
              ),
              selectedIconTheme: IconThemeData(
                color: Colors.white,
                size: 20.sp,
              ),
              selectedLabelStyle: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20.sp,
              ),
              selectedItemColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                textStyle: GoogleFonts.nunito(
                  fontSize: 18.sp,
                ),
                fixedSize: Size.fromHeight(40.h),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                textStyle: GoogleFonts.nunito(
                  fontSize: 22.sp,
                ),
              ),
            ),
          ),
          home: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth >= 768) {
              return const MyHomePageTablet();
            } else {
              return const MyHomePage();
            }
          }),
        );
      },
    );
  }
}
