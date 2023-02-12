//
//  NetworkConfig.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

enum UrlConfig: String {
    case DEV = "utm_source=GamingCenter_dev"
    case PROD = "utm_source=GamingCenter_prod"
}

class NetworkConfig {
    static let shared: NetworkConfig = NetworkConfig()
    
    var baseUrl: String?
    
    func setupNetworkConfig() {
        #if DEV
        baseUrl = UrlConfig.DEV.rawValue
        #elseif PROD
        baseUrl = UrlConfig.PROD.rawValue
        #endif
    }
}
