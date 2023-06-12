//
//  DataModel.swift
//
//  Created by Ainhoa Mugica on 21.02.23.
//

import Foundation
import RealmSwift

class customer: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true)  var _id: String?
    //@Persisted(primaryKey: true)  var _id: ObjectId?
    
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var customerId: String?
    
    // Backlink to the user. This is automatically updated whenever
    // this task is added to or removed from a user's task list.
    @Persisted(originProperty: "customerId") var policy: LinkingObjects<customerPolicy>
}


class customerPolicy: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true)  var _id: ObjectId?
    @Persisted var customerId: customer?
    @Persisted var policyNumber: String?
    @Persisted var baseMonthlyPremium: Decimal128?
    // @Persisted var policyExpirationDate: Date?
    @Persisted var vehicles: List<customerPolicy_vehicles>
    @Persisted var premium: List<customerPolicy_premium>
    // @Persisted var premium: List<premiumNew>
}



class customerPolicy_vehicles: EmbeddedObject {
    @Persisted var vechicleModel: String?
    @Persisted var vehicleMake: String?
    @Persisted var vehicleYear: Int?
    @Persisted var vin: String?
}

class customerPolicy_premium: EmbeddedObject {
    @Persisted var month: Int?
    @Persisted var calculatedPremium: Double?
}
 
