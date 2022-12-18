//
//  ContentView.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 16/12/22.
//

import SwiftUI

struct ContentView: View {
    
//    let pengolah: PengolahDatabasePerpustakaan
//    @State private var user_id: String = ""
//    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
//                TextField("user id", text: $user_id)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                TextField("password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    
                }, label: {
                    NavigationLink(destination: TampilanAdmin(pengolah: PengolahDatabasePerpustakaan())) {
                         Text("admin")
                     }
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    NavigationLink(destination: TampilanUser(pengolah: PengolahDatabasePerpustakaan())) {
                         Text("pengunjung")
                     }
                })
                Spacer()
            }.padding()
            .navigationTitle("halaman perpustakaan")
        }
    }
}

//struct ContentView_Previews:  PreviewProvider {
//    static var previews: some View {
//        ContentView(
//            pengolah: PengolahDatabasePerpustakaan()
//        )
//    }
//}
