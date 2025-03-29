import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pager/pager.dart';
import 'package:vnptapp/Components/Custom_AppBar.dart';
import 'package:vnptapp/Components/Custom_Card.dart';
import 'package:vnptapp/Components/Custom_Data_Rows.dart';
import 'package:vnptapp/Components/Custom_DropdownDonVi.dart';
import 'package:vnptapp/Components/Custom_FutureBuilder.dart';
import 'package:vnptapp/Components/Custom_MonthYearPicker.dart';
import 'package:vnptapp/Components/Custom_Page_Transition.dart';
import 'package:vnptapp/Components/Custom_Text.dart';
import 'package:vnptapp/Components/LoadingScreen.dart';
import 'package:vnptapp/GlobalFunction/InternetChecker.dart';
import 'package:vnptapp/Models/NhanVien.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/BaoHongNMK/Constant.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/BaoHongNMK/Detail.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/BaoHongNMK/Logic.dart';
import 'package:vnptapp/Variable/Riverpod_Instance.dart';

class BaoHongNMK_MainPage extends StatefulWidget {
  const BaoHongNMK_MainPage({super.key});

  @override
  State<BaoHongNMK_MainPage> createState() => _BaoHongNMK_MainPageState();
}

int pageNumber = 1;
int pageSize = 10;
var keyword;

class _BaoHongNMK_MainPageState extends State<BaoHongNMK_MainPage> {
  Future<void> refresh() async {
    setState(() {});
  }

  TextEditingController searchkey = TextEditingController();

  DateTime ngayBatDau = DateTime.now().toLocal().subtract(Duration(
        hours: DateTime.now().hour,
        minutes: DateTime.now().minute,
        seconds: DateTime.now().second,
        milliseconds: DateTime.now().millisecond,
        microseconds: DateTime.now().microsecond,
      ));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Custom_AppBar(title: 'Báo hỏng nhà mạng khác'),
        body: RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                localNhanVien.nhanvien_donvi == 13 ||
                        localNhanVien.nhanvien_donvi == 2 ||
                        localNhanVien.nhanvien_chucdanh == 1 ||
                        localNhanVien.nhanvien_chucdanh == 2 ||
                        localNhanVien.nhanvien_chucdanh == 3 ||
                        localNhanVien.nhanvien_chucdanh == 4
                    ? SizedBox(
                        height: 50,
                        child: TextField(
                          controller: searchkey,
                          decoration: const InputDecoration(
                            hintText: 'Tìm kiếm(theo số thuê bao)',
                            label: Text('Tìm kiếm(theo số thuê bao)'),
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(19.0)),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              searchkey.text = text;
                            });
                          },
                        ),
                      )
                    : const SizedBox(),
                Consumer(builder: ((context, ref, child) {
                  var selectedDV =
                      ref.watch(riverpod_instance.selectedTenMoTa11Pbh);
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: FutureBuilder(
                        future: checkLocalConnectionApi(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null &&
                              snapshot.connectionState !=
                                  ConnectionState.waiting) {
                            return FutureBuilder(
                                future: listBaoHongNMK(
                                    pageNumber,
                                    pageSize,
                                    ngayBatDau,
                                    localNhanVien.nhanvien_manv_thns,
                                    searchkey.text,
                                    localNhanVien.nhanvien_chucdanh!,
                                    snapshot.data!,
                                    nhanvien_DonVi_MoTa,
                                    selectedDV),
                                builder: ((context, snapshot1) {
                                  return Custom_FutureBuilder(
                                      snapshot: snapshot1,
                                      contextParam: context,
                                      widgetParam: snapshot1.hasData
                                          ? SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Custom_DropdownDonViTheoTenMoTa11Pbh(
                                                        nhanvienDonVi:
                                                            localNhanVien
                                                                .nhanvien_donvi!,
                                                      ),
                                                      Flexible(
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            final DateTime? picked = await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    ngayBatDau,
                                                                firstDate:
                                                                    DateTime(
                                                                        yearNow -
                                                                            10),
                                                                lastDate:
                                                                    DateTime(
                                                                        yearNow +
                                                                            10),
                                                                locale:
                                                                    const Locale(
                                                                        'vi',
                                                                        'VN'));
                                                            if (picked !=
                                                                    null &&
                                                                picked !=
                                                                    ngayBatDau) {
                                                              setState(() {
                                                                ngayBatDau =
                                                                    picked;
                                                              });
                                                            }
                                                          },
                                                          child: Text(
                                                              'Ngày ${ngayBatDau.day} tháng ${ngayBatDau.month} năm ${ngayBatDau.year}'),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  for (var item
                                                      in snapshot1.data!)
                                                    Custom_Card(
                                                        item: item,
                                                        list: snapshot1.data,
                                                        widget: Column(
                                                          children: [
                                                            Detail_Rows(
                                                                title:
                                                                    'Thời gian : ',
                                                                data: item
                                                                    .datETime),
                                                            // Detail_Rows(
                                                            //     title: 'PBH: ',
                                                            //     data: item
                                                            //         .reselleRName),
                                                            Detail_Rows(
                                                                title:
                                                                    'Tên KV C3: ',
                                                                data:
                                                                    item.tenKv),
                                                            Detail_Rows(
                                                                title:
                                                                    'Thuê bao: ',
                                                                data: item
                                                                    .accSMthdKey),
                                                            Detail_Rows(
                                                                title:
                                                                    'Loại thuê bao: ',
                                                                data: item
                                                                    .loaITb),
                                                            // Detail_Rows(
                                                            //     title:
                                                            //         'Tổng thời gian: ',
                                                            //     data: item
                                                            //         .tonGTg),
                                                            Detail_Rows(
                                                                title:
                                                                    'Nhà mạng: ',
                                                                data: item
                                                                    .nhAMang),
                                                            // Detail_Rows(
                                                            //     title:
                                                            //         'Trạng thái OB: ',
                                                            //     data: item
                                                            //         .trangThaiOb),
                                                            Row(
                                                              children: <Widget>[
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Expanded(
                                                                  flex: 10,
                                                                  child:
                                                                      SizedBox(
                                                                    child: Text_medium_dark(
                                                                        title:
                                                                            "Trạng thái OB: "),
                                                                  ),
                                                                ),
                                                                const Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        SizedBox(
                                                                      width: 1,
                                                                    )),
                                                                Expanded(
                                                                  flex: 9,
                                                                  child:
                                                                      ComboBoxTrangThaiOB(
                                                                    id: item
                                                                        .id!,
                                                                    tenNv: localNhanVien
                                                                        .nhanvien_hoten!,
                                                                    maNv: localNhanVien
                                                                        .nhanvien_manv_thns!,
                                                                    trangthaiOB:
                                                                        item.trangThaiOb!,
                                                                    bContext:
                                                                        context,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            MaterialButton(
                                                              onPressed: () {
                                                                pageTrasition(
                                                                    context,
                                                                    BaoHongNMK_Detail(
                                                                      //bh: item,
                                                                      bHID: item
                                                                          .id!,
                                                                      subUrlApi:
                                                                          snapshot
                                                                              .data!,
                                                                      soTB: item
                                                                          .accSMthdKey!,
                                                                    ));
                                                              },
                                                              child: const Text(
                                                                  'Xem chi tiết'),
                                                            ),
                                                          ],
                                                        )),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        '$pageNumber/${BaoHongNMK_Constant.totalPage} trang , ${BaoHongNMK_Constant.totalItem} mục'),
                                                  ),
                                                  BaoHongNMK_Constant
                                                              .totalPage !=
                                                          0
                                                      ? SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Pager(
                                                            currentPage:
                                                                pageNumber,
                                                            totalPages:
                                                                BaoHongNMK_Constant
                                                                    .totalPage,
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
                                          : const Text(''));
                                }));
                          } else {
                            return LoadingScreen(
                                nameOfLoadingScreen: 'Đang kiểm tra mạng...');
                          }
                        }),
                  );
                }))
              ],
            ))));
  }
}

