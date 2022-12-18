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
    let user: User
    
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
                if admin.tersedia == true {
                    Text("masih tersedia")
                        .bold()
                } else {
                    let formater = DateFormatter()
                    let tanggalPinjam = formater.string(from: user.tanggal_pinjam ?? Date.now)
                    let tanggalKembali = formater.string(from: user.tanggal_kembali ?? Date(timeIntervalSinceNow: 604800))
                    Text("tanggal pinjam : \(tanggalPinjam)")
                    Text("tanggal kembali : \(tanggalKembali)")
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
