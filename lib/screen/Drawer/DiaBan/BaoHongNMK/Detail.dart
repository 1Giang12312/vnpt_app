import 'package:flutter/material.dart';
import 'package:vnptapp/Components/Custom_AppBar.dart';
import 'package:vnptapp/Components/Custom_Data_Rows.dart';
import 'package:vnptapp/Components/Custom_Data_Rows_Color.dart';
import 'package:vnptapp/Components/Custom_FutureBuilder.dart';
import 'package:vnptapp/Models/NhanVien.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/BaoHongNMK/Logic.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/BaoHongNMK/Model.dart';

class BaoHongNMK_Detail extends StatefulWidget {
  BaoHongNMK_Detail(
      {super.key,
      //required this.bh
      required this.bHID,
      required this.soTB,
      required this.subUrlApi});
  //BaoHongNMK bh;
  int bHID;
  String subUrlApi;
  String soTB;
  @override
  State<BaoHongNMK_Detail> createState() => _BaoHongNMK_DetailState();
}

class _BaoHongNMK_DetailState extends State<BaoHongNMK_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Custom_AppBar(
          title: 'Chi tiết TB ${widget.soTB}',
        ),
        body: FutureBuilder(
            future: detailBaoHongNMK(
                widget.bHID,
                localNhanVien.nhanvien_chucdanh!,
                widget.subUrlApi,
                nhanvien_DonVi_MoTa,
                localNhanVien.nhanvien_manv_thns),
            builder: (context, snapshot) {
              return Custom_FutureBuilder(
                  snapshot: snapshot,
                  contextParam: context,
                  widgetParam: snapshot.hasData
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              // Detail_Rows(title: 'Thời gian', data: bh.datETime),
                              // Detail_Rows(title: 'Thuê bao', data: bh.accSMthdKey),
                              // Detail_Rows(title: 'Loại TB', data: bh.loaITb),
                              // Detail_Rows(title: 'Thời gian BD', data: bh.thoigiaNBd),
                              // Detail_Rows(title: 'Thời gian KT', data: bh.thoigiaNKt),
                              // Detail_Rows(title: 'Tổng thời gian', data: bh.tonGTg),
                              // Detail_Rows(title: 'Số tổng đài', data: bh.sOTongdai),
                              // Detail_Rows(title: 'Nhà mạng', data: bh.nhAMang),
                              // Detail_Rows(title: 'Họ tên', data: bh.hOTen),
                              // Detail_Rows(title: 'Địa chỉ', data: bh.diAChi),
                              // Detail_Rows(title: 'Mã tỉnh', data: bh.mATinh),
                              Custom_Data_Rows_Color(
                                indexCount: true,
                                widget: Detail_Rows(
                                    title: 'Thời gian: ',
                                    data: snapshot.data!.datETime),
                              ),
                              Custom_Data_Rows_Color(
                                  indexCount: false,
                                  widget: Detail_Rows(
                                      title: 'PBH: ',
                                      data: snapshot.data!.reselleRName)),
                              Custom_Data_Rows_Color(
                                  indexCount: true,
                                  widget: Detail_Rows(
                                      title: 'Tên KV C3: ',
                                      data: snapshot.data!.tenKv)),
                              Custom_Data_Rows_Color(
                                  indexCount: false,
                                  widget: Detail_Rows(
                                      title: 'Thuê bao: ',
                                      data: snapshot.data!.accSMthdKey)),
                              Custom_Data_Rows_Color(
                                  indexCount: true,
                                  widget: Detail_Rows(
                                      title: 'Loại thuê bao: ',
                                      data: snapshot.data!.loaITb)),
                              Custom_Data_Rows_Color(
                                  indexCount: false,
                                  widget: Detail_Rows(
                                      title: 'Thời gian BD: ',
                                      data: snapshot.data!.thoigiaNBd)),

                              Custom_Data_Rows_Color(
                                  indexCount: true,
                                  widget: Detail_Rows(
                                      title: 'Thời gian KT: ',
                                      data: snapshot.data!.thoigiaNKt)),
                              // Custom_Data_Rows_Color(
                              //     indexCount: true,
                              //     widget:
                              //         Detail_Rows(title: 'Tổng thời gian: ', data: bh.tonGTg)),
                              // Custom_Data_Rows_Color(
                              //     indexCount: false,
                              //     widget: Detail_Rows(
                              //       title: 'Số tổng đài: ',
                              //       data: bh.sOTongdai,
                              //     )),
                              Custom_Data_Rows_Color(
                                  indexCount: false,
                                  widget: Detail_Rows(
                                    title: 'Nhà mạng: ',
                                    data: snapshot.data!.nhAMang,
                                  )),
                              // Custom_Data_Rows_Color(
                              //     indexCount: false,
                              //     widget: Detail_Rows(title: 'Địa chỉ: ', data: bh.diAChi)),
                              // Custom_Data_Rows_Color(
                              //     indexCount: true,
                              //     widget: Detail_Rows(title: 'Họ tên: ', data: bh.hOTen)),
                              // Custom_Data_Rows_Color(
                              //     indexCount: false,
                              //     widget: Detail_Rows(title: 'Mã tỉnh: ', data: bh.mATinh)),
                              Custom_Data_Rows_Color(
                                  indexCount: true,
                                  widget: Detail_Rows(
                                      title: 'Tên trạm BTS: ',
                                      data: snapshot.data!.btSName)),
                              Custom_Data_Rows_Color(
                                  indexCount: false,
                                  widget: Detail_Rows(
                                      title: 'Mã chương trình: ',
                                      data: snapshot.data!.mAChuongTrinh)),
                              Custom_Data_Rows_Color(
                                  indexCount: true,
                                  widget: Detail_Rows(
                                      title: 'Trạng thái OB: ',
                                      data: snapshot.data!.trangThaiOb)),
                              Custom_Data_Rows_Color(
                                  indexCount: false,
                                  widget: Detail_Rows(
                                      title: 'Tên nhân viên OB: ',
                                      data: snapshot.data!.tenNvOb)),
                              Custom_Data_Rows_Color(
                                  indexCount: true,
                                  widget: Detail_Rows(
                                      title: 'Mã nhân viên OB: ',
                                      data: snapshot.data!.maNvOb)),
                              Custom_Data_Rows_Color(
                                  indexCount: false,
                                  widget: Detail_Rows(
                                      title: 'Ngày cập nhật trạng thái OB: ',
                                      data: snapshot
                                          .data!.ngayCapNhatTrangThaiOB)),
                            ],
                          ),
                        )
                      : const Text("Lỗi không xác định khi xác thực"));
            }));
  }
}
