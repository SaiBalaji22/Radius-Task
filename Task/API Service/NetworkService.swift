//
//  NetworkService.swift
//  Task
//
//  Created by Sai Balaji on 05/07/22.
//

import Foundation


class NetworkService{
    static var Shared = NetworkService()
    private var session = URLSession(configuration: .default)
    
    func getData(onCompletion:@escaping(Error?,[Facility]?,[[Exclusion]]?)->(Void)){
        let task = session.dataTask(with: URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")!) { data, resp, error in
            DispatchQueue.main.async {
                if error != nil{
                    onCompletion(error,nil,nil)
                }
                if let data = data{
                    do{
                        let DecodedData = try JSONDecoder().decode(Response.self, from: data)
                        onCompletion(nil,DecodedData.facilities,DecodedData.exclusions)
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                 
                }
            }
          
        }
        task.resume()
    }
}
