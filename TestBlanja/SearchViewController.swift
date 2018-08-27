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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
