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
        title = "Summary";
        navigationController?.navigationBar.prefersLargeTitles = true;
        style(); 
        layout();
        setup();
    }
}

extension SummaryControllerViewController{
    private func setup(){
        table.delegate = self;
        table.dataSource = self;
        table.register(SummaryTableCell.self, forCellReuseIdentifier: "cellId");
        table.allowsSelection = false;
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
     func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Header \(section)"
    }

    // Create a standard footer that includes the returned text.
     func tableView(_ tableView: UITableView, titleForFooterInSection
                                section: Int) -> String? {
       return "Footer \(section)"
    }
}
