//
//  SearchViewController.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fieldSearch: UITextField!
    
    let vm = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.data.bind { (_) in
            print("update \(self.vm.data.value.count)")
            self.tableView.reloadData()
        }.disposed(by: vm.disposeBag)
        fieldSearch.rx.text.orEmpty.bind(to: vm.query).disposed(by: vm.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension SearchViewController :UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = vm.data.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableCell
        cell.labelTitle.text = item.localName
        cell.labelDetail.text = "\(item.administrativeArea.nameArea) - \(item.country.nameArea)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.selectedLocation.accept(vm.data.value[indexPath.row])
    }
}

class SearchTableCell :UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    
}
