//
//  WeatherBrain.swift
//  Bankey
//
//  Created by Arthur Obichkin on 11/02/23.
//

import Foundation

protocol CanShowWeather {
    func didSuccess(weather:WeatherModel)
    func didFailure(message:String)
}

struct WeatherBrain{
    var delegate:CanShowWeather?
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=d67f4af1ca55365ec4433dea21af9976&units=metric"
    
    func fetchWeatherByCoordinates(lat: Double,lon: Double){
        let url = URL(string: "\(url)&lat=\(lat)&lon=\(lon)&units=metric");
        if let safeUrl = url {
            performRequest(url: safeUrl);
        }
    }
    
    private func performRequest(url:URL) {
        let session = URLSession(configuration: .default);
        let request = URLRequest(url: url);
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error{
                delegate?.didFailure(message: error.localizedDescription)
                return;
            }
            if let safeData = data{
                if let result = self.parseJSON(data: safeData){
                    delegate?.didSuccess(weather: result);
                }
            }
        }
        task.resume();
    }
    
    private func parseJSON(data: Data) -> WeatherModel?{
        let decoder = JSONDecoder();
        do {
            let result = try decoder.decode(Item.self, from: data);
            let conditionId = result.weather[0].id;
            let temp = result.main.temp;
            let name = result.name;
            return WeatherModel(conditionID: conditionId, cityName: name, temperature: temp);
        } catch  {
            delegate?.didFailure(message: error.localizedDescription)
            return nil;
        }
    }
}
