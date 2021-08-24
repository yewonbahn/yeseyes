//
//  CUSearchViewController.swift
//  YES_EYES
//
//  Created by mgpark on 2021/07/29.
//

import UIKit
import FirebaseDatabase
import Speech

//class CUSearchCell : UITableViewCell{
//    @IBOutlet weak var SearchLabel: UILabel!
//
//}

class CUSearchViewController: UIViewController, SFSpeechRecognizerDelegate {
    @IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var speechbutton: UIButton!
    
    private var cuSearchViewController: CUSearchViewController?
    private var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupNavigationBarTitle()
        speechRecognizer?.delegate = self
    }

    private func setupNavigationBarTitle() {
        title = "상품 검색"
    }
    //
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
        
    @IBAction func speechToText(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            speechbutton.isEnabled = false
            speechbutton.setTitle("음성 녹음", for: .normal)
        } else {
            startRecording()
            speechbutton.setTitle("녹음 중지", for: .normal)
        }
    }

    @IBOutlet weak var cuTextView: UITextView!
    
    func startRecording() {
            
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("ERROR")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode;
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("ERROR")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                self.cuTextView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.speechbutton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("ERROR")
        }
        cuTextView.text = "음성 녹음을 켜 원하시는 상품을 말씀하세요."
    }
   
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            speechbutton.isEnabled = true
        } else {
            speechbutton.isEnabled = false
        }
    }
}

extension CUSearchViewController {
    private func setupSearchBar() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "검색 창"
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.frame = searchBarContainerView.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainerView.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
}

extension CUSearchViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }
}

extension CUSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        print(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
}


//ref = Database.database().reference()
//ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            let values = snapshot.value
//            let dic = values as! [String: [String:Any]]
//            for index in dic{
//               if (index.value["name"] as! String == "zedd"){
//                print(index.key)
//                print(index.value["content"])
//                print(index.value["name"])
//                print(index.value["location"])
//                }
//            }
//
//        })






//
//struct CUSearchModel{
//    var CUtitle = ""
//    var price = ""
//    var info = ""
//}
//
//class CUSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var CUSearchBarContainerView: UIView!
////    @IBOutlet weak var CUSearchBar: UISearchBar!
//
//    private var cuTableViewController: CUTableViewController?
//    private var searchController: UISearchController = {
//        return UISearchController(searchResultsController: nil)
//
//    var model = [[CUSearchModel]]()
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // section 별 개수 출력
//        return model[section].count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // 상품 데이터 개수만큼 라벨 출력
//        return model.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
//        as! ItemCell
//
//        // 상품명과 가격 값을 라벨에 표시
//        cell.Title.text = model[indexPath.section][indexPath.row].CUtitle
//        cell.Price.text = model[indexPath.section][indexPath.row].price
////        tableView.deselectRow(at: indexPath, animated: true)
//        return cell
//    }
//
//    @IBOutlet weak var CUSearchTableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        CUSearchBar.delegate = self;
//
//        CUSearchTableView.delegate = self
//        CUSearchTableView.dataSource = self
//        CUSearchTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell") // ItemCell xib 등록
//
//        self.title = "CU"
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        let ref: DatabaseReference! = Database.database().reference()
//        // var handle: DatabaseHandle!
//
//        ref.child("cu").child("instant").observeSingleEvent(of: .value) { (snapshot) in
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//
//                let item = snap.value as! [String: Any]
//
//                let CUtitle = item["title"] ?? ""
//                let price = item["price"] ?? ""
//                let info = item["info"] ?? ""
//
//                self.model.append([CUSearchModel(CUtitle: CUtitle as! String, price: price as! String, info: info as! String)])
//            }
//            self.CUSearchTableView.reloadData()
//        }
//    }
//}

//extension CUSearchViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
//        searchController.isActive = false
//        print(searchText)
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel")
//    }
//}

