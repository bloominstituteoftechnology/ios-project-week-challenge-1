import Foundation

class Fetcher {
    static func GET<T:Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        execute(request: request, completion: completion)
    }
    
    static func DELETE<T:Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        execute(request: request, completion: completion)
    }
    
    private static func execute<T:Decodable>(request: URLRequest, completion: @escaping (T?, Error?) -> Void){
        print(request.url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data\(error)")
                completion(nil, error)
            }
            guard let data = data else {
                NSLog("no data fetched")
                completion(nil, nil)
                return
            }
            
            var entity: T?
            do {
                entity = try JSONDecoder().decode(T.self, from: data)
            }
            catch{
                NSLog("Error decoding entity:\(error)")
                completion(nil, error)
            }
            
            completion(entity, nil)
        }
        dataTask.resume()
    }
}

