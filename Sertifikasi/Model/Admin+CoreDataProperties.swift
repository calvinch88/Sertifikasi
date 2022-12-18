//
//  Admin+CoreDataProperties.swift
//  Sertifikasi
//
//  Created by Calvin Chandra on 18/12/22.
//
//

import Foundation
import CoreData


extension Admin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Admin> {
        return NSFetchRequest<Admin>(entityName: "Admin")
    }

    @NSManaged public var id_buku: String?
    @NSManaged public var id_user: String?
    @NSManaged public var nama_buku: String?
    @NSManaged public var tersedia: Bool
    @NSManaged public var bukuid: User?

}

extension Admin : Identifiable {

}
