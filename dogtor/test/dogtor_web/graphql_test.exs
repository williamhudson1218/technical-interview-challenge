defmodule DogtorWeb.GraphqlTest do
  use DogtorWeb.ConnCase, async: true

  test "list_dog_breeds returns a list of dog breeds", %{conn: conn} do
    query = """
      query {
        list_dog_breeds
      }
    """

    data =
      post(conn, "/graphql", %{query: query})
      |> json_response(200)
      |> Map.get("data")

    assert data == %{
             "list_dog_breeds" => [
               "Great Dane",
               "Affenpinscher",
               "Boxer",
               "Cocker Spaniel",
               "Border Collie",
               "Pomeranian",
               "Irish Terrier",
               "Norwich Terrier",
               "Shetland Sheepdog",
               "English Bulldog"
             ]
           }
  end

  test "get_image_by_name returns image content for a dog breed", %{conn: conn} do
    breed_name = "Great Dane"

    query = """
      query {
        get_image_by_name(name: "#{breed_name}")
      }
    """

    data =
      post(conn, "/graphql", %{query: query})
      |> json_response(200)
      |> Map.get("data")
      |> Map.get("get_image_by_name")

    # Add assertions to check the image content, e.g., its length or specific properties.
    # For example, if the image is expected to be binary content:
    assert is_binary(data)
    assert byte_size(data) > 0
  end

  test "create_dog_breed mutation successfully creates a dog breed", %{conn: conn} do
    breed_name = "Golden Retriever"
    image_file_path = "test/golden_retriever.jpg"
    new_image_file_path = "images/golden_retriever.jpg"

    {:ok, breed_data} = File.read(image_file_path)

    assert byte_size(breed_data) > 0

    mutation = """
      mutation {
        createDogBreed(name: "#{breed_name}", data: "#{Base.encode64(breed_data)}")
      }
    """

    response =
      post(conn, "/graphql", %{query: mutation})
      |> json_response(200)
      |> Map.get("data")
      |> Map.get("createDogBreed")

    assert response == true

    # now delete the file to clean update_in
    assert File.rm(new_image_file_path) == :ok
  end
end
