//
//  ContentView.swift
//
//  Created by Ainhoa Mugica on 21.02.23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    // Observe the Realm app object in order to react to login state changes.
    @ObservedObject var app: RealmSwift.App
    
    var body: some View {
        if let user = app.currentUser {
            // Create a `flexibleSyncConfiguration` with `initialSubscriptions`.
            // We'll inject this configuration as an environment value to use when opening the realm
            // in the next view, and the realm will open with these initial subscriptions.
           
        /* Handle sync errors */
            // Specify the clientResetMode when you create the SyncConfiguration.
            // If you do not specify, this defaults to `.recoverUnsyncedChanges` mode.
            //var configuration = user.flexibleSyncConfiguration(clientResetMode: .manual())
            
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                // Check whether the subscription already exists. Adding it more
                // than once causes an error.
                if subs.first(named: "Customers") != nil && subs.first(named: "Policies") != nil{
                //if subs.first(named: "Customers") != nil{
                    // Existing subscription found - do nothing
                    print("subscriptions found")
                    return
                } else {
                    print("subscriptions NOT found")
                    // Add queries for any objects you want to use in the app
                    // Linked objects do not automatically get queried, so you
                    // must explicitly query for all linked objects you want to include
                    subs.append(QuerySubscription<customer>(name: "Customers") {
                        // Query for objects where the customerId is equal to the app's current user's id
                        // This means the app's current user can read and write their own data
                        $0._id == user.id
                    })
                    
                    subs.append(QuerySubscription<customerPolicy>(name: "Policies") {
                        // Query for objects where the customerId is equal to the app's current user's id
                        // This means the app's current user can read and write their own data
                        $0.customerId != nil //user.id
                    })
                }
            })
            
            CustomersView()
                .environment(\.realmConfiguration, config)
        } else {
            // If there is no user logged in, show the login view.
            LoginView()
        }
        
       
       
    }
}

