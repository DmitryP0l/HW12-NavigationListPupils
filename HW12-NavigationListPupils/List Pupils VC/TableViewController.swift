//
//  TableViewController.swift
//  HW12-NavigationListPupils
//
//  Created by lion on 30.10.21.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    
    private var dataSourcePupils: [ModelPupilsData] = [
        ModelPupilsData(pupilNameString: "Rob", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "John", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Fransis", pupilClassString: "B"),
        ModelPupilsData(pupilNameString: "Robin", pupilClassString: "D"),
        ModelPupilsData(pupilNameString: "Baddy", pupilClassString: "C"),
        ModelPupilsData(pupilNameString: "Clar", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Ozzy", pupilClassString: "B"),
        ModelPupilsData(pupilNameString: "Kolya", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Billy", pupilClassString: "C"),
        ModelPupilsData(pupilNameString: "Bob", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Misha", pupilClassString: "A"),
        ModelPupilsData(pupilNameString: "Joy", pupilClassString: "B"),
        ModelPupilsData(pupilNameString: "Frank", pupilClassString: "D"),
        ModelPupilsData(pupilNameString: "Vasua", pupilClassString: "E"),
        ModelPupilsData(pupilNameString: "Ostin", pupilClassString: "A")
    ]
    private let namePupilsArray: [String] = [
        "James", "Mary", "John", "Patricia", "Robert", "Linda", "Michael", "Barbara","William",
        "Elizabeth", "David", "Jennifer", "Richard", "Maria", "Charles","Susan", "Joseph",
        "Margaret", "Thomas", "Dorothy", "Christopher", "Lisa","Daniel", "Nancy" ,"Paul", "Karen",
        "Mark", "Betty", "Donald", "Helen","George", "Sandra", "Kenneth", "Donna", "Steven", "Carol",
        "Edward", "Ruth", "Brian", "Sharon", "Jacob", "Emma", "Michael", "Isabella", "Ethan", "Emily"
    ]
    private var classesArray: [String] {
        let pupilClassesArray = dataSourcePupils.compactMap({ $0.pupilClassString })
        let set = Set(pupilClassesArray)
        return set.sorted()
    }
    
    
    @IBAction func newPupilPressed(_ sender: UIButton) {
        let randomName = randomGenerateNameString()
        dataSourcePupils += randomName
        tableView.reloadData()
    }
    
    @IBAction func newPupilfromArrayPressed(_ sender: UIButton) {
        let charactersOne = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomCharactersOne = String(charactersOne.randomElement()!)
        let randomNameArray = String(namePupilsArray.randomElement() ?? "Name")
        let randomArray:[ModelPupilsData] = [
            ModelPupilsData(pupilNameString: randomNameArray, pupilClassString: randomCharactersOne)
        ]
        dataSourcePupils += randomArray
        tableView.reloadData()
        
        
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        view.backgroundColor = .black
        
        tableView.register(UINib(nibName: "ProfilePupilsCells", bundle: nil), forCellReuseIdentifier: ProfilePupilsCells.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Table of Pupils"
        
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
    
    private func filterStudentsFor(classString: String) -> [ModelPupilsData] {
        let filtered = dataSourcePupils.filter({$0.pupilClassString == classString})
        return filtered
    }
    
    
    func randomGenerateNameString() -> ([ModelPupilsData]) {
        let length = Int.random(in: 3...7)
        let charactersOne = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let characters = "abcdefghijklmnopqrstuvwxyz"
        
        let randomCharactersOne = String(charactersOne.randomElement()!)
        let randomCharacters = (1..<length).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        let randomName = randomCharactersOne + randomString
        
        let randomArray:[ModelPupilsData] = [
            ModelPupilsData(pupilNameString: randomName, pupilClassString: randomCharactersOne)
        ]
        return randomArray
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return classesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let classString = classesArray[section]
        let pupils = filterStudentsFor(classString: classString)
        return pupils.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .black
        let label = UILabel(frame: CGRect(x: 0, y: 15,
                                          width: tableView.frame.size.width,
                                          height: 20))
        label.text = classesArray[section]
        label.textAlignment = .center
        label.textColor = .white
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .black
        
        let classString = classesArray[section]
        let pupils = filterStudentsFor(classString: classString)
        let pupilsCount = "Class Pupils Count: \(pupils.count)"
        let scoring = pupils.compactMap({ $0.pupilScoreInt }).reduce(0, +)
        let pupilsScoring = "Average Pupils Scoring: \(scoring / pupils.count)"
        
        let label = UILabel(frame: CGRect(x: 0, y: 25,
                                          width: tableView.frame.width,
                                          height: 20))
        label.text = pupilsCount
        label.textAlignment = .center
        label.textColor = .white
        
        let secondLabel = UILabel(frame: CGRect(x: 0, y: 45,
                                          width: tableView.frame.width,
                                          height: 20))
        secondLabel.text = pupilsScoring
        secondLabel.textAlignment = .center
        secondLabel.textColor = .white

        footer.addSubview(label)
        footer.addSubview(secondLabel)
    
        let separator = UIView(frame: CGRect(x: 0,
                                             y: 99,
                                             width: tableView.frame.width, height: 1))
        separator.backgroundColor = .gray
        footer.addSubview(separator)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePupilsCells.identifier, for: indexPath) as! ProfilePupilsCells
        let classString = classesArray[indexPath.section]
        let pupils = filterStudentsFor(classString: classString)
        cell.makeProfileCellBy(model: pupils[indexPath.row])
        
        return cell
    }
    
    
    
    
    
    
    
}
