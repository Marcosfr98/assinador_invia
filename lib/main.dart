import 'dart:ui';

import 'package:assinador_invia/firebase_options.dart';
import 'package:assinador_invia/my_home_page/controllers/controllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_home_page/views/pages/pages.dart';

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
  MyHomePageController _myHomePageController = MyHomePageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return AnimatedBuilder(
            animation: _myHomePageController,
            builder: (context, child) {
              return GetMaterialApp(
                scrollBehavior: const ScrollBehavior().copyWith(
                  physics: const BouncingScrollPhysics(
                    parent: FixedExtentScrollPhysics(),
                  ),
                ),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Color(0xFFEFEFEF),
                  tabBarTheme: TabBarTheme(
                    indicatorColor: Colors.blueAccent,
                    labelColor: Colors.blueAccent,
                    unselectedLabelColor: Colors.blueAccent.withOpacity(.65),
                  ),
                  listTileTheme: ListTileThemeData(
                    titleTextStyle: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    subtitleTextStyle: GoogleFonts.nunito(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  appBarTheme: AppBarTheme(
                    titleTextStyle: GoogleFonts.nunito(
                      fontSize: 22.sp,
                      color: Colors.black,
                    ),
                    centerTitle: true,
                    scrolledUnderElevation: 0.0,
                    toolbarHeight: 60.h,
                    systemOverlayStyle: !_myHomePageController.isFabOpened
                        ? null
                        : const SystemUiOverlayStyle(
                            systemNavigationBarColor: Colors.transparent,
                            systemNavigationBarIconBrightness: Brightness.dark,
                            systemNavigationBarDividerColor: Colors.transparent,
                            statusBarColor: Colors.white,
                            statusBarBrightness: Brightness.dark,
                            statusBarIconBrightness: Brightness.dark,
                          ),
                    foregroundColor: Color(0xFFEFEFEF),
                    backgroundColor: Colors.white,
                    actionsIconTheme: IconThemeData(
                      size: 22.sp,
                      color: Colors.black54,
                    ),
                    iconTheme: IconThemeData(
                      size: 22.sp,
                      color: Colors.black54,
                    ),
                  ),
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.blueAccent),
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
                        color: Colors.blueAccent.withOpacity(
                          .75,
                        ),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        width: 1.r,
                        color: Colors.blueAccent.withOpacity(
                          .75,
                        ),
                      ),
                    ),
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    iconSize: 24.sp,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    sizeConstraints:
                        BoxConstraints(minHeight: 50.h, minWidth: 50.w),
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
                home: MyHomePage(),
              );
            });
      },
    );
  }
}
