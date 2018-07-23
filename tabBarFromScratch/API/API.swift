//
//  API.swift
//  tabBarFromScratch
//
//  Created by cems ios on 7/23/18.
//  Copyright © 2018 cems ios. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class API{

    class func getSquare(completion: @escaping (_ error :Error? , _ data :[CellInfo]?, _ json :JSON? )->Void){

        let url = "https://apiflickr.photos.search.flickr.com/services/rest/?method=&api_key=7d39607e230c3c34261838a692bfd11b&page=1&format=json&nojsoncallback=1&auth_token=72157669410928917-5abe10ac880774bc&api_sig=8e18dca6cfaed886ca05b16a4db371c7"

        Alamofire.request(url, method: .get).responseJSON { response in

            switch response.result{

            case .failure(let error):

                completion(error, nil, nil)
                print(error)

            case .success(let value):

                let json = JSON(value)
                
                print(json)

                guard let jsonArr = json["photos"]["photo"].array else{

                    completion(nil, nil, json)

                    return
                }

                var repos = [CellInfo]()

                for item in jsonArr {

                    let repo = CellInfo(with: item)
                    repos.append(repo)
                }

                completion(nil, repos, json)
            }
        }
    }
}
