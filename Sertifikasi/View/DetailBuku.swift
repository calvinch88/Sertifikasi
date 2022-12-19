//
//  DetailBuku.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 17/12/22.
//

import SwiftUI
import PhotosUI

struct DetailBuku: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let admin: Admin
    @State var user: User = User()
    @State var tanggalKembali: Date? = Date.now
    @State var tanggalPinjam: Date? = Date.now
    @State private var namaBuku: String = ""
    @State private var tersedia: Bool = true
    
    @State private var gambarBuku: [PhotosPickerItem] = []
    @State private var data: Data?
    
    @Binding var refresh: Bool
    @State private var isiForm: Bool = false
    
    let pengolah: PengolahDatabasePerpustakaan
    
    var body: some View {
        VStack {
            TextField(admin.nama_buku ?? "", text: $namaBuku)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if let data = data, let gambar = UIImage(data: data) {
                Image(uiImage: gambar)
                    .resizable()
            } else {
                Text("mau update gambar? kalau ngga abaikan")
            }
            PhotosPicker(
                selection: $gambarBuku,
                maxSelectionCount: 1,
                matching: .images
            ) {
                Text("ganti gambar")
            }.onChange(of: gambarBuku) { valueGambar in
                guard let item = gambarBuku.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let success):
                        if let data = success {
                            self.data = data
                        } else {
                            print("tidak ada gambar")
                        }
                    case .failure(let failure):
                        fatalError("gagal upload : \(failure)")
                    }
                    
                }
            }
            Button("update"){
                if !namaBuku.isEmpty {
                    if let data = data {
                        guard let bukugambar = UIImage(data: data) else { return }
                        admin.nama_buku = namaBuku
                        admin.gambar_buku = bukugambar
                        pengolah.updateBuku()
                        refresh.toggle()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        admin.nama_buku = namaBuku
                        pengolah.updateBuku()
                        refresh.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    isiForm = true
                }
            }.alert("apa yang di update? masih kosong", isPresented: $isiForm) {
                Button("oh oke", role: .cancel) { }
            }
            VStack{
                Text("id buku : \(admin.id_buku ?? "")")
                Text("nama buku : \(admin.nama_buku ?? "")")
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
