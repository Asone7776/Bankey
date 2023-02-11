//
//  SummaryControllerViewController.swift
//  Bankey
//
//  Created by Uzkassa on 10/02/23.
//

import UIKit
import CoreLocation

class SummaryControllerViewController: UIViewController {
    var summaryHeader = SummaryHeader();
    var brain = WeatherBrain();
    let locationManager = CLLocationManager();
    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]
    let table: UITableView = {
        let table = UITableView();
        table.translatesAutoresizingMaskIntoConstraints = false;
        return table;
    }();
    override func viewDidLoad() {
        super.viewDidLoad();
        style();
        layout();
        setup();
        setupLocation();
        brain.delegate = self;
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = appColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}



extension SummaryControllerViewController{
    private func setupLocation(){
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestLocation();
    }
    private func setup(){
        table.showsVerticalScrollIndicator = false;
        table.delegate = self;
        table.dataSource = self;
        table.register(SummaryTableCell.self, forCellReuseIdentifier: SummaryTableCell.reuseId);
        table.allowsSelection = false;
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = .zero
        }
    }
    
    private func style(){
        
    }
    
    private func layout(){
        view.addSubview(table);
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]);
    }
}
extension SummaryControllerViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableCell.reuseId, for: indexPath) as! SummaryTableCell;
        return cell;
    }
}

extension SummaryControllerViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return summaryHeader;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 144;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SummaryTableCell.cellHeight;
    }
}
extension SummaryControllerViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation();
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation();
            let coordinate = location.coordinate;
            let lat = coordinate.latitude;
            let lon = coordinate.longitude;
            brain.fetchWeatherByCoordinates(lat: lat, lon: lon);
        }
    }
}
extension SummaryControllerViewController:CanShowWeather{
    func didSuccess(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.summaryHeader.image.image = UIImage(systemName: weather.conditionName);
            self.summaryHeader.nameLabel.text = "\(weather.cityName): \(weather.temperatureString)ºC";
        }
    }
    
    func didFailure(message: String) {
        print(message);
    }
}
