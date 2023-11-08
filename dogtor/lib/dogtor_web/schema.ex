defmodule DogtorWeb.Schema do
  use Absinthe.Schema
  alias DogtorWeb.Resolvers.DogBreeds
  import_types(Absinthe.Plug.Types)

  scalar :binary_data do
    serialize(&Base.encode64/1)
    parse(&Base.decode64/1)
  end

  query do
    field :list_dog_breeds, type: list_of(:string) do
      resolve(&DogBreeds.get_all/2)
    end

    field :get_image_by_name, :binary_data do
      arg(:name, :string)
      resolve(&DogBreeds.get_image_by_name/2)
    end
  end

  mutation do
    field :create_dog_breed, type: :boolean do
      arg(:name, :string)
      arg(:data, :string)
      resolve(&DogBreeds.create/2)
    end
  end
end
