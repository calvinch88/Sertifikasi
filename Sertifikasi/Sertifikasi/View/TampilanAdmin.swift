//
//  TampilanAdmin.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 17/12/22.
//

import SwiftUI

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
    
    var body: some View {
        VStack {
            Text("admin perpustakaan")
                .bold()
            TextField("id buku", text: $id_buku)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("nama buku", text: $namaBuku)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("tambah"){
                pengolah.tambahBuku(id_buku: id_buku, nama_buku: namaBuku, tersedia: tersedia)
                updateList()
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
