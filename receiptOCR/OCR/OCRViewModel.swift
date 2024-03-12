//
//  OCRViewModel.swift
//  receiptOCR
//
//  Created by user on 11/2/23.
//

import Vision
import VisionKit

extension String {
    var isNumberByCharacterSet: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}

class OCRViewModel: ObservableObject {
  // MARK: - Properties
  @Published var OCRString: String?
  @Published var OCRStringdir: [String] = []

    @Published var OCRBlockx: Float?
    @Published var OCRBlocky: Float?
    @Published var OCRBlockw: Float?
    @Published var OCRBlockh: Float?
    @Published var results = [Result]()
    
    var locations = [Result.Location]()
    var sizes = [Result.Sizet]()
    var types: [String] = []

  
  // MARK: - Methods
    func recognaizeText(image: UIImage) {
      guard let Image = image.cgImage else { fatalError("이미지 오류")}
      
      let handler = VNImageRequestHandler(cgImage: Image, options: [:])
        
        let request = VNRecognizeTextRequest {  [weak self] request, error in
          // 결과값 옵셔널 바인딩
          guard let result = request.results as? [VNRecognizedTextObservation],
                error == nil else { return }
          // resultd에서 최대 후보군 1개에서 첫번째 후보를 String 타입으로 변환
          let text = result.compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n")
          let septext = result.compactMap { $0.topCandidates(1).first?.string }
          // 이를 OCR 결과에 반영
          self?.OCRString = text
            self?.OCRStringdir = septext
            print(text)
            print(septext)

            let boundingRects: [CGRect] = result.compactMap { observation in
                
                // Find the top observation.
                guard let candidate = observation.topCandidates(1).first else { return .zero }
                
                // Find the bounding-box observation for the string range.
                let stringRange = candidate.string.startIndex..<candidate.string.endIndex
                let boxObservation = try? candidate.boundingBox(for: stringRange)
                
                // Get the normalized CGRect value.
                let boundingBox = boxObservation?.boundingBox ?? .zero
                
                
                // Convert the rectangle from normalized coordinates to image coordinates.
                return VNImageRectForNormalizedRect(boundingBox,
                                                    Int(image.size.width),
                                                    Int(image.size.height))
            }
            print(boundingRects)
            //print(boundingRects.first ?? 0)
            
            for x in 0 ..< boundingRects.count {
                self?.OCRBlockx = Float(boundingRects[x].minX)
                self?.OCRBlocky = Float(boundingRects[x].minY)
                self?.OCRBlockw = Float(boundingRects[x].width)
                self?.OCRBlockh = Float(boundingRects[x].height)
//                print(self?.OCRBlockx ?? 0)
//                print(self?.OCRBlocky ?? 0)
//                print(self?.OCRBlockw ?? 0)
//                print(self?.OCRBlockh ?? 0)
                let oblocation = Result.Location(x: self?.OCRBlockx ?? 0, y: self?.OCRBlocky ?? 0)
                self?.locations.append(oblocation)
//                print(self?.locations ?? 0)
                let obsize = Result.Sizet(width: self?.OCRBlockw ?? 0, height: self?.OCRBlockh ?? 0)
                self?.sizes.append(obsize)
//                print(self?.sizes ?? "")
                let pattern: String = "[0-9]"
                let range = septext[x].range(of:pattern, options:.regularExpression) != nil
                if range == true {
                    self?.types.append("number")
                }else{
                    self?.types.append("text")
                }
                
            }
            load()
            
            for x in 0 ..< boundingRects.count {
                let obres = Result(text: self?.OCRStringdir[x] ?? "", location: self?.locations[x] ?? Result.Location(x: 0, y: 0), size: self?.sizes[x] ?? Result.Sizet(width: 0, height: 0), type: self?.types[x] ?? "text")
                self?.results.append(obres)
            }
            let mm = Meta.init(userID: currentUser?.email ?? "비로그인")
            print("결과")
            print(self?.results ?? "")
            let sodeul : ResultInfo = .init(meta: mm, result: self?.results ?? [Result(text: "", location: Result.Location(x: 0, y: 0), size: Result.Sizet(width: 0, height: 0), type: "")])
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
            let pp = try? encoder.encode(sodeul)
            
            //print("타입: ", type(of: pp))
            if let pp = pp, let jsonString = String(data: pp, encoding: .utf8){
                print(jsonString)
            }
            
            //print(pp ?? "")
            loadjsonbody(pp: pp)
            

            
            

          

            // 생성한 request를 Alamofire로 전송
//            AF.request(request)
//                        .validate(statusCode: 200..<300)
//                        .validate(contentType: ["application/json"])
//                        .response { (response) in
//                        switch response.result {
//                        case .success(_):
//                            print("성공?")
//                        case .failure(let error):
//                            print("실패?")
//                        }
//                    }
            
        }
        

        
        if #available(iOS 16.0, *) {
          
          /// VNRecognizeTextRequestRevision3는 iOS 16부터 지원
          request.revision = VNRecognizeTextRequestRevision3
          request.recognitionLanguages = ["ko-KR"]
        } else {
          request.recognitionLanguages = ["en-US"]
        }
        /// 정확도와 속도 중 어느 것을 중점적으로 처리할 것인지
        request.recognitionLevel = .accurate
        /// 언어를 인식하고 수정하는 과정을 거침.
        request.usesLanguageCorrection = true
        
        
        
        
        do {
          print(try request.supportedRecognitionLanguages())
            
          try handler.perform([request])
        
        } catch {
          print(error)
        }
        
        
    }
}
