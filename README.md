# Mission
Develop Github user search app for iOS.

# Specs
Pagination.  
Present searched user list.

# Idea
Use GraphQL supported by Github API.  
Use Reactive framework to implement complex search flow.

# Use of API
For using Github API, you have to generate access-token.  
https://github.com/settings/tokens  
Because of the token is private resource, i stored as a file and include git-ignore list for preventing leakage.

# Alamofire
For practicing designing real-world networks, i implement complex network manager using Alamofire.

## NetworkManager
I implement NetworkManager for using request and response handling base level. It has NetworkError dependancy only.

## API
For using API request and response handling, I implement GitHubNetworkManager based NetworkManager. It has entity and GitHubNetworkError dependancy.

## Router
I use Router for routing url and request options. Router has URLRequestConvertible protol and when request URLRequest Router create URLRequest by following case and return it.

## Adapter
For injecting GitHub access token i implement RequestAdapter provided Alamofire. When adapt() called, inject aceess token to URLRequest.

## Retrier
Provied Alamofire, RequestRetrier helps implement complex retrying logic. When should() called, check the response status and decide to retry or not


# Implementation
For using GraphQL, create "POST" request by putting query in the request body.  
There is a 3rd party library 'Apollo-ios' but i developed all by myself.  
https://developer.github.com/v4/

For implementing complex search flow, i separated reactive parts to 'UI' and 'Data'.  
It helps giving me a clear logic and obeying SRP.

GraphQL Querying is most tricky part to me.  
The format is strict and there is no easy way to manipulate it.  
Perhaps 'Apollo-ios' would helps.

# Fastlane
I add Fastlane for implement CD. Please go to 'fastlane' folder for checkout.
