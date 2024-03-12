//
//  FileModel.swift
//  receiptOCR
//
//  Created by user on 11/16/23.
//

import Foundation
var cityAndCountry:[[String]] = []
let filePath = "/Users/user/Desktop/djangoProject/mysite/projectServer/result_csv"
let fileUrl = URL(string: filePath)



let ccsvpath = fileUrl?.appendingPathComponent("result1.csv")

class FileModel: ObservableObject {
    let fileManager = FileManager()
    
    
    func fileread() async throws {
        

//        print(ccsvpath!)
//        do {
//            let dataFromPath: Data = try Data(contentsOf: ccsvpath!) // URL을 불러와서 Data타입으로 초기화
//            let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서없음" // Data to String
//            print(text) // 출력
//        } catch let e {
//            print(e.localizedDescription)
//        }
//        
    }
    
}
