//
//  ViewController.swift
//  ReacitveRepositories
//
//  Created by Svyatoslav Titov on 20.06.2020.
//  Copyright © 2020 Svyatoslav Titov. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    
    private var items: [Record] = []
    private let cellReuseIdentifier = "infoCell"
    private var recordRepository = RecordRepository()
    
    private var reloadTableCanceble: AnyCancellable!
    private var filterChangeCanceble: AnyCancellable!
    
    @Published var filter: String?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! RecordTableViewCell
        
        cell.infoLabel.text = items[indexPath.row].name
        
        return cell
    }
    
    //MARK: lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        filterLabel.addTarget(self, action: #selector(ViewController.filterTextChanged(_:)), for: .editingChanged)
        
        filterChangeCanceble = $filter.sink(receiveCompletion: {error in print(error)}, receiveValue: { self.changeFilter($0) })
        
        reloadTableCanceble = recordRepository.connect(predicate: { item in  self.filter == nil ? true : (item.name?.contains(self.filter!) ?? true) })
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { print($0) }, receiveValue: { self.reloadTablewView($0) })
    }
    
    @objc func filterTextChanged(_ textField: UITextField){
        filter = textField.text
    }
    
    private func changeFilter(_ filter: String?){
        let records = recordRepository.read({ ($0.name?.contains(filter!) ?? true) })
        
        reloadTablewView(records)
    }
    
    private func reloadTablewView(_ records: [Record]){
        self.items = records
        
        tableView.reloadData()
    }
    
    @IBAction func onAddClick(_ sender: Any) {
        let record = Record(nameLabel.text)
        recordRepository.create(record)
    }
}

