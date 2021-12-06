//
//  LeaveDetailsViewController.swift
//  MascoAutomationApp
//
//  Created by masco bazar on 6/12/21.
//

import UIKit

class LeaveDetailsViewController: UIViewController {

    @IBOutlet weak var headerView: CommonHeaderView!
    @IBOutlet weak var footerView: CommonFooter!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class func initWithStoryboard() -> LeaveDetailsViewController
    {
        let storyboard = UIStoryboard(name: "LeaveDetails", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LeaveDetailsViewController.className) as! LeaveDetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.style = .large
        indicator.color = .red
        
        getLeaveDetails()

        self.headerView.backBtnHandler = {
            [weak self] (isShow) in
            guard let weakSelf = self else {
            return
         }
         weakSelf.showBackController()
        }
    }
    
    func showBackController(){
        let controller = LeaveViewController.initWithStoryboard()
        self.present(controller, animated: true, completion: nil);
    }
    
    
    func getLeaveDetails(){
        
        let utils = Utils()
        let accessToken = utils.readStringData(key: "token")
        
        
        let url = URL(string: LEAVE_HISTORY_URL)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let newTodoItem = LeaveDetailRequestModel(finalYear: 8)
        let jsonData = try? JSONEncoder().encode(newTodoItem)
        
        request.httpBody = jsonData

        print("jsonData jsonData  data:\n \(jsonData!)")
        indicator.startAnimating()
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                
                    
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    guard let data = data else {return}

                    do{
                        
                        let todoItemModel = try JSONDecoder().decode(LeaveDetailsResponse.self, from: data)
                        print("Response data:\n \(todoItemModel)")
                        print("todoItemModel error: \(todoItemModel.error)")
                        
                      
                        
                        for leaveHistoryformatList in todoItemModel._LeaveHistoryformatList {
                            
                            print("------type_name -----: \(leaveHistoryformatList.type_name)")
                            print("------cl -----: \(leaveHistoryformatList.cl)")
                            print("----sl -----: \(leaveHistoryformatList.sl)")
                            print("----el -----: \(leaveHistoryformatList.el)")
                            
                        }
                        
//                        if !self.empCodeString.isEmpty{
//                            let controller = HomeViewController.initWithStoryboard()
//                            self.present(controller, animated: true, completion: nil);
//                            print("----error: \("Success")----")
//                        }else{
//                                print("----error: \(todoItemModel.error)----")
//                        }
                        
                    }catch let jsonErr{
                        print(jsonErr)
                   }
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    self.getYearList()
                }
               
        }
     
        task.resume()
       
    }


func getYearList(){
    
    let url = URL(string: YEAR_URL)
    guard let requestUrl = url else { fatalError() }
    
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "GET"
    
    // Set HTTP Request Header
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    self.indicator.isHidden = false
    indicator.startAnimating()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
            
                
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                guard let data = data else {return}

                do{
                    
                    let todoItemModel = try JSONDecoder().decode(ListFinalYearResponse.self, from: data)
                    print("Response data:\n \(todoItemModel)")
                    print("todoItemModel error: \(todoItemModel.error)")
                    
                  
                    
                    for leaveHistoryformatList in todoItemModel._listFinalYear {
                        
                        print("------type_finalYearNamename -----: \(leaveHistoryformatList.finalYearName)")
                        print("------yearName -----: \(leaveHistoryformatList.yearName)")
                        print("----finalYearNo -----: \(leaveHistoryformatList.finalYearNo!)")
                       
                        
                    }
                    
//                        if !self.empCodeString.isEmpty{
//                            let controller = HomeViewController.initWithStoryboard()
//                            self.present(controller, animated: true, completion: nil);
//                            print("----error: \("Success")----")
//                        }else{
//                                print("----error: \(todoItemModel.error)----")
//                        }
                    
                }catch let jsonErr{
                    print(jsonErr)
               }
                self.indicator.isHidden = true
                self.indicator.stopAnimating()
            }
    }
 
    task.resume()
}
}

extension LeaveDetailsViewController{
    
    struct LeaveDetailRequestModel: Codable {
        var finalYear: Int
        
        enum CodingKeys: String, CodingKey {
            case finalYear = "finalYear"
        }
    }
    
    struct LeaveDetailsResponse: Codable {
        var error: String = ""
        var _LeaveHistoryformatList : [LeaveHistoryformatList]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _LeaveHistoryformatList
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._LeaveHistoryformatList = try container.decodeIfPresent([LeaveHistoryformatList].self, forKey: ._LeaveHistoryformatList) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_LeaveHistoryformatList, forKey: ._LeaveHistoryformatList)
            }

    }
    
    struct LeaveHistoryformatList: Codable {
        var type_name: String = ""
        var cl: String = ""
        var sl: String = ""
        var el: String = ""
        
        enum CodingKeys: String, CodingKey {
            case type_name = "type_name"
            case cl = "cl"
            case sl = "sl"
            case el = "el"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.type_name = try container.decodeIfPresent(String.self, forKey: .type_name) ?? ""
               self.cl = try container.decodeIfPresent(String.self, forKey: .cl) ?? ""
               self.sl = try container.decodeIfPresent(String.self, forKey: .sl) ?? ""
               self.el = try container.decodeIfPresent(String.self, forKey: .type_name) ?? ""
            
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(type_name, forKey: .type_name)
               try container.encode(cl, forKey: .cl)
               try container.encode(sl, forKey: .sl)
               try container.encode(el, forKey: .el)
           }
    }
    
    
    struct ListFinalYearResponse: Codable {
        var error: String = ""
        var _listFinalYear : [ListFinalYear]

        enum CodingKeys: String, CodingKey {
            case error = "error"
            case _listFinalYear
        }
        
         init(from decoder: Decoder) throws {

                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.error = try container.decodeIfPresent(String.self, forKey: .error) ?? ""
                self._listFinalYear = try container.decodeIfPresent([ListFinalYear].self, forKey: ._listFinalYear) ?? []
            }

            func encode(to encoder: Encoder) throws {

                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(error, forKey: .error)
                try container.encode(_listFinalYear, forKey: ._listFinalYear)
            }

    }
    
    
    struct ListFinalYear: Codable {
        var finalYearNo: Int?
        var finalYearName: String = ""
        var yearName: String = ""
        
        enum CodingKeys: String, CodingKey {
            case finalYearNo = "finalYearNo"
            case finalYearName = "finalYearName"
            case yearName = "yearName"
        }
        
        init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: CodingKeys.self)
               self.finalYearNo = try container.decodeIfPresent(Int.self, forKey: .finalYearNo) ?? 0
               self.finalYearName = try container.decodeIfPresent(String.self, forKey: .finalYearName) ?? ""
               self.yearName = try container.decodeIfPresent(String.self, forKey: .yearName) ?? ""
            
           }

           func encode(to encoder: Encoder) throws {

               var container = encoder.container(keyedBy: CodingKeys.self)
               try container.encode(finalYearNo, forKey: .finalYearNo)
               try container.encode(finalYearName, forKey: .finalYearName)
               try container.encode(yearName, forKey: .yearName)
           }
    }
}
