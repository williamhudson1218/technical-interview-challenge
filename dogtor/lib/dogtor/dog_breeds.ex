defmodule Dogtor.DogBreeds do
  @directory_path "images"

  def get_all() do
    case get_image_list() do
      {:ok, image_list} ->
        normalized_list = Enum.map(image_list, &image_name_to_readable_name/1)
        {:ok, normalized_list}

      {:error, reason} ->
        {:error, "Error listing dog breeds: #{reason}"}
    end
  end

  def get_image_by_name(name) do
    image_name = readable_name_to_image_name(name)

    case File.read(Path.join([@directory_path, image_name])) do
      {:ok, data} ->
        {:ok, data}

      {:error, _} ->
        {:error, "Image not found for breed: #{name}"}
    end
  end

  def create(name, data) do
    image_name = readable_name_to_image_name(name)
    filename = Path.join([@directory_path, image_name])

    case File.write(filename, data) do
      :ok ->
        {:ok, true}

      {:error, _} ->
        {:error, "Failed to create image for breed: #{name}"}
    end
  end

  defp get_image_list() do
    with {:ok, image_list} <- File.ls(@directory_path),
         filtered_list <-
           Enum.filter(image_list, fn image -> String.ends_with?(image, ".jpg") end) do
      {:ok, filtered_list}
    else
      {:error, reason} ->
        {:error, "Error listing dog breeds: #{reason}"}
    end
  end

  defp image_name_to_readable_name(name) do
    name
    |> String.split(".")
    |> List.first()
    |> String.split("_")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  defp readable_name_to_image_name(name) do
    name
    |> String.downcase()
    |> String.replace(" ", "_")
    |> (fn name_with_underscores -> name_with_underscores <> ".jpg" end).()
  end
end
