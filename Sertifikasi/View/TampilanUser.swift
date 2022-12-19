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
    @State private var bukuTersedia: [Admin] = []
    @State private var bukuPinjam: [Admin] = []
    
    var body: some View {
        VStack {
            Text("buku yang sedang dipinjam")
                .bold()
            List {
                ForEach (bukuPinjam, id: \.self) { adminPerpus in
                    HStack {
                        Text(adminPerpus.nama_buku ?? "")
                    }
                }
            }.listStyle(PlainListStyle())
                .accentColor(refresh ? .white: .black)
            Text("buku yang dapat dipinjam")
                .bold()
            List {
                ForEach (bukuTersedia, id: \.self) { adminPerpus in
                    NavigationLink(
                        destination: PinjamBuku(pengolah: pengolah, refresh: $refresh, admin: adminPerpus),
                        label: {
                            Text(adminPerpus.nama_buku ?? "")
                        }
                    )
                }
            }.listStyle(PlainListStyle())
                .accentColor(refresh ? .white: .black)
            Spacer()
                .onAppear(perform: {
                    adminPerpus = pengolah.semuaBuku()
                    bukuTersedia = adminPerpus.filter({$0.tersedia == true})
                    bukuPinjam = adminPerpus.filter({$0.tersedia == false})
                })
        }
    }
}

//struct TampilanUser_Previews: PreviewProvider {
//    static var previews: some View {
//        TampilanUser(pengolah: PengolahDatabasePerpustakaan())
//    }
//}
