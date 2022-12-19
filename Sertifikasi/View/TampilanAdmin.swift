//
//  TampilanAdmin.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 17/12/22.
//

import SwiftUI
import PhotosUI

struct TampilanAdmin: View {
    
    let pengolah: PengolahDatabasePerpustakaan
    
    @State private var id_buku: String = ""
    @State private var namaBuku: String = ""
    @State private var tersedia: Bool = true
    
    @State private var adminPerpus: [Admin] = [Admin]()
    @State private var userPinjam: User = User()
    
    @State private var refresh: Bool = false
    private func updateList() {
        adminPerpus = pengolah.semuaBuku()
    }
    
    @State private var isiForm: Bool = false
    @State private var resetFoto: Bool = false
    @State private var gambarBuku: [PhotosPickerItem] = []
    @State private var data: Data?
    
    var body: some View {
        VStack {
            Text("admin perpustakaan")
                .bold()
            TextField("id buku", text: $id_buku)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("nama buku", text: $namaBuku)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            PhotosPicker(
                selection: $gambarBuku,
                maxSelectionCount: 1,
                matching: .images
            ) {
                
                Text("pilih gambar")
            }.onChange(of: gambarBuku) { valueGambar in
                guard let item = gambarBuku.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let success):
                        if let data = success {
                            self.data = data
                            resetFoto = false
                        } else {
                            print("tidak ada gambar")
                        }
                    case .failure(let failure):
                        fatalError("gagal upload : \(failure)")
                    }
                    
                }
            }
            if resetFoto == false {
                if let data = data, let gambar = UIImage(data: data) {
                    Image(uiImage: gambar)
                        .resizable()
                }
            }
            Button("tambah"){
                if id_buku == "" || namaBuku == "" || gambarBuku == nil {
                    isiForm = true
                } else {
                    if let data = data {
                        guard let bukugambar = UIImage(data: data) else { return }
                        pengolah.tambahBuku(id_buku: id_buku, gambar_buku: bukugambar, nama_buku: namaBuku, tersedia: tersedia)
                        updateList()
                        id_buku = ""
                        namaBuku = ""
                        resetFoto = true
                    }
                }
            }.alert("isi id buku dan nama buku", isPresented: $isiForm) {
                Button("oke", role: .cancel) { }
            }
            List {
                ForEach (adminPerpus, id: \.self) { adminPerpus in
                    NavigationLink(
                        destination: DetailBuku(admin: adminPerpus, user: userPinjam, refresh: $refresh, pengolah: pengolah),
                        label: {
                            HStack {
                                Text(adminPerpus.id_buku ?? "")
                                Text(adminPerpus.nama_buku ?? "")
                                if adminPerpus.tersedia == true {
                                    Image(systemName: "v.circle")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "x.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    )
                }.onDelete(perform: { IndexSet in
                    IndexSet.forEach { index in
                        let buku = adminPerpus[index]
                        pengolah.hapusBuku(admin: buku)
                        updateList()
                    }
                })
            }.listStyle(PlainListStyle())
                .accentColor(refresh ? .white: .black)
            Spacer()
                .onAppear(perform: {
                    updateList()
                })
        }
    }
}

//struct TampilanAdmin_Previews: PreviewProvider {
//    static var previews: some View {
//        TampilanAdmin(pengolah: PengolahDatabasePerpustakaan())
//    }
//}
