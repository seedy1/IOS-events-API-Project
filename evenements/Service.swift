//
//  Service.swift
//  evenements
//
//  Created by RAKOTONDRANORO Andriatiana Victor on 07/04/2021.
//

import Foundation

class Service {
    let baseUrl:String
    let path:String
    let auth:String
    //let urlBuilder: URLBuilder
    var url:String
    
    init(){
        baseUrl = Constants.BaseURL
        path = ""
        auth = Constants.AuthHeader + Constants.AuthKey
        url = ""
        buildPath()
    }
    
    init(pathParam:String){
        baseUrl = Constants.BaseURL
        path = pathParam
        auth = Constants.AuthHeader + Constants.AuthKey
        url = ""
        buildPath()
    }
    
    func buildPath(){
        url = baseUrl + path + auth
    }
    
    func getPath() -> String{
        return url
    }
}

class URLBuilder{
    
    var url:String
    init(){
        url = ""
    }
    init(urlString:String){
        url = urlString
    }
    
}
