//
//  User+CoreDataProperties.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 18/12/22.
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
    @NSManaged public var buku_id: NSSet?

}

// MARK: Generated accessors for buku_id
extension User {

    @objc(addBuku_idObject:)
    @NSManaged public func addToBuku_id(_ value: Admin)

    @objc(removeBuku_idObject:)
    @NSManaged public func removeFromBuku_id(_ value: Admin)

    @objc(addBuku_id:)
    @NSManaged public func addToBuku_id(_ values: NSSet)

    @objc(removeBuku_id:)
    @NSManaged public func removeFromBuku_id(_ values: NSSet)

}

extension User : Identifiable {

}
