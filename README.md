# Build an example app using Contentstack GraphQL API, and Apollo Client

We have created a sample product catalog app that is built using Apollo Client iOS SDK. The content of this app is powered by Contentstack GraphQL APIs, and the app uses Apollo client on the client side to consume GraphQL APIs.

This document covers the steps to get this app up and running for you. Try out the app and play with it, before building bigger and better applications.

<img src='https://github.com/contentstack/contentstack-ios-graphql-example/raw/master/contentstack-graphql-example-app/ProductList.png' width='320' height='690'/>


## Prerequisite

-   [Xcode 10.1 and later](https://developer.apple.com/xcode)
-   Mac OS X 10.14 and later
-   [Contentstack account](https://www.app.contentstack.com/)
-   [Basic knowledge of Contentstack](https://www.contentstack.com/docs/)

## Step 1: Create a stack
Log in to your Contentstack account, and [create a new stack](https://www.contentstack.com/docs/guide/stack#create-a-new-stack). Read more about [stack](https://www.contentstack.com/docs/guide/stack).

## Step 2: Add a publishing environment
[Add a publishing environment](https://www.contentstack.com/docs/guide/environments#add-an-environment) to publish your content in Contentstack. Provide the necessary details as per your requirement. Read more about [environments](https://www.contentstack.com/docs/guide/environments).

## Step 3: Import content types
For this app, we need one content type: Product. Here’s what it is needed for:  
  
-   **Product**: Lets you add the product content into your app.    

For quick integration, we have already created the content type. [Download the content](https://github.com/contentstack/contentstack-ios-graphql-example) types and [import](https://www.contentstack.com/docs/guide/content-types#importing-a-content-type) it to your stack. (If needed, you can [create your own content types](https://www.contentstack.com/docs/guide/content-types#creating-a-content-type). Read more about [Content Types](https://www.contentstack.com/docs/guide/content-types).)

Now that all the content types are ready, let’s add some content for your Product app.

## Step 4: Add content
[Create](https://www.contentstack.com/docs/guide/content-management#add-a-new-entry) and [publish](https://www.contentstack.com/docs/guide/content-management#publish-an-entry) entries for the ‘Product’ content type.  
  
Now that we have created the sample data, it’s time to use and configure the presentation layer.

## Step 5: Clone and configure the application

To get your app up and running quickly, we have created a sample iOS app for this project. You need to download it and change the configuration. Download the app using the command given below:
```
$ git clone https://github.com/contentstack/contentstack-ios-graphql-example.git
```
  
Open variables.xcconfig and inject your credentials so it looks like this:
```
CONTENTSTACK_API_KEY=<API_KEY>  
CONTENTSTACK_DELIVERY_TOKEN=<DELIVERY_TOKEN>  
CONTENTSTACK_ENVIRONMENT=<ENVIRONMENT_NAME>  
CONTENTSTACK_HOST_NAME=<HOST_NAME>
```
  
## Step 6: Install Apollo framework
Install Apollo.framework into your project using Carthage, CocoaPods, or by manually integrating it with Xcode. Refer the [Installation](https://www.apollographql.com/docs/ios/installation.html#installing-framework) doc for more information.

## Step 7: Download your schema
Download the GraphQL schema for your content model using Apollo CLI, and place it in the root directory of your Xcode project:
```
apollo schema:download --endpoint "https://graphql.contentstack.io/stacks/api_key/explore?access_token=environment-specific_delivery_token&environment=environment_name"
```
  
Refer the [Downloading Schema](https://www.apollographql.com/docs/ios/downloading-schema.html) doc for more information.

## Step 8: Write your GraphQL queries
Contentstack provides a GraphQL playground, which is a GraphiQL interface, to test your GraphQL queries in your browser. Use this interface to write and test your queries.

Open a browser of your choice and hit the URL given below (after entering the required details):
```
https://graphql.contentstack.io/stacks/api_key/explore?access_token=environment-specific_delivery_token&environment=environment_name
```
 
Now to get the list of all entries of the Product content type within the ProductListViewController.swift create a file named ProductListViewController.graphql and add the following code snippet to get.

```
query Products($skip: Int = 0 ,$limit: Int){
	all_product(locale:"en-us", skip:$skip, limit:$limit) {
		items {
			title
			description
			price
			featured_image {
				...Assets
			}
		}
	}
}

fragment Assets on SysAssets {
	filename
	file_size
	url
}
```

Note:
-   If you have pieces of data that you may want to reuse in multiple places, make use of fragments. Refer the [Using fragments](https://www.apollographql.com/docs/ios/fragments.html) doc for more details.
-   Apollo iOS generates code from queries and mutations contained in .graphql files in your target.
-   A useful convention is to colocate queries, mutations, or fragments with the Swift code that uses them by creating <name>.graphql next to <name>.swift.
 
## Step 9: Add a code generation build step
Once your queries are working and return the expected data, the next step is to add a code generation build step to your target by invoking Apollo as part of the Xcode build process.

Now, you need to, create a build step and make sure that it runs before ‘Compile Sources’. To do so, perform the steps given below:
1.  Click on the Build Phases settings tab under your application’s TARGETS section.
2.  Click on the ‘+’ (Plus) icon and select New Run Script Phase.
3.  Create a run script and change its name to ‘Generate Apollo GraphQL API’.
4.  Drag this script just above Compile Sources. This opens the script area. Add the following content into it:  
      
```
APOLLO_FRAMEWORK_PATH="$(eval find $FRAMEWORK_SEARCH_PATHS -name "Apollo.framework" -maxdepth 1)"  
  
if [ -z "$APOLLO_FRAMEWORK_PATH" ]; then  
echo "error: Couldn't find Apollo.framework in FRAMEWORK_SEARCH_PATHS; make sure to add the framework to your project."  
exit 1  
fi  
  
cd "${SRCROOT}/${TARGET_NAME}"  
$APOLLO_FRAMEWORK_PATH/check-and-run-apollo-cli.sh codegen:generate --queries="$(find . -name '*.graphql')" --schema=schema.json API.swift
```

Now, build your project. This will generate the API.swift file in project dictionary add it to Xcode project.

## Step 10: Create an Apollo client
After downloading the schema and creating the queries, create an instance of ApolloClient and point it at the GraphQL server.

To do this, define a global variable in AppDelegate.swift by using an immediately invoked closure as follows:

```
let apollo: ApolloClient = {  
	let url = URL(string: "https://graphql.contentstack.io/stacks/api_key?access_token=environment-specific_delivery_token&environment=environment_name")!  
	return  ApolloClient(networkTransport: HTTPNetworkTransport(url: url))  
}()
```
  
To know how to add additional headers to requests, and to include authentication details, refer the [Adding additional headers](https://www.apollographql.com/docs/ios/initialization.html#adding-headers) section.

## Step 11: Build application to generate Swift query models
Finally, integrate Apollo Client into your app, pass the Swift model and queries generated above, and fetch the relevant data using the following code snippet:
```
apollo.fetch(query: ProductsQuery(skip: skip, limit: 5)) {[weak  self] result, error in  
	guard  let resultS = result, let data = resultS.data, let products = data.allProduct?.items else {  
		return  
	}  
	for product in products {  
		print(product.title)  
	}  
}
```
## Step 12: Build and run your application
Now that we have a working project, you can build and run it.

## More Resources
- [Getting started with iOS SDK](https://www.contentstack.com/docs/platforms/ios)
- [Using GraphQL queries with Apollo Client iOS SDK](https://www.contentstack.com/docs/guide/contentstack-graphql-api/using-graphql-with-apollo-client-ios-sdk)
- [GraphQL API documentation](https://www.contentstack.com/docs/apis/graphql-content-delivery-api/)

