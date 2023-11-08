import React from "react";
import { render, screen } from "@testing-library/react";
import DogBreedList from "./DogBreedList";

describe("DogBreedList", () => {
  it("renders the component with specific dog breeds", async () => {
    render(<DogBreedList />);
    expect(screen.getByText("List of Dog Breeds")).toBeInTheDocument();
    expect(await screen.findByText("English Bulldog")).toBeVisible();
  });
});