class ComboBoxTrangThaiOB extends StatefulWidget {
  ComboBoxTrangThaiOB(
      {super.key,
      required this.trangthaiOB,
      required this.bContext,
      required this.id,
      required this.maNv,
      required this.tenNv});
  String trangthaiOB;
  BuildContext bContext;
  int id;
  String maNv;
  String tenNv;
  @override
  State<ComboBoxTrangThaiOB> createState() => _ComboBoxTrangThaiOBState();
}

var selectedValue;
bool checkConnection = true;
String result = "";

class _ComboBoxTrangThaiOBState extends State<ComboBoxTrangThaiOB> {
  @override
  void initState() {
    // TODO: implement initState
    selectedValue = widget.trangthaiOB;
    super.initState();
  }

  @override
  Widget build(bContext) {
    void showSnackbar(BuildContext bc, String? result) async {
      final snackBar = SnackBar(
        content: Text(result!),
        duration: const Duration(seconds: 5), // Thời gian hiển thị Snackbar
        action: SnackBarAction(
          label: 'Đóng',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(bc).showSnackBar(snackBar);
    }

    return DropdownButton<String>(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      value: selectedValue,
      onChanged: (String? value1) async {
        checkConnection = await checkLocalConnectionApi()
            .then((value) => checkConnetionToServer(value));
        checkConnection == true
            ? result = await checkLocalConnectionApi().then((value) =>
                capNhatTrangThaiOB(widget.id, widget.tenNv, widget.maNv,
                    value1 == "Đã OB" ? true : false, value))
            : result = "Không có kết nối";
        checkConnection == true
            ? setState(() {
                selectedValue = value1!;
                showSnackbar(bContext, result);
              })
            : showSnackbar(bContext, result);
        // checkConnection
        //     ? setState(() {
        //         selectedValue = value!;
        //         showSnackbar(bContext, value == "Đã OB" ? true : false);
        //       })
        //     :
      },
      items: <String>['Đã OB', 'Chưa OB'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
