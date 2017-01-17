//
//  NetworkManager.swift
//  AcronymFinder
//
//  Created by Diamond on 1/16/17.
//  Copyright © 2017 ethanthomas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    var apiURL: URL!
    
    weak var delegate: NetworkManagerDelegate?
    
    func callApiWith(term: String) {
        apiURL = URL.init(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(term)")
        Alamofire.request(apiURL).responseJSON { (data) in
            if let d = data.result.value {
                let json = JSON(d)[0]["lfs"]
                var acronyms = [Acronym]()
                for js in json {
                    let acronym = Acronym.init(json: js.1)
                    acronyms.append(acronym)
                }
                self.delegate?.returnAPIResult(acronyms: acronyms)
            } else {
                self.delegate?.APIReturned(error: (data.result.error?.localizedDescription)!)
            }
        }
    }
}

protocol NetworkManagerDelegate: class {
    func returnAPIResult(acronyms: [Acronym])
    func APIReturned(error: String)
}
