import { gql, useQuery } from "@apollo/client";
import client from "./apollo";

export const DOG_BREEDS_QUERY = gql`
  query {
    list_dog_breeds
  }
`;

function useDogBreeds() {
  const { loading, error, data } = useQuery(DOG_BREEDS_QUERY, {
    client,
  });

  if (loading) {
    return [];
  }

  if (error) {
    console.error("Error fetching dog breeds:", error);
    return [];
  }

  return { loading: loading, breeds: data.list_dog_breeds };
}

export default useDogBreeds;