//
////
////  CUSearchViewController.swift
////  YES_EYES
////
////  Created by mgpark on 2021/08/05.
////
//// CU_Search
//
//import UIKit
//import FirebaseDatabase
//
//class CUSearchCell : UITableViewCell{
//    @IBOutlet weak var topLabel: UILabel!
//}
//
//struct CUModel{
//    var title = ""
//    var price = ""
//    var info = ""
//}
//
//class CUSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var model = [[CUModel]]()
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model[section].count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return model.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
//        as! ItemCell
//
//        cell.Title.text = model[indexPath.section][indexPath.row].title
//        cell.Price.text = model[indexPath.section][indexPath.row].price
//
//        return cell
//    }
//
//    @IBOutlet weak var CUSearchTableView: UITableView!
//
//    var text: String = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        CUSearchTableView.delegate = self
//        CUSearchTableView.dataSource = self
//
//        self.title = "[CU] 상품 검색"
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        CUSearchTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell") // ItemCell xib 등록
//
//        var route: String = ""
//
//        if text == "0" { route = "drink" }
//        else if text == "1" { route = "snack" }
//        else if text == "2" { route = "icecream" }
//        else if text == "3" { route = "food" }
//
//        let ref: DatabaseReference! = Database.database().reference()
//        // var handle: DatabaseHandle!
//
//        ref.child("cu").child(route).observeSingleEvent(of: .value) { (snapshot) in
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//
//                let item = snap.value as! [String: Any]
//
//                let title = item["title"] ?? ""
//                let price = item["price"] ?? ""
//                let info = item["info"] ?? ""
//
//                self.model.append([CUModel(title: title as! String, price: price as! String, info: info as! String)])
//            }
//            self.CUSearchTableView.reloadData()
//        }
//    }
//}


