import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:quanlyquantrasua/screens/login/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 143.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color(0xff06AB8D),
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/banner-register.jpg",
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 39),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // canh trái
                            children: [
                              Expanded(
                                child: Text(
                                  "Register",
                                  style: GoogleFonts.inter(
                                      fontSize: 28,
                                      color:
                                          const Color.fromARGB(255, 6, 44, 168),
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left, // canh trái
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Nhập đầy đủ thông tin để đăng ký!",
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color:
                                        const Color.fromARGB(255, 6, 44, 168),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.left, // canh trái
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 669,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Họ và tên',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
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
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Địa chỉ Email',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
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
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 30),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Số điện thoại',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
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
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 30),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
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
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 30),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Nhập lại mật khẩu',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
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
                              height: 59.0,
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
                                  "Đăng Ký",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Container(
                              height: 20,
                              width: 167,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
