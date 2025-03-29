import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pager/pager.dart';
import 'package:vnptapp/Components/Custom_AppBar.dart';
import 'package:vnptapp/Components/Custom_Card.dart';
import 'package:vnptapp/Components/Custom_Data_Rows.dart';
import 'package:vnptapp/Components/Custom_DropdownDonVi.dart';
import 'package:vnptapp/Components/Custom_FutureBuilder.dart';
import 'package:vnptapp/Components/Custom_MonthYearPicker.dart';
import 'package:vnptapp/Components/LoadingScreen.dart';
import 'package:vnptapp/GlobalFunction/InternetChecker.dart';
import 'package:vnptapp/Models/NhanVien.dart';
import 'package:vnptapp/Variable/Riverpod_Instance.dart';
import 'package:vnptapp/screen/Drawer/ThongKeBaoCao/ThuLaoBanTheNapThe/Logic.dart';
import 'package:vnptapp/screen/Drawer/ThongKeBaoCao/ThuLaoBanTheNapThe/Variable.dart';

class ThuLaoBanTheNapThe_MainPage extends StatefulWidget {
  const ThuLaoBanTheNapThe_MainPage({super.key});

  @override
  State<ThuLaoBanTheNapThe_MainPage> createState() =>
      _ThuLaoBanTheNapThe_MainPageState();
}

