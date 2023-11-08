defmodule DogtorWeb.Resolvers.DogBreeds do
  alias Dogtor.DogBreeds

  def get_all(_, _) do
    DogBreeds.get_all()
  end

  def get_image_by_name(%{name: name}, _conn) do
    DogBreeds.get_image_by_name(name)
  end

  def create(%{name: name, data: data}, _conn) do
    DogBreeds.create(name, data)
  end
end
