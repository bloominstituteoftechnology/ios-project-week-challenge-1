import Foundation

struct Nothing: Codable {}

class Fetcher {
    private static let nothing = Nothing()
    
    static func GET<T:Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        execute(request: request, body: nothing, completion: completion)
    }
    
    static func DELETE<T:Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        execute(request: request, body: nothing, completion: completion)
    }
    
    static func POST<T:Decodable, B:Encodable>(url: URL, body:B, completion: @escaping (T?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        execute(request: request, body:body, completion: completion)
    }
   
    static func PUT<T:Decodable, B:Encodable>(url: URL, body:B, completion: @escaping (T?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        execute(request: request, body:body, completion: completion)
    }
    
    
    private static func execute<T:Decodable, B:Encodable>(
        request: URLRequest,
        body: B,
        completion: @escaping (T?, Error?) -> Void
    ){
        var request = request
        if let url = request.url {
            NSLog("\(request.httpMethod!) \(url)")
        }
        
        if !(body is Nothing) {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                NSLog("Unable to encode \(error)")
                completion(nil, error)
                return
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                NSLog("response: \(response.statusCode)")
            }
            
            if let error = error {
                NSLog("Error fetching data\(error)")
                completion(nil, error)
                return
            }
            
            if T.self == Nothing.self || T.self == Nothing?.self {
                completion(nil, nil)
                return
            }
            
//            guard let data = data else {
//                NSLog("no data fetched")
//                completion(nil, nil)
//                return
//            }
            
//            if data == null {
//                completion(nil, nil)
//                return
//            }
            
            var entity: T?
            do {
                entity = try JSONDecoder().decode(T.self, from: data!)
            }
            catch{
                NSLog("Error decoding entity:\(error)")
                completion(nil, error)
            }
            
            completion(entity, nil)
        }
        dataTask.resume()
    }
    
    //private static let null: Data = "null".data(using: .ascii)!
}