////
////  CUViewController.swift
////  YES_EYES
////
////  Created by mgpark on 2021/07/29.
////
//// CU_category_item
//
//import UIKit
//import FirebaseDatabase
//
//class CUSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var text: String = ""
//    var product:Dictionary<String, String> = [String: String]()
//
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        let vc = segue.destination as! CU1ViewController
////        let cell = sender as! UITableViewCell
////        let indexPath = tableView.indexPath(for: cell)
////        vc.kindTitle = infoList[(indexPath?.row)!]//내가누른 cell의 text
////        vc.kindRow = (indexPath?.row)!//내가누른 cell의 row값
////    }
////
////    @IBAction func pop(_ sender: Any, for segue: UIStoryboardSegue) {
////
////        let storyboard = UIStoryboard.init(name: "Popup", bundle: nil)
////        let popUp = storyboard.instantiateViewController(identifier: "Popup")
////
////        popUp.modalPresentationStyle = .overCurrentContext
////        popUp.modalTransitionStyle = .crossDissolve
////
////        var index: Int = 0
////        self.delegate?.pop(index: index)
////
////        let temp = popUp as? PopupViewController
////
////        let vc = segue.destination as! CU1ViewController
////        let cell = sender as! ItemCell
////        let indexPath = tableView.indexPath(for: cell)
////        vc.kindTitle = infoList[(indexPath?.row)!]//내가누른 cell의 text
////
////        temp?.strText = "123"
////
////        self.present(popUp, animated: true,
////            completion: nil)
////    }
////
//    var model = [CU1Model]()
//    let searchController = UISearchController(searchResultsController: nil)
//
//    var filtereditem = [CU1Model]()
//
//    func isFiltering() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filtereditem.count
//        }
//        return model.count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // 상품 데이터 개수만큼 라벨 출력
//        return model.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
//        as! ItemCell
//
//        let tmpItem: CU1Model
//
//        if isFiltering() {
//            tmpItem = filtereditem[indexPath.row]
//        } else {
//            tmpItem = model[indexPath.row]
//        }
//
//        // 상품명과 가격 값을 라벨에 표시
//        cell.Title.text = tmpItem.title
//        cell.Price.text = tmpItem.price
////        tableView.deseFlectRow(at: indexPath, animated: true)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // performSegue(withIdentifier: "Popup", sender: nil)
//
//        let storyboard = UIStoryboard.init(name: "Popup", bundle: nil)
//        let popUp = storyboard.instantiateViewController(identifier: "Popup")
//
//        popUp.modalPresentationStyle = .overCurrentContext
//        popUp.modalTransitionStyle = .crossDissolve
//
//        let temp = popUp as? PopupViewController
//        temp?.strText = model[indexPath.row].info
//
//        self.present(popUp, animated: true, completion: nil)
//    }
//    @IBOutlet weak var CU1SearchBar: UISearchBar!
//    @IBOutlet weak var CU1TableView: UITableView!
//
//    func searchBarIsEmpty() -> Bool {
//      // Returns true if the text is empty or nil
//      return searchController.searchBar.text?.isEmpty ?? true
//    }
//
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//      filtereditem = model.filter({( item : CU1Model ) -> Bool in
//        return item.title.contains(searchText)
//      })
//
//      CU1TableView.reloadData()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//
//        CU1TableView.delegate = self
//        CU1TableView.dataSource = self
//        CU1SearchBar.delegate = self
//
//        CU1TableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell") // ItemCell xib 등록
//
//        self.title = "CU"
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        let ref: DatabaseReference! = Database.database().reference()
//        // var handle: DatabaseHandle!
//
//        var route: String = ""
//
//        if text == "0" { route = "drink" }
//        else if text == "1" { route = "snack" }
//        else if text == "2" { route = "icecream" }
//        else if text == "3" { route = "food" }
//
//        ref.child("cu").child(route).observeSingleEvent(of: .value) { (snapshot) in
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//
//                let item = snap.value as! [String: Any]
//
//                let title = item["title"] ?? ""
//                let price = item["price"] ?? ""
//                let info = item["info"] ?? ""
//
//                self.model.append(CU1Model(title: title as! String, price: price as! String, info: info as! String))
//                self.product[title as! String] = info as? String
//            }
//            print("123123")
//            self.CU1TableView.reloadData()
//        }
//        // 추후 함수 분리할 수 있으니 하단 주석은 남겨 둡니다.
//    }
//}
//
////func getData() {
////
////    var model = [[CU1Model]]()
////    let ref: DatabaseReference! = Database.database().reference()
////    var handle: DatabaseHandle!
////
////    handle = ref.child("cu").child("instant").observeSingleEvent(of: .value, with: { (snapshot) in
////        for child in snapshot.children {
////            let snap = child as! DataSnapshot
////
////            let item = snap.value as! [String: Any]
////
////            let title = item["title"] ?? ""
////            let price = item["price"] ?? ""
////            let info = item["info"] ?? ""
////
////            self.model.append([CU1Model(title: title as! String, price: price as! String, info: info as! String)])
////        }
////        // print(model)
////    })
//
///*
//for i in range() {
//    model.append([CU1Model(title: "상품이름", price: "상품가격")])
//    // 데이터를 받아와서 이 형식으로 반복문 생성하면 에뮬레이터 화면에 상품명과 상품가격이 뜸
// }
//*/
//
////}
//
//extension CUSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
//  // MARK: - UISearchResultsUpdating Delegate
//  func updateSearchResults(for searchController: UISearchController) {
//    filterContentForSearchText(searchController.searchBar.text!)
//  }
//}
//
////extension CU1ViewController: UISearchBarDelegate{
////    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        guard let title: String = searchBar.text else { return }
////        print(title)
////
////        let databaseRef = Database.database().reference().child("cu")
////        let query = databaseRef.queryOrdered(byChild: "title").queryStarting(atValue: title).queryEnding(atValue: "\(String(describing: title))\\uf8ff")
////
////        query.observeSingleEvent(of: .value) { (snapshot) in
////            guard snapshot.exists() != false else {
////                print("failing here")
////                return }
////            print(snapshot.value as Any)
////            DispatchQueue.main.async {
////
////                guard let dict = snapshot.value as? [String:Any] else {
////                    print(snapshot)
////                    return
////                }
////
////                let title = dict["title"] as? String
////                let price = dict["price"] as? String
////            }
////        }
////    }
////}
