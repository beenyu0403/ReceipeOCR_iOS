//
//  result.swift
//  receiptOCR
//
//  Created by user on 11/5/23.
//

import Foundation
import SwiftUI

extension Encodable {
    
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}

struct ResultInfo: Codable {
    var meta: Meta
    var result: [Result]
    
}

struct Meta: Codable {
    var userID: String
}

struct Result: Codable {
    var text: String
    
    var location: Location
    struct Location: Codable {
        var x: Float
        var y: Float
    }
    
    var size: Sizet
    struct Sizet: Codable {
        var width: Float
        var height: Float
    }
    
    var type: String
}


struct SimpleJson {
    var name: String
    var message: String
}


func load() {
    let data: Data
    
    if let filePath = Bundle.main.url(forResource: "sample", withExtension: "json") {
        do {
            data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let resultInfo = try decoder.decode(ResultInfo.self, from: data)
            let resultList = resultInfo.result
            print(resultList)
        } catch {
            print("Can not load Json file.")
        }
    }
    
}

func loadjsonbody(pp: Data?) {
    let url = URL(string: "http://localhost:8000/receiptupload/")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = pp
    //HTTP 메시지 헤더
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                //This converts the optionals in to non optionals that could be used further on
                //Be aware this will just return when something goes wrong
                guard let data = data, let response = response, error == nil else{

                    print("Something went wrong: error: \(error?.localizedDescription ?? "unkown error")")
                    return
                }
                
            print("요청 성공 ---------")
                print(response)
        var decodedAnswer: String = ""
                decodedAnswer = String(decoding: data, as: UTF8.self)
        print(decodedAnswer)
            }
        
        print("task 타입: ", type(of: task))
        
        //POST 전송
        task.resume()
}
