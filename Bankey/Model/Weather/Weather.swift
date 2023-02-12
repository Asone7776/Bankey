import Foundation

struct Weather: Codable{
    let id: Int
    let description: String
}

struct Main: Codable{
    let temp: Double
}

struct Item:Codable{
    var name: String;
    var cod: Int;
    let weather: [Weather]
    let main: Main
}
