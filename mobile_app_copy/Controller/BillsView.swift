//
//  BillsView.swift
//
//  Created by Ainhoa Múgica on 21/2/23.
//

import SwiftUI
import UIKit
import WebKit
import Charts

struct BillsView: View {
    var body: some View {
        
        VStack{
            
            HStack{
                Image(systemName: "square.and.arrow.down")
                
                Text("Download Report")
                    .underline()
            }
            .padding(.leading, 170)
            
            WebView(url: URL(string: "https://charts.mongodb.com/charts-jeffn-zsdtj/embed/charts?id=63f4ed3b-da34-491b-8a1f-4915c2688c9f&maxDataAge=3600&theme=light&autoRefresh=true")!)
        }
        .navigationTitle("Bills")
    }
}


struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView()
    }
}
