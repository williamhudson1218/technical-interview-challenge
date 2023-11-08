import { useQuery, gql } from "@apollo/client";
import client from "./apollo";

const GET_BREED_IMAGE = gql`
  query GetBreedImage($name: String!) {
    get_image_by_name(name: $name)
  }
`;

function useDogBreedImage(breedName) {
  const { data, loading, error } = useQuery(GET_BREED_IMAGE, {
    variables: { name: breedName },
    client,
    skip: !breedName,
  });

  if (loading) {
    return null;
  }

  if (error) {
    console.error("Error fetching dog breed image:", error);
    return null;
  }

  return data?.get_image_by_name;
}

export default useDogBreedImage;
