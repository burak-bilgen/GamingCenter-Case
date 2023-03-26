//
//  NetworkConfig.swift
//  Gaming Center
//
//  Created by Burak Bilgen on 12.02.2023.
//

import Foundation

enum UrlConfig: String {
    case DEV = "GamingCenter_dev"
    case PROD = "GamingCenter_prod"
}

class NetworkConfig {    
    static var utm: String?
    
    static func setupNetworkConfig() {
        #if DEV
        utm = UrlConfig.DEV.rawValue
        #elseif PROD
        utm = UrlConfig.PROD.rawValue
        #endif
    }
}
