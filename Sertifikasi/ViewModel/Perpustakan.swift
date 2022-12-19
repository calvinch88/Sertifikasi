//
//  Perpustakan.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 16/12/22.
//

import Foundation
import CoreData
import UIKit

class PengolahDatabasePerpustakaan {
    
    let isiCoreData: NSPersistentContainer
    
    init() {
        isiCoreData = NSPersistentContainer(name: "DatabasePerpustakaan")
        isiCoreData.loadPersistentStores { (description, error) in
            if let error = error {
                print("Eror karna \(error.localizedDescription)")
            }
        }
    }
    
    func semuaBuku() -> [Admin] {
        
        let fetchReq: NSFetchRequest<Admin> = Admin.fetchRequest()
        
        do {
            return try isiCoreData.viewContext.fetch(fetchReq)
        } catch {
            return []
        }
        
    }
    
    func tambahBuku(id_buku: String, gambar_buku: UIImage, nama_buku: String, tersedia: Bool) {
        let buku = Admin(context: isiCoreData.viewContext)
        buku.id_buku = id_buku
        buku.nama_buku = nama_buku
        buku.gambar_buku = gambar_buku
        buku.tersedia = tersedia
        
        do {
            try isiCoreData.viewContext.save()
        } catch {
            print("gagal save : \(error)")
        }
        
    }
    
    func updateBuku() {
        
        do {
            try isiCoreData.viewContext.save()
        } catch {
            isiCoreData.viewContext.rollback()
            print("gagal delete : \(error)")
        }
    }
    
    func hapusBuku(admin: Admin) {
        isiCoreData.viewContext.delete(admin)
        
        do {
            try isiCoreData.viewContext.save()
        } catch {
            isiCoreData.viewContext.rollback()
            print("gagal delete : \(error)")
        }
    }
    
    func bukuPinjaman() -> [User] {
        
        let fetchReq: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            return try isiCoreData.viewContext.fetch(fetchReq)
        } catch {
            return []
        }
        
    }
    
    func pinjamBuku(admin: Admin) {
        let tanggalPinjam = Date.now
        let tanggalKembali = Date(timeIntervalSinceNow: 604800)
        
        admin.setValue(false, forKey: "tersedia")
        
        let pinjam = User(context: isiCoreData.viewContext)
        pinjam.buku_id = admin
        pinjam.tanggal_pinjam = tanggalPinjam
        pinjam.tanggal_kembali = tanggalKembali
        
        do {
            try isiCoreData.viewContext.save()
        } catch {
            print("gagal pinjam : \(error)")
        }
        
    }
    
}
