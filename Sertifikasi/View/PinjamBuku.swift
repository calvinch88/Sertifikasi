//
//  PinjamBuku.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 18/12/22.
//

import SwiftUI

struct PinjamBuku: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let pengolah: PengolahDatabasePerpustakaan
    @State private var tanggalPinjam = Date.now
    @State private var tanggalKembali = Date(timeIntervalSinceNow: 604800)
    @State private var tersedia: Bool = false
    @Binding var refresh: Bool
    let admin: Admin
    
    var body: some View {
        VStack {
            Text("buku yang dipinjam")
                .bold()
            HStack{
                Text(admin.nama_buku ?? "")
            }
            Text("tanggal pinjam : \(tanggalPinjam.formatted(date: .long, time: .omitted))")
            Text("tanggal kembali : \(tanggalKembali.formatted(date: .long, time: .omitted))")
            Button("pinjam") {
                pengolah.pinjamBuku(idbuku: admin.id_buku ?? "", namaBuku: admin.nama_buku ?? "", tanggalPinjam: tanggalPinjam, tanggalKembali: tanggalKembali, tersedia: tersedia)
                refresh.toggle()
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

//struct PinjamBuku_Previews: PreviewProvider {
//    static var previews: some View {
//        PinjamBuku()
//    }
//}
