//  This file was automatically generated and should not be edited.

import Apollo

public final class ProductsQuery: GraphQLQuery {
  public let operationDefinition =
    "query Products($skip: Int = 0, $limit: Int) {\n  all_product(locale: \"en-us\", skip: $skip, limit: $limit) {\n    __typename\n    items {\n      __typename\n      title\n      description\n      price\n      featured_image {\n        __typename\n        ...Asset\n      }\n    }\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(Asset.fragmentDefinition) }

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
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("all_product", arguments: ["locale": "en-us", "skip": GraphQLVariable("skip"), "limit": GraphQLVariable("limit")], type: .object(AllProduct.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allProduct: AllProduct? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "all_product": allProduct.flatMap { (value: AllProduct) -> ResultMap in value.resultMap }])
    }

    public var allProduct: AllProduct? {
      get {
        return (resultMap["all_product"] as? ResultMap).flatMap { AllProduct(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "all_product")
      }
    }

    public struct AllProduct: GraphQLSelectionSet {
      public static let possibleTypes = ["AllProduct"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .list(.object(Item.selections))),
      ]

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

      public var items: [Item?]? {
        get {
          return (resultMap["items"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Item?] in value.map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Item?]) -> [ResultMap?] in value.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } } }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Product"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("price", type: .scalar(Double.self)),
          GraphQLField("featured_image", type: .list(.object(FeaturedImage.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String? = nil, description: String? = nil, price: Double? = nil, featuredImage: [FeaturedImage?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Product", "title": title, "description": description, "price": price, "featured_image": featuredImage.flatMap { (value: [FeaturedImage?]) -> [ResultMap?] in value.map { (value: FeaturedImage?) -> ResultMap? in value.flatMap { (value: FeaturedImage) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var price: Double? {
          get {
            return resultMap["price"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "price")
          }
        }

        public var featuredImage: [FeaturedImage?]? {
          get {
            return (resultMap["featured_image"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [FeaturedImage?] in value.map { (value: ResultMap?) -> FeaturedImage? in value.flatMap { (value: ResultMap) -> FeaturedImage in FeaturedImage(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [FeaturedImage?]) -> [ResultMap?] in value.map { (value: FeaturedImage?) -> ResultMap? in value.flatMap { (value: FeaturedImage) -> ResultMap in value.resultMap } } }, forKey: "featured_image")
          }
        }

        public struct FeaturedImage: GraphQLSelectionSet {
          public static let possibleTypes = ["Assets"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(Asset.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(filename: String? = nil, fileSize: String? = nil, url: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Assets", "filename": filename, "file_size": fileSize, "url": url])
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

            public var asset: Asset {
              get {
                return Asset(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public struct Asset: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment Asset on Assets {\n  __typename\n  filename\n  file_size\n  url\n}"

  public static let possibleTypes = ["Assets"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("filename", type: .scalar(String.self)),
    GraphQLField("file_size", type: .scalar(String.self)),
    GraphQLField("url", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(filename: String? = nil, fileSize: String? = nil, url: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Assets", "filename": filename, "file_size": fileSize, "url": url])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var filename: String? {
    get {
      return resultMap["filename"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "filename")
    }
  }

  public var fileSize: String? {
    get {
      return resultMap["file_size"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "file_size")
    }
  }

  public var url: String? {
    get {
      return resultMap["url"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "url")
    }
  }
}