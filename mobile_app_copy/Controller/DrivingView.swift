//
//  DrivingView.swift
//
//  Created by Ainhoa Múgica on 21/2/23.
//

import SwiftUI
import WebKit
import UIKit

struct DrivingView: View {
    var body: some View {
        
        VStack{
            
            HStack{
                Image(systemName: "square.and.arrow.down")
                
                Text("Download Report")
                    .underline()
            }
            .padding(.leading, 170)
            .padding(.top, 50)
            
            WebView(url: URL(string: "https://charts.mongodb.com/charts-jeffn-zsdtj/embed/charts?id=63edf1ed-0ef2-49b6-8b12-db1ca8d7560a&maxDataAge=3600&theme=light&autoRefresh=true")!)
            
        }
        .navigationTitle("Driving History")
        .padding(.top, -50)
        
    }
    
    
}


// Web View to visualize Atlas Charts
struct WebView: UIViewRepresentable{
    
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


struct DrivingView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingView()
    }
}
