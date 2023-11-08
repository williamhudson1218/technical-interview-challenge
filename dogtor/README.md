# Dogtor - Dog Breed API

**Dogtor** is an API application that provides a variety of endpoints for fetching information about dog breeds and working with dog breed images. You can use these APIs to fetch a list of dog breeds, obtain images of specific dog breeds, and add new dog breed images to the server. While Dogtor provides valuable functionality, it's essential to note that there are a few known issues, such as image corruption during the image upload process.

## Getting Started
To run the Dogtor Phoenix server, follow these steps:
Run the `mix setup` command to install and set up the required dependencies.
Start the Phoenix endpoint using one of the following methods:
Execute `mix phx.server` in your terminal _or_ start the server within IEx with `iex -S mix phx.server`.

Once the server is up and running, you can access it by visiting `localhost:4000` from your web browser.

## Public Schema
Dogtor provides a public GraphQL schema that allows you to interact with the application using various queries and mutations.

### Queries
`list_dog_breeds`
Fetches a list of all available dog breeds.
Returns a list of strings, where each string represents a dog breed.

`get_image_by_name`
Retrieves an image of a specific dog breed by providing its name as an argument.
Returns a binary data representation of the image.

### Mutations
`create_dog_breed`
Allows you to add a new dog breed to the server.
Requires two arguments: name (a string) and data (a string).
name: The name of the new dog breed.
data: The image data of the new dog breed.
Returns a boolean value (true for success, false for failure).

**Please note**: There is a known issue with the create_dog_breed endpoint, where images uploaded through this API become corrupt. I ran into some issues implementing the :upload custom absinthe type and time didn't allow me to dig into it further.

## Known Issues
The create_dog_breed endpoint is currently experiencing issues that result in image corruption. Images uploaded through this API may not be stored correctly.

## Future Enhancements
* To make Dogtor even more useful and robust, the following enhancements could be considered:
Database Integration: Add Ecto, a database library for Elixir, to the application to store and manage dog breed information and images. This would provide a more reliable and scalable solution for data storage.
* Data Expansion: Expand the APIs to include more detailed information about dog breeds, such as breed characteristics, temperament, history, and care guidelines. This would make the application more informative and comprehensive for users.
* The project could use some general cleanup including adding moduledocs, etc.

