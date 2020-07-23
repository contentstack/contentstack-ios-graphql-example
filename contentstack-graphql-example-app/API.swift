// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ProductsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Products($skip: Int = 0, $limit: Int) {
      all_product(locale: "en-us", skip: $skip, limit: $limit) {
        __typename
        items {
          __typename
          title
          description
          price
          featured_imageConnection(limit: 10) {
            __typename
            edges {
              __typename
              node {
                __typename
                ...AssetFile
              }
            }
          }
          categoryConnection {
            __typename
            edges {
              __typename
              node {
                __typename
                ... on Category {
                  category_type
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Products"

  public var queryDocument: String { return operationDefinition.appending(AssetFile.fragmentDefinition) }

  public var skip: Int?
  public var limit: Int?

  public init(skip: Int? = nil, limit: Int? = nil) {
    self.skip = skip
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["skip": skip, "limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("all_product", arguments: ["locale": "en-us", "skip": GraphQLVariable("skip"), "limit": GraphQLVariable("limit")], type: .object(AllProduct.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allProduct: AllProduct? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "all_product": allProduct.flatMap { (value: AllProduct) -> ResultMap in value.resultMap }])
    }

    /// Fetch multiple entries
    public var allProduct: AllProduct? {
      get {
        return (resultMap["all_product"] as? ResultMap).flatMap { AllProduct(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "all_product")
      }
    }

    public struct AllProduct: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AllProduct"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("items", type: .list(.object(Item.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: [Item?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllProduct", "items": items.flatMap { (value: [Item?]) -> [ResultMap?] in value.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Items of the content type queried
      public var items: [Item?]? {
        get {
          return (resultMap["items"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Item?] in value.map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Item?]) -> [ResultMap?] in value.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Product"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("price", type: .scalar(Int.self)),
            GraphQLField("featured_imageConnection", arguments: ["limit": 10], type: .object(FeaturedImageConnection.selections)),
            GraphQLField("categoryConnection", type: .object(CategoryConnection.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String? = nil, description: String? = nil, price: Int? = nil, featuredImageConnection: FeaturedImageConnection? = nil, categoryConnection: CategoryConnection? = nil) {
          self.init(unsafeResultMap: ["__typename": "Product", "title": title, "description": description, "price": price, "featured_imageConnection": featuredImageConnection.flatMap { (value: FeaturedImageConnection) -> ResultMap in value.resultMap }, "categoryConnection": categoryConnection.flatMap { (value: CategoryConnection) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Text field
        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        /// Text field
        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        /// Number field
        public var price: Int? {
          get {
            return resultMap["price"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "price")
          }
        }

        /// Asset field
        public var featuredImageConnection: FeaturedImageConnection? {
          get {
            return (resultMap["featured_imageConnection"] as? ResultMap).flatMap { FeaturedImageConnection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "featured_imageConnection")
          }
        }

        /// Multi reference
        public var categoryConnection: CategoryConnection? {
          get {
            return (resultMap["categoryConnection"] as? ResultMap).flatMap { CategoryConnection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "categoryConnection")
          }
        }

        public struct FeaturedImageConnection: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["AssetConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("edges", type: .list(.object(Edge.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(edges: [Edge?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "AssetConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Asset edges
          public var edges: [Edge?]? {
            get {
              return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
            }
          }

          public struct Edge: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["AssetEdge"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("node", type: .object(Node.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(node: Node? = nil) {
              self.init(unsafeResultMap: ["__typename": "AssetEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Asset node
            public var node: Node? {
              get {
                return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "node")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Asset"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(AssetFile.self),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(filename: String, url: String) {
                self.init(unsafeResultMap: ["__typename": "Asset", "filename": filename, "url": url])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var fragments: Fragments {
                get {
                  return Fragments(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }

              public struct Fragments {
                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var assetFile: AssetFile {
                  get {
                    return AssetFile(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }
            }
          }
        }

        public struct CategoryConnection: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ProductCategoryConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("edges", type: .list(.object(Edge.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(edges: [Edge?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "ProductCategoryConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Reference field edges
          public var edges: [Edge?]? {
            get {
              return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
            }
          }

          public struct Edge: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ProductCategoryEdge"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("node", type: .object(Node.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(node: Node? = nil) {
              self.init(unsafeResultMap: ["__typename": "ProductCategoryEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Reference nodes
            public var node: Node? {
              get {
                return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "node")
              }
            }

            public struct Node: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Category"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("category_type", type: .scalar(String.self)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(categoryType: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "Category", "category_type": categoryType])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Text field
              public var categoryType: String? {
                get {
                  return resultMap["category_type"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "category_type")
                }
              }
            }
          }
        }
      }
    }
  }
}

public struct CategoryFile: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment CategoryFile on Category {
      __typename
      category_type
      url
    }
    """

  public static let possibleTypes: [String] = ["Category"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("category_type", type: .scalar(String.self)),
      GraphQLField("url", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(categoryType: String? = nil, url: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Category", "category_type": categoryType, "url": url])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Text field
  public var categoryType: String? {
    get {
      return resultMap["category_type"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "category_type")
    }
  }

  /// Text field
  public var url: String? {
    get {
      return resultMap["url"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "url")
    }
  }
}

public struct AssetFile: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment AssetFile on Asset {
      __typename
      filename
      url
    }
    """

  public static let possibleTypes: [String] = ["Asset"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("filename", type: .nonNull(.scalar(String.self))),
      GraphQLField("url", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(filename: String, url: String) {
    self.init(unsafeResultMap: ["__typename": "Asset", "filename": filename, "url": url])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// Asset filename
  public var filename: String {
    get {
      return resultMap["filename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "filename")
    }
  }

  /// Asset url
  public var url: String {
    get {
      return resultMap["url"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "url")
    }
  }
}
