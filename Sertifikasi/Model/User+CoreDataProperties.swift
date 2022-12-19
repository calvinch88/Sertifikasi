//
//  User+CoreDataProperties.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 19/12/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id_buku: String?
    @NSManaged public var tanggal_kembali: Date?
    @NSManaged public var tanggal_pinjam: Date?
    @NSManaged public var buku_id: Admin?

}

extension User : Identifiable {

}
