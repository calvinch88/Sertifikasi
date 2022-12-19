//
//  Admin+CoreDataProperties.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 19/12/22.
//
//

import Foundation
import CoreData
import UIKit


extension Admin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Admin> {
        return NSFetchRequest<Admin>(entityName: "Admin")
    }

    @NSManaged public var gambar_buku: UIImage?
    @NSManaged public var id_buku: String?
    @NSManaged public var nama_buku: String?
    @NSManaged public var tersedia: Bool
    @NSManaged public var bukuid: NSSet?

}

// MARK: Generated accessors for bukuid
extension Admin {

    @objc(addBukuidObject:)
    @NSManaged public func addToBukuid(_ value: User)

    @objc(removeBukuidObject:)
    @NSManaged public func removeFromBukuid(_ value: User)

    @objc(addBukuid:)
    @NSManaged public func addToBukuid(_ values: NSSet)

    @objc(removeBukuid:)
    @NSManaged public func removeFromBukuid(_ values: NSSet)

}

extension Admin : Identifiable {

}
