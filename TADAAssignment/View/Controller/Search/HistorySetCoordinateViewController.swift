//
//  HistorySetCoordinateViewController.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 14/10/2021.
//

import UIKit

protocol HistorySetCoordinateViewControllerDelegate: NSObjectProtocol {
    func selectCoordinate(info: CoordinateTADA)
}

class HistorySetCoordinateViewController: BaseViewController {
    
    weak var delegate: HistorySetCoordinateViewControllerDelegate?
    let viewModel = HistorySetCoordinateViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }
    
    @IBAction func clickBtnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HistorySetCoordinateViewController {
    private func initView() {
        let bundle = Bundle(for: HistorySetCoordinateViewController.self)
        let nib = UINib(nibName: "CoordinateListTableViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: "CoordinateListTableViewCell")
        
        self.tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
        self.tableView.separatorStyle = .none
        
        btnCancel.backgroundColor = .gray
    }
}

extension HistorySetCoordinateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getTotalCoordinate()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoordinateListTableViewCell",
                                                    for: indexPath) as? CoordinateListTableViewCell {
            
            cell.setupCell(info: self.viewModel.getCoordinate(atIndex: indexPath.item))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: {
            self.delegate?.selectCoordinate(info: self.viewModel.getCoordinate(atIndex: indexPath.item))
        })
    }
}
