import React from "react";
import { render, screen } from "@testing-library/react";
import DogBreedList from "./DogBreedList";
import { MockedProvider } from "@apollo/client/testing";
import { DOG_BREEDS_QUERY } from "../hooks/useDogBreeds";

const mocks = [
  {
    request: {
      query: DOG_BREEDS_QUERY,
    },
    result: {
      data: {
        dogBreeds: ["Poodle", "Labrador"],
      },
    },
  },
];

describe("DogBreedList", () => {
  it("renders the component with specific dog breeds", async () => {
    render(
      <MockedProvider mocks={mocks} addTypename={false}>
        <DogBreedList />
      </MockedProvider>,
    );

    // Assertions
    expect(screen.getByText("List of Dog Breeds")).toBeInTheDocument();
  });
});
