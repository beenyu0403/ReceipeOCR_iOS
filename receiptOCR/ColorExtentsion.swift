//
//  ColorExtentsion.swift
//  receiptOCR
//
//  Created by user on 11/1/23.
//

import SwiftUI


// ColorExtentsion.swift
extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}


//원하는 컬러 생성
extension Color {

   //static let yellow1 = Color(hex: "#FFDC48")
   static let pink1 = Color(hex: "#FF629E") //진한 핑크색
    static let pink2 = Color(hex: "#E2E2E2")//연한 회색
    static let buttonblue1 = Color(hex: "#6793F7") //버튼 진한 파란색
    static let buttonblue2 = Color(hex: "#A3BFFB") //버튼 연한 파란색
    static let buttonpink1 = Color(hex: "#E0326E") //진한 핑크 버튼
    static let backblue = Color(hex: "#4291DB")
   //static let backyellow = Color(hex: "#FFFDEB")
    //static let backpuple = Color(hex: "#FDF1FF")
}
