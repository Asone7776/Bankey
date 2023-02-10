//
//  SummaryControllerViewController.swift
//  Bankey
//
//  Created by Uzkassa on 10/02/23.
//

import UIKit

class SummaryControllerViewController: UIViewController {
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
    private func setup(){
        table.delegate = self;
        table.dataSource = self;
        table.register(SummaryTableCell.self, forCellReuseIdentifier: "cellId");
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SummaryTableCell;
        let item = games[indexPath.row];
        var content = cell.defaultContentConfiguration();
        content.text = item;
        cell.contentConfiguration = content;
        return cell;
    }
}

extension SummaryControllerViewController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SummaryHeader();
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 144;
    }
}

