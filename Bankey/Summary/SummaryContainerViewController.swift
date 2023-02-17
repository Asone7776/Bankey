//
//  SummaryControllerViewController.swift
//  Bankey
//
//  Created by Uzkassa on 10/02/23.
//

import UIKit
import CoreLocation

class SummaryContainerViewController: UIViewController {
    var confirm = ConfirmAlert();
    var summaryHeader = SummaryHeader();
    var brain = WeatherBrain();
    let locationManager = CLLocationManager();
    var accountCellViewModels = [SummaryModel]();
    let table: UITableView = {
        let table = UITableView(frame: UIScreen.main.bounds, style: .grouped);
        table.translatesAutoresizingMaskIntoConstraints = false;
        return table;
    }();
    
    lazy var logoutButton:UIBarButtonItem = {
        let button = UIBarButtonItem(title: nil, image: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), target: self, action: #selector(logoutPressed));
        button.tintColor = .label;
        return button;
    }();
    override func viewDidLoad() {
        super.viewDidLoad();
        setupNavigationBar();
        layout();
        setup();
        setupLocation();
        fetchData();
        brain.delegate = self;
        confirm.delegate = self;
        fetchDataAndLoadViews();
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

//MARK: Actions
extension SummaryContainerViewController{
    @objc func logoutPressed (){
        confirm.presentAlert(title: "Are you sure for logout?", message: nil) {
            NotificationCenter.default.post(name: .logout, object: nil);
        }
    }
}
extension SummaryContainerViewController{
    private func setupLocation(){
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestLocation();
    }
    private func setup(){
        table.backgroundColor = appColor;
        table.showsVerticalScrollIndicator = false;
        table.delegate = self;
        table.dataSource = self;
        table.register(SummaryTableCell.self, forCellReuseIdentifier: SummaryTableCell.reuseId);
        table.allowsSelection = false;
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = .zero
        }
    }
    
    private func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutButton;
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
    private func fetchData() {
        let savings = SummaryModel(accountType: .Banking,
                                                            accountName: "Basic Savings",
                                                        balance: 929466.23)
        let chequing = SummaryModel(accountType: .Banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        let visa = SummaryModel(accountType: .CreditCard,
                                                       accountName: "Visa Avion Card",
                                                       balance: 412.83)
        let masterCard = SummaryModel(accountType: .CreditCard,
                                                       accountName: "Student Mastercard",
                                                       balance: 50.83)
        let investment1 = SummaryModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver",
                                                       balance: 2000.00)
        let investment2 = SummaryModel(accountType: .Investment,
                                                       accountName: "Growth Fund",
                                                       balance: 15000.00)

        accountCellViewModels.append(savings)
        accountCellViewModels.append(chequing)
        accountCellViewModels.append(visa)
        accountCellViewModels.append(masterCard)
        accountCellViewModels.append(investment1)
        accountCellViewModels.append(investment2)
    }
}
extension SummaryContainerViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableCell.reuseId, for: indexPath) as! SummaryTableCell;
        guard !accountCellViewModels.isEmpty else {return UITableViewCell()};
        let item = accountCellViewModels[indexPath.row];
        cell.configure(with: item);
        return cell;
    }
}

extension SummaryContainerViewController: UITableViewDelegate{
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
extension SummaryContainerViewController:CLLocationManagerDelegate {
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
extension SummaryContainerViewController:CanShowWeather{
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
//MARK: Get profile
extension SummaryContainerViewController{
    private func fetchDataAndLoadViews() {
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.summaryHeader.greetingsLabel.text = profile.greeting;
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SummaryContainerViewController:ConfirmAlertDelegate{
    func showConfirmDialog(alert: UIAlertController){
        present(alert,animated: true);
    }
}

    
        
    