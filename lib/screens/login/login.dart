import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../register/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 285.0,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/banner-login.jpg",
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 31),
                              child: Column(
                                children: [
                                  Text(
                                    "Welcome",
                                    style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 214, 74, 22)),
                                  ),
                                  Text(
                                    "Đăng nhập để tiếp tục...",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: const Color.fromARGB(
                                            255, 214, 74, 22)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      top: 255,
                      child: Container(
                        height: 600,
                        width: 375,
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 35),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Nhập tên tài khoản',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xff8B9E9E)),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Nhập mật khẩu',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xff8B9E9E)),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 44.0,
                            ),
                            Container(
                              height: 20.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 31.0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 325,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFFB039),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(50), // <-- Radius
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Đăng nhập",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Bạn chưa có tài khoản?",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xffFF8933),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Đăng ký ngay!",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: const Color.fromARGB(
                                            255, 121, 121, 121),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 80.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 20.0,
                                width: 219,
                                decoration: const BoxDecoration(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
