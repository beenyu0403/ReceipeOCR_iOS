//
//  HomeView.swift
//  receiptOCR
//
//  Created by user on 11/1/23.
//

import SwiftUI

struct HomeView: View {
    @State var tag:Int? = nil
    @State var tag2:Int? = nil
    @State var selectedCar = ""
    
    init() {
            UITabBar.appearance().backgroundColor = UIColor.white
            
        }
    
    var body: some View {
        
        NavigationView {
                    TabView {
                        ZStack{
                            Color(red: 92 / 255, green: 65 / 255, blue: 89 / 255).ignoresSafeArea()
                            ScrollViewReader { scrollView in
                                ScrollView {
                                    ZStack{
                                        
                                        OCRImageView()
                                    }.padding(.top, 20)
                                }
                                
                            }
                        }
                        .tabItem {
                            Image(systemName: "camera.circle.fill")
                                //.padding(.leading, 0)
                            Text("메인")
                          
                        }
                        ZStack{
                            Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255).ignoresSafeArea()
                            ScrollViewReader { scrollView in
                                
                                ReceiptView()
                                
                            }
                        }
                        .tabItem {
                            Image(systemName: "list.bullet.circle.fill")
                            Text("내역")
                        }
                        
                        ZStack{
                            Color(red: 92 / 255, green: 65 / 255, blue: 89 / 255).ignoresSafeArea()
                            ScrollViewReader { scrollView in
                                ScrollView {
                                    ZStack{
                                        
                                        MyPageView()
                                    }
                                }
                            }
                        }
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("마이페이지")
                        }
                        
                    }.toolbarBackground(.red, for: .tabBar)
                    .accentColor(.pink1)
            
                }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        HomeView()
    }
}
