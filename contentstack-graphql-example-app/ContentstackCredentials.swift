//
//  ContentstackCredentials.swift
//  contentstack-graphql-example-app
//
//  Created by Uttam Ukkoji on 02/01/19.
//  Copyright © 2019 Contentstack. All rights reserved.
//

import Foundation
import Apollo

struct ContentstackCredentials: Codable, Equatable {
    
    let apiKey: String
    let deliveryAPIAccessToken: String
    let environmentToken: String
    let domainHost: String
    
    static let `default`: ContentstackCredentials = {
        guard let bundleInfo = Bundle.main.infoDictionary else { fatalError() }
        
        let apiKey = bundleInfo["CONTENTSTACK_API_KEY"] as! String
        let deliveryAPIAccessToken = bundleInfo["CONTENTSTACK_DELIVERY_TOKEN"] as! String
        let environment = bundleInfo["CONTENTSTACK_ENVIRONMENT"] as! String
        let domainHost = bundleInfo["CONTENTSTACK_HOST_NAME"] as! String

        let credentials = ContentstackCredentials(apiKey: apiKey, deliveryAPIAccessToken: deliveryAPIAccessToken, environmentToken: environment, domainHost: domainHost)
        return credentials
    }()
    
}
