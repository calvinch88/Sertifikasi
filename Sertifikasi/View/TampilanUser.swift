//
//  TampilanUser.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 17/12/22.
//

import SwiftUI

struct TampilanUser: View {
    
    let pengolah: PengolahDatabasePerpustakaan
    @State private var adminPerpus: [Admin] = [Admin]()
    @State private var refresh: Bool = false
    
    var body: some View {
        VStack {
            Text("buku yang sedang dipinjam")
                .bold()
            List {
                ForEach (adminPerpus, id: \.self) { adminPerpus in
                    HStack {
                        if adminPerpus.tersedia == false {
                            Text(adminPerpus.nama_buku ?? "")
                        } else {
//                            Text("belum ada buku yang dipinjam")
                        }
                    }
                }
            }.listStyle(PlainListStyle())
                .accentColor(refresh ? .white: .black)
            Text("buku yang dapat dipinjam")
                .bold()
            List {
                ForEach (adminPerpus, id: \.self) { adminPerpus in
                    NavigationLink(
                        destination: PinjamBuku(pengolah: pengolah, refresh: $refresh, admin: adminPerpus),
                        label: {
                            HStack {
                                if adminPerpus.tersedia == true {
                                    Text(adminPerpus.nama_buku ?? "")
                                } else {
//                                    Text("belum ada buku yang bisa dipinjam")
                                }
                            }
                        }
                    )
                }
            }.listStyle(PlainListStyle())
                .accentColor(refresh ? .white: .black)
            Spacer()
                .onAppear(perform: {
                    adminPerpus = pengolah.semuaBuku()
                })
        }
    }
}

//struct TampilanUser_Previews: PreviewProvider {
//    static var previews: some View {
//        TampilanUser(pengolah: PengolahDatabasePerpustakaan())
//    }
//}
