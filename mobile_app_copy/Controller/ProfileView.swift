//
//  ProfileView.swift
//
//  Created by Ainhoa Mugica on 21.02.23.
//

import SwiftUI
import RealmSwift

//Custom Colors
struct CustomColor {
    static let BackGray = Color("BackGray")
}

struct ProfileView: View {
    @ObservedRealmObject var customer: customer
    //@ObservedRealmObject var customerPolicy: customerPolicies
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                HStack {
                    Image("ProfileImg")
                        .resizable()
                        .frame(width: 60, height: 60)
                  
                    Text(customer.firstName ?? "No Name")
                        .bold()
                    Text(customer.lastName ?? "No Last Name")
                        .bold()
                }
                .padding(.top,-70)
                
                HStack{
                    Text("All")
                      .frame(width: 70, height:30)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Text("House")
                        .frame(width: 70, height:30)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    
                    Text("Car")
                        .bold()
                        .frame(width: 70, height:30)
                        .background(Color.accentColor)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    
                    Text("Health")
                        .frame(width: 70, height:30)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.top,-10)
                
                Form{
                    Section(header: Text("ACTIVE POLICY")) {
                        HStack {
                            Text("Policy Number")
                            Spacer()
                            Text("\(customer.policy[0].policyNumber!)")
                                .foregroundColor(Color.gray)
                        }
                        HStack {
                            Text("March Premium")
                            Spacer()
                            //Text("\(customer.policy[0].baseMonthlyPremium ?? 0) $")
                            //Text("\(customer.policy[0].premium[1].calculatedPremium ?? 0) $")
                            Text("121.51$")
                                .foregroundColor(Color.gray)
                                
                        }
                        
                    }
                    
                }
                .frame(width: 350, height:170)
                
               /* Form{
                    Section(header: Text("INSURED VEHICLE")) {
                        HStack {
                            Text("Brand")
                            Spacer()
                            Text(customer.policy[0].vehicles[0].vehicleMake ?? "No brand")
                                .foregroundColor(Color.gray)
                        }
                        HStack {
                            Text("Model")
                            Spacer()
                            Text(customer.policy[0].vehicles[0].vechicleModel ?? "No Model")
                                .foregroundColor(Color.gray)
                        }
                        HStack {
                            Text("VIN")
                            Spacer()
                            Text(customer.policy[0].vehicles[0].vin ?? "No VIN")
                                .foregroundColor(Color.gray)
                        }
                    }
                    
                }
                .frame(width: 350, height:190)
                .padding(.top,-50)
                */
                
                Form{
                    Section(header: Text("INSURED VEHICLE")) {
                        HStack{
                            VStack(alignment: .leading, spacing: 10.0){
                                Text(customer.policy[0].vehicles[0].vehicleMake ?? "No brand")
                                Text(customer.policy[0].vehicles[0].vechicleModel ?? "No Model")
                                Text(customer.policy[0].vehicles[0].vin ?? "No VIN" )
                                    .foregroundColor(Color.gray)
                            }
                            
                            Image("TeslaImg")
                                .resizable()
                                .frame(width: 200, height: 130)
                               
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        
                    }
                }
                .frame(width: 350, height:180)
                .padding(.top,-50)
                
                
                HStack{
                    Text("Add")
                    Image(systemName: "plus")
                }
                .frame(width: 70, height: 30)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .padding(.top, -20)
                .padding(.leading, 240)
                .shadow(radius: 8)
             
                
               
                VStack{
                    Text("Get peace of mind")
                        .font(.title3)
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 16.0){
                            Image("RoadImg")
                                .resizable()
                                .frame(width: 50, height:50)
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                            
                            Text("Roadside Assistance")
                                .padding(.horizontal, 10)
                            
                            Text("From 19$/mo")
                                .foregroundColor(Color.gray)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 10)
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .frame(width: 170, height: 200)
                        .shadow(radius: 8)
                        
                        VStack(alignment: .leading, spacing: 16.0){
                
                            Image("MaintenanceImg")
                                .resizable()
                                .frame(width: 50, height:50)
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                            
                            Text("Scheduled Maintenance")
                                .padding(.horizontal, 10)
                            
                            Text("From 25$/mo")
                                .foregroundColor(Color.gray)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 10)
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .frame(width: 170, height: 200)
                        .shadow(radius: 8)
                        
                    }
                    .padding(.top, -20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(CustomColor.BackGray.edgesIgnoringSafeArea(.all))
            
            
            
        }
        
        
        // NAVIGATION //
        HStack{
            /*VStack{
                Image(systemName: "dollarsign.circle")
                NavigationLink(destination: BillsView(), label: {
                    Text("Bills")
                        .foregroundColor(.black)
                        .padding(10)
                })
            }
            
            VStack{
                Image(systemName: "car")
                NavigationLink(destination: DrivingView(), label: {
                    Text("Driving History")
                        .foregroundColor(.black)
                        .padding(10)
                })
            }*/
            
            NavigationLink(destination: BillsView(), label: {
                Text("Bills")
                    .bold()
                    .frame(width: 90, height:40)
                    .background(Color.accentColor)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: DrivingView(), label: {
                Text("Driving History")
                    .bold()
                    .frame(width: 160, height:40)
                    .background(Color.accentColor)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            })
            
            NavigationLink(destination: DrivingView(), label: {
                Text("Offers")
                    .bold()
                    .frame(width: 90, height:40)
                    .background(Color.accentColor)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            })
        }
        
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        //ProfileView(customer: customer())
        
        ProfileView(customer: customer())
    }
}