class _ThuLaoBanTheNapThe_MainPageState
    extends State<ThuLaoBanTheNapThe_MainPage> {
  Future<void> refresh() async {
    setState(() {});
  }

  TextEditingController searchkey = new TextEditingController();
  @override
  void initState() {
    super.initState();
    searchkey.text = "";
  }

  int pageNumber = 1;
  int pageSized = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Custom_AppBar(title: 'Thù lao bán thẻ nạp thẻ/nạp thẻ'),
        body: Padding(
          padding: EdgeInsets.only(right: 8, left: 8),
          child: RefreshIndicator(
              onRefresh: refresh,
              child: Consumer(builder: (context, watch, child) {
                var selectedDV =
                    watch.watch(riverpod_instance.selectedIdDonVi11Pbh);
                var selectedMonth =
                    watch.watch(riverpod_instance.selectedMonthMonthYearPicker);
                var selectedYear =
                    watch.watch(riverpod_instance.selectedYearMonthYearPicker);
                return SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      localNhanVien.nhanvien_donvi == 13 ||
                              localNhanVien.nhanvien_donvi == 2 ||
                              localNhanVien.nhanvien_chucdanh == 1 ||
                              localNhanVien.nhanvien_chucdanh == 2 ||
                              localNhanVien.nhanvien_chucdanh == 3 ||
                              localNhanVien.nhanvien_chucdanh == 4
                          ? Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: searchkey,
                                        decoration: const InputDecoration(
                                          hintText: 'Tìm kiếm(theo tên NV)',
                                          label: Text('Tìm kiếm(theo tên NV)'),
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(19.0)),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          setState(() {
                                            searchkey.text = text;
                                          });
                                        },
                                      ),
                                    )),
                              ],
                            )
                          : const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Custom_DropdownDonViTheoId11Pbh(
                              nhanvienDonVi: localNhanVien.nhanvien_donvi!),
                          Flexible(child: Custom_MonthYearPicker()),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: checkLocalConnectionApi(),
                          builder: ((context, snapshot) {
                            if (snapshot.data != null &&
                                snapshot.connectionState !=
                                    ConnectionState.waiting) {
                              return FutureBuilder(
                                  future: getListLuongBanNapThe(
                                      pageNumber,
                                      pageSized,
                                      selectedYear.toString() +
                                          selectedMonth.toString(),
                                      localNhanVien.nhanvien_smcs,
                                      selectedDV,
                                      localNhanVien.nhanvien_chucdanh,
                                      localNhanVien.nhanvien_donvi,
                                      searchkey.text,
                                      snapshot.data!),
                                  builder: ((context, snapshot1) {
                                    return Custom_FutureBuilder(
                                        snapshot: snapshot1,
                                        contextParam: context,
                                        widgetParam: snapshot1.hasData
                                            ? SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    for (var item
                                                        in snapshot1.data!)
                                                      Custom_Card(
                                                          item: item,
                                                          list: snapshot1.data,
                                                          widget: Column(
                                                            children: [
                                                              Detail_Rows(
                                                                title:
                                                                    'Đơn vị :',
                                                                data: item
                                                                    .donViTen
                                                                    .toString(),
                                                              ),
                                                              Detail_Rows(
                                                                title:
                                                                    'Địa bàn bán thẻ :',
                                                                data: item
                                                                    .diabanBanthe
                                                                    .toString(),
                                                              ),
                                                              Detail_Rows(
                                                                title:
                                                                    'Mã nhân viên :',
                                                                data: item
                                                                    .maNhanvien,
                                                              ),
                                                              Detail_Rows(
                                                                title:
                                                                    'Tên nhân viên :',
                                                                data: item
                                                                    .nhanvienBanthe,
                                                              ),
                                                              Detail_Rows(
                                                                title:
                                                                    'Bán thẻ :',
                                                                data: item
                                                                    .banThe
                                                                    .toString(),
                                                              ),
                                                              Detail_Rows(
                                                                title:
                                                                    'Nạp thẻ :',
                                                                data: item
                                                                    .napThe
                                                                    .toString(),
                                                              ),
                                                              Detail_Rows(
                                                                title: 'Tổng :',
                                                                data: item.tong
                                                                    .toString(),
                                                              ),
                                                            ],
                                                          )),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                          '$pageNumber/${ThuLaoBanTheNapThe_Variable.totalPages} trang, ${ThuLaoBanTheNapThe_Variable.totalRecord} mục'),
                                                    ),
                                                    ThuLaoBanTheNapThe_Variable
                                                                .totalPages !=
                                                            0
                                                        ? SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Pager(
                                                              currentPage:
                                                                  pageNumber,
                                                              totalPages:
                                                                  ThuLaoBanTheNapThe_Variable
                                                                      .totalPages,
                                                              onPageChanged:
                                                                  (page) {
                                                                setState(() {
                                                                  pageNumber =
                                                                      page;
                                                                });
                                                              },
                                                            ),
                                                          )
                                                        : const Text(''),
                                                  ],
                                                ),
                                              )
                                            : const Text(
                                                "Lỗi xác thực vui lòng đăng nhập lại"));
                                  }));
                            } else {
                              return LoadingScreen(
                                  nameOfLoadingScreen: "Đang kiểm tra mạng...");
                            }
                          })),

                      // FutureBuilder(
                      //     future: checkLocalConnectionApi().then((value) =>
                      //         getListLuongBanNapThe(
                      //             pageNumber,
                      //             pageSized,
                      //             selectedYear.toString(),
                      //             selectedMonth.toString(),
                      //             localNhanVien.nhanvien_smcs,
                      //             selectedDV,
                      //             localNhanVien.nhanvien_chucdanh,
                      //             localNhanVien.nhanvien_donvi,
                      //             searchkey,
                      //             value)),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.data != null &&
                      //           snapshot.connectionState !=
                      //               ConnectionState.waiting) {
                      //         return Custom_FutureBuilder(
                      //             contextParam: context,
                      //             snapshot: snapshot,
                      //             widgetParam: snapshot.hasData
                      //                 ? SingleChildScrollView(
                      //                     child: Column(
                      //                       children: [
                      //                         for (var item in snapshot.data!)
                      //                           Custom_Card(
                      //                               item: item,
                      //                               list: snapshot.data,
                      //                               widget: Column(
                      //                                 children: [
                      //                                   Detail_Rows(
                      //                                     title: 'Đơn vị :',
                      //                                     data: item.donViTen
                      //                                         .toString(),
                      //                                   ),
                      //                                   Detail_Rows(
                      //                                     title:
                      //                                         'Địa bàn bán thẻ :',
                      //                                     data: item
                      //                                         .diabanBanthe
                      //                                         .toString(),
                      //                                   ),
                      //                                   Detail_Rows(
                      //                                     title:
                      //                                         'Mã nhân viên :',
                      //                                     data: item.maNhanvien,
                      //                                   ),
                      //                                   Detail_Rows(
                      //                                     title:
                      //                                         'Tên nhân viên :',
                      //                                     data: item
                      //                                         .nhanvienBanthe,
                      //                                   ),
                      //                                   Detail_Rows(
                      //                                     title: 'Bán thẻ :',
                      //                                     data: item.banThe
                      //                                         .toString(),
                      //                                   ),
                      //                                   Detail_Rows(
                      //                                     title: 'Nạp thẻ :',
                      //                                     data: item.napThe
                      //                                         .toString(),
                      //                                   ),
                      //                                   Detail_Rows(
                      //                                     title: 'Tổng :',
                      //                                     data: item.tong
                      //                                         .toString(),
                      //                                   ),
                      //                                 ],
                      //                               )),
                      //                         Align(
                      //                           alignment: Alignment.topLeft,
                      //                           child: Text(
                      //                               '$pageNumber/${ThuLaoBanTheNapThe_Variable.totalPages} trang, ${ThuLaoBanTheNapThe_Variable.totalRecord} mục'),
                      //                         ),
                      //                         ThuLaoBanTheNapThe_Variable
                      //                                     .totalPages !=
                      //                                 0
                      //                             ? SingleChildScrollView(
                      //                                 scrollDirection:
                      //                                     Axis.horizontal,
                      //                                 child: Pager(
                      //                                   currentPage: pageNumber,
                      //                                   totalPages:
                      //                                       ThuLaoBanTheNapThe_Variable
                      //                                           .totalPages,
                      //                                   onPageChanged: (page) {
                      //                                     setState(() {
                      //                                       pageNumber = page;
                      //                                     });
                      //                                   },
                      //                                 ),
                      //                               )
                      //                             : const Text(''),
                      //                       ],
                      //                     ),
                      //                   )
                      //                 : const Text(''));
                      //       } else {
                      //         return LoadingScreen(
                      //             nameOfLoadingScreen: 'Đang kiểm tra mạng...');
                      //       }
                      //     })
                    ],
                  ),
                ));
              })),
        ));
  }
}
