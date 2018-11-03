import UIKit

var str = "Hello, playground"
func searchPokemon(name: String, completion: @escaping (Error?) -> Void){
    
    let requestURL = baseURL.appendingPathComponent("api")
        .appendingPathComponent("v2")
        .appendingPathComponent("pokemon")
        .appendingPathComponent(name)
    
    //      let requestURL = baseURL.appendingPathComponent("api").appendingPathComponent("v2").appendingPathComponent("pokemon").appendingPathComponent(name)
    
    var request = URLRequest(url: requestURL)
    request.httpMethod = HTTPMethod.get.rawValue
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let error = error {
            NSLog("Error grabbing pokemon info from server \(error)")
            completion(NSError())
            return
        }
        
        guard let data = data else {
            NSLog("No data returned")
            completion(NSError())
            return
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do{
            let pokemonGrab = try jsonDecoder.decode(Pokemon.self, from: data)
            print(pokemonGrab)
            
            self.pokemon = pokemonGrab
            
            completion(nil)
        }catch {
            NSLog("Error decoding pokemon from server \(error)")
            completion(nil)
            return
        }
        }.resume()
}

// CRUD -

// Save Pokemon

func savePokemon(pokemon: Pokemon?){
    guard let pokemon = pokemon else {return}
    pokedex.append(pokemon)
}

// Delete Pokemon

func deletePokemon(pokemon: Pokemon){
    guard let index = pokedex.index(of: pokemon) else {return}
    pokedex.remove(at: index)
}


}
