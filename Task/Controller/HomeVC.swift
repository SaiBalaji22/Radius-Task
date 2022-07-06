//
//  ViewController.swift
//  Task
//
//  Created by Sai Balaji on 05/07/22.
//

import UIKit

class HomeVC: UIViewController {

    //MARK: - PROPERTIES
    private var Facilities = [Facility]()
    private var ExclusionList = [String]()
    
    private var FacitlityTableView: UITableView = {
        var tv = UITableView(frame: .zero, style: .plain)
        tv.register(CustomCell.self, forCellReuseIdentifier: CustomCell.CELL_ID)
        return tv
    }()
    
    //MARK: - LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(FacitlityTableView)
        FacitlityTableView.delegate = self
        FacitlityTableView.dataSource = self
        configureUI()
        getAPIData()
      
    }
    

    //MARK: - HELPERS
    func configureUI(){
        navigationItem.title = "Property App"
        view.backgroundColor = .systemBackground
        FacitlityTableView.translatesAutoresizingMaskIntoConstraints = false
        FacitlityTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        FacitlityTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        FacitlityTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        FacitlityTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func getAPIData(){
        NetworkService.Shared.getData { error, facility, exclusion in
            if let error  = error{
                print(error)
                self.showAlert(Message: error.localizedDescription)
            }
            if let facility = facility{
                self.Facilities = facility
                self.FacitlityTableView.reloadData()
            }
            
            if let exclusion = exclusion{
               // self.Exclusions = Array(exclusion.joined())
                for options in Array(exclusion.joined()){
                    if let OptionID = options.optionsID{
                        self.ExclusionList.append(OptionID)
                    }
                   
                }
            }
            
        }
    }


}

//MARK: - EXTENSIONS
extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Facilities.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Facilities[section].name
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Facilities[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.CELL_ID, for: indexPath) as? CustomCell{
            cell.updateCell(Name: Facilities[indexPath.section].options[indexPath.row].name!, ImageName: Facilities[indexPath.section].options[indexPath.row].icon!)
            return cell
        }
        return UITableViewCell()
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        if ExclusionList.contains(Facilities[indexPath.section].options[indexPath.row].id!){
            showAlert(Message: "Unable to select")
            cell?.backgroundColor = .red
            UIView.animate(withDuration: 1.0) {
                cell?.backgroundColor = .none
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let HeaderView = view as? UITableViewHeaderFooterView{
            HeaderView.textLabel?.text = Facilities[section].name?.uppercased()
            HeaderView.textLabel?.textColor = .black
            HeaderView.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
    
    func showAlert(Message: String){
        let avc = UIAlertController(title: "Info", message: Message, preferredStyle: .alert)
        avc.addAction(UIAlertAction(title: "OK", style: .default))
        present(avc, animated: true)
    }
}

