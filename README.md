# Code Challenge

## Instructions:
Exercise solved in Swift.

Everything is set up and dependencies are added to source control. Just checkout the branch and run.


## Questions:

A) Describe the strategy used to consume the API endpoints and the data management.

I've used Alamofire for the network calls and defined a set of Decodable structs to parse the json data into swift objects. Those ojbects are immutables and they are instantiated by the swift provided JSONDecoder.

I've implemented the networking layer in a small module called Services, this would allow this layer to be reusable, it compile by itself (independent) and can have its own tests (and run them isolatedly).

The API for this module is very simple since every public method is static (there is no need to keep a state).

B) Explain which library was used for the routing and why. Would you use the same for a consumer facing app targeting thousands of users? Why?

The whole app is centered in the Coordinators pattern. It takes responsibilities from the VCs such as fetching data from the server, handling data and the navigation flow to make those VCs simple classes that only gets arguments and builds the view.

This app is small and the navigation flow is simple, so we only have one coordinator here that pretty much does everything for us, but if we want to scale this approach for bigger apps we just need to split the flows and use cases so then we can split these responsibilities between more coordinators (meant for specific flows/use cases).

C) Have you used any strategy to optimize the performance of the list generated for the first feature?

I would expect this endpoint to return a paginated response, since it is not the case and using Decodable makes everything easier and faster I didn't need to add anything else.

D) Would you like to add any further comments or observations?

Just a little comment on the API used for the test, it is clear that it is far away of being proficient and sharped, it has a lot of things to improve starting for the key names and the ingredients and measures (should return at least a list for each one and null values for empty cases)
