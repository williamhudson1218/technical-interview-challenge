import React, { useRef, useEffect, useState } from "react";
import useDogBreeds from "../hooks/useDogBreeds";
import useDogBreedImage from "../hooks/useDogBreedImage";
import useCreateDogBreed from "../hooks/useCreateDogBreed";
import "./style.css";

function DogBreedList() {
  const [newBreedName, setNewBreedName] = useState("");
  const [selectedImage, setSelectedImage] = useState(null);
  const [validationError, setValidationError] = useState("");
  const { createDogBreed, createResult } = useCreateDogBreed();
  const [dogBreeds, setDogBreeds] = useState([]);
  const [selectedBreed, setSelectedBreed] = useState(null);
  const { breeds, loading } = useDogBreeds();
  const ref = useRef();

  useEffect(() => {
    setDogBreeds(breeds);
  }, [breeds, loading]);

  const handleBreedClick = (breed) => {
    setSelectedBreed(breed);
  };

  const imageData = useDogBreedImage(selectedBreed);

  const handleCreateBreed = async () => {
    if (newBreedName && selectedImage) {
      try {
        await createDogBreed(newBreedName, selectedImage);

        setDogBreeds([...dogBreeds, newBreedName]);
        clearData();
      } catch (error) {
        console.error("Error creating dog breed:", error);
        setValidationError("Error creating dog breed.");
      }
    } else {
      setValidationError("Please provide a breed name and select an image.");
    }
  };

  const clearData = () => {
    setNewBreedName("");
    setSelectedImage(null);
    setValidationError("");
    ref.current.files = null;
  };

  const handleImageUpload = (event) => {
    const file = event.target.files[0];

    if (file) {
      const reader = new FileReader();

      reader.onload = (e) => {
        setSelectedImage(e.target.result);
      };

      reader.readAsDataURL(file);
    }
  };

  return (
    <div className="dog-breed-container">
      <h1>List of Dog Breeds</h1>
      <div className="form-container">
        <input
          type="text"
          value={newBreedName}
          onChange={(e) => setNewBreedName(e.target.value)}
          placeholder="Enter Breed Name"
        />
        <input
          ref={ref}
          type="file"
          accept="image/*"
          onChange={handleImageUpload}
        />
        <button onClick={handleCreateBreed}>Add Breed</button>
        {validationError && <p className="error">{validationError}</p>}
        {createResult && <p>{createResult}</p>}
      </div>
      <div className="breed-list">
        {dogBreeds?.map((breed) => (
          <div
            key={breed}
            className="breed-item"
            onClick={() => handleBreedClick(breed)}
          >
            {breed}
          </div>
        ))}
      </div>
      <div className="breed-image-container">
        {imageData && (
          <img
            src={`data:image/jpeg;base64, ${imageData}`}
            alt={selectedBreed}
          />
        )}
      </div>
    </div>
  );
}

export default DogBreedList;
