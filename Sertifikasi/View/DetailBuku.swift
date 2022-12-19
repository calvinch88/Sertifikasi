//
//  DetailBuku.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 17/12/22.
//

import SwiftUI

struct DetailBuku: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let admin: Admin
    @State var user: User = User()
    @State var tanggalKembali: Date? = Date.now
    @State var tanggalPinjam: Date? = Date.now
    @State private var namaBuku: String = ""
    @State private var tersedia: Bool = true
    
    @Binding var refresh: Bool
    
    let pengolah: PengolahDatabasePerpustakaan
    
    var body: some View {
        VStack {
            TextField(admin.nama_buku ?? "", text: $namaBuku)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("update"){
                if !namaBuku.isEmpty {
                    admin.nama_buku = namaBuku
                    pengolah.updateBuku()
                    refresh.toggle()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            VStack{
                HStack{
                    Text(admin.id_buku ?? "")
                    Text(admin.nama_buku ?? "")
                }
                Image(uiImage: admin.gambar_buku ?? UIImage())
                    .resizable()
                    .frame(width: 250, height: 400)
                if admin.tersedia == true {
                    Text("masih tersedia")
                        .bold()
                }
                else {
//                    let formater = DateFormatter()
//                    let tanggalPinjam = formater.string(from: tanggalPinjam ?? Date.now)
//                    let tanggalKembali = formater.string(from: tanggalKembali ?? Date(timeIntervalSinceNow: 604800))
                    Text("tanggal pinjam : \(tanggalPinjam!)")
                    Text("tanggal kembali : \(tanggalKembali!)")
                }
            }
            .onAppear {
                if admin.tersedia == false {
                    user = pengolah.bukuPinjaman().filter({$0.buku_id == admin}).last ?? User()
                    tanggalPinjam = user.tanggal_pinjam
                    tanggalKembali = user.tanggal_kembali
                }
            }
        }
    }
}

//struct DetailBuku_Previews: PreviewProvider {
//    static var previews: some View {
//        let admin = Admin()
//        let userPinjam = User()
//        let pengolah = PengolahDatabasePerpustakaan()
//        
//        DetailBuku(admin: admin, user: userPinjam, refresh: .constant(false), pengolah: pengolah)
//    }
//}
