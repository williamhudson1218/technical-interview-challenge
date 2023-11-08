import { useState } from "react";
import { useMutation, gql } from "@apollo/client";
import client from "./apollo";

const CREATE_DOG_BREED = gql`
  mutation CreateDogBreed($name: String!, $data: String!) {
    createDogBreed(name: $name, data: $data)
  }
`;

function useCreateDogBreed() {
  const [createDogBreedMutation] = useMutation(CREATE_DOG_BREED, { client });
  const [createResult, setCreateResult] = useState(null);

  const createDogBreed = async (name, data) => {
    try {
      const response = await createDogBreedMutation({
        variables: { name, data },
      });
      const result = response.data.createDogBreed;
      setCreateResult(result);
    } catch (error) {
      console.error("Error creating dog breed:", error);
    }
  };

  return { createDogBreed, createResult };
}

export default useCreateDogBreed;
