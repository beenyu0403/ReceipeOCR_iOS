//
//  ReceiptView.swift
//  receiptOCR
//
//  Created by user on 11/2/23.
//

import SwiftUI

struct spendInfo: Hashable {
    var category:String = ""
    var id:String = ""
    var price:String = ""
    var num:String = ""
    var sumprice:String = ""
}

struct ReceiptView: View {
    
    @StateObject var Filemodel = FileModel()
    @State var total: [String:String] = [:]
    @State var list: [[String]] = [[]]
    @State var sumlist: [spendInfo] = []
    
    var body: some View {
        ZStack{

            Color(red: 92 / 255, green: 65 / 255, blue: 89 / 255).ignoresSafeArea()
            VStack{
                Text("지출 내역")
                    .padding(.top, 50)
                    .padding(.trailing, 240)
                    .foregroundColor(.white)
                
                List {
                    
                        HStack {
                            Text("카테고리  / ")
                            Text("상품  / ")
                            Text("단가  / ")
                            Text("수량")
                            Spacer()
                            Text("금액")
                        }
                    
                        ForEach(sumlist, id: \.self) { to in
                            HStack {
                                Text("\(to.category)")
                                Text("\(to.id)")
                                Text("\(to.price)")
                                Text("\(to.num)")
                                Spacer()
                                Text("\(to.sumprice)")
                            }
                        }
                        ForEach(Array(total.keys), id: \.self) { c in
                            HStack {
                                Text(c)
                                Spacer()
                                Text(total[c] ?? "no data")
                            }
                        }
                    
                }
                .scrollContentBackground(.hidden)

                
            }.onAppear {
                list = readCSV(inputFile: "result_1")
                if sumlist.isEmpty && receiptisToggleOn {
                    total = readsumCSV(inputFile: "result_1")
                    for x in list {
                        sumlist.append(spendInfo(category: x[0], id: x[1], price: x[2], num: x[3], sumprice: x[4]))
                        //print(sumlist)
                    }
                }

            }
        }
    }
    
    func readsumCSV(inputFile: String) -> [String:String] {
                    if let filepath = Bundle.main.path(forResource: inputFile, ofType: "csv") {
                        do {
                            let fileContent = try String(contentsOfFile: filepath)
                            let lines = fileContent.components(separatedBy: "\n")
                            var results: [String:String] = [:]
                            lines.dropFirst().forEach { line in
                                let data = line.trimmingCharacters(in: ["\r"]).components(separatedBy: ",")
                                if data.count == 2 {
                                    results[data[0]] = data[1]
                                    
                                }
                            }
                            //print(fileContent)
                            
                            return results
                        } catch {
                            print("error: \(error)") // to do deal with errors
                        }
                    } else {
                        print("\(inputFile) could not be found")
                    }
                return [:]
        
    }
    
    func readCSV(inputFile: String) -> [[String]] {
                    if let filepath = Bundle.main.path(forResource: inputFile, ofType: "csv") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: filepath))
                            let dataEncoded = String(data: data, encoding: .utf8)
                            var res: [[String]] = []
                            if let lines = dataEncoded?.components(separatedBy: "\n").map({$0.trimmingCharacters(in: ["\r"]).components(separatedBy: ",")}) {
                                for item in lines {
                                    res.append(item)
                                }
                            }
                            res.removeFirst()
                            res.removeLast()
                            res.removeLast()
                            
                            return res
                        } catch {
                            print("error: \(error)") // to do deal with errors
                        }
                    } else {
                        print("\(inputFile) could not be found")
                    }
                    return [[]]
        
    }
   
}

#Preview {
    ReceiptView()
}
