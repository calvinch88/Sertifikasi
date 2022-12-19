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
            HStack{
                Text("buku yang dipinjam : ")
                    .bold()
                Text(admin.nama_buku ?? "")
            }
            Image(uiImage: admin.gambar_buku ?? UIImage())
                .resizable()
                .frame(width: 250, height: 400)
            Text("tanggal pinjam : \(tanggalPinjam.formatted(date: .long, time: .omitted))")
            Text("tanggal kembali : \(tanggalKembali.formatted(date: .long, time: .omitted))")
            Button("pinjam") {
                pengolah.pinjamBuku(admin: admin)
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
