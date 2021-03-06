//
//  ContentstackService.swift
//  contentstack-graphql-example-app
//
//  Created by Uttam Ukkoji on 07/01/19.
//  Copyright © 2019 Contentstack. All rights reserved.
//

import Foundation
import Apollo

class ContentstackService {
    let graphQLClient: ApolloClient
    
    init(credentials: ContentstackCredentials = ContentstackCredentials.default) {
        let url = URL(string: "https://\(credentials.domainHost)/stacks/\(credentials.apiKey)?environment=\(credentials.environmentToken)")!
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["access_token": credentials.deliveryAPIAccessToken]
        self.graphQLClient = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, client: URLSessionClient(sessionConfiguration: configuration)))
    }
}
