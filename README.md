# g4f-FastAPI-Langchain-OpenAI Example

This project demonstrates how to use `g4f` (a free internet large language model API), FastAPI, and Langchain's OpenAI integration to interact with a language model. It sets up a simple API endpoint using `g4f` and then uses Langchain with a custom OpenAI base URL to send a request to this local endpoint.

## Prerequisites

* Docker installed on your system.

## Getting Started

1.  **Clone this repository (or create the files manually):**

    ```bash
    git clone https://github.com/TheDivyanshShukla/g4f-docker
    cd g4f-docker
    ```

2.  **Build the Docker image:**

    ```bash
    docker build -t g4f-api .
    ```

3.  **Run the Docker container:**

    ```bash
    docker run -p 2400:2400 g4f-api
    ```

    This will start the `g4f` API server on port 2400 of your local machine.

4.  **Run the Python script (assuming you have Python and Langchain installed):**

    Save the following Python code as `main.py` in the same directory as your `Dockerfile`:

    ```python
    from langchain_openai import ChatOpenAI
    from rich import print

    # Initialize the OpenAI client, pointing to the local g4f API
    client = ChatOpenAI(
        base_url="http://localhost:2400/v1",
        model="gpt-4o",  # Or any other model supported by g4f
        api_key="Anything just don't let it be empty"
    )

    # Create a chat completion request
    response = client.invoke("Write a poem about a tree")

    print(response)
    ```

    Then, run the script:

    ```bash
    python main.py
    ```

    You should see the poem generated by the language model printed to your console.

## Explanation

* **`Dockerfile`:**
    * Sets up a Python 3.10.10 environment.
    * Installs `g4f`, `uvicorn`, `python-multipart`, and `fastapi`. These are the dependencies for running the `g4f` API.
    * Copies the project files into the `/app` directory.
    * Exposes port 2400, which the `g4f` API will use.
    * Starts the `g4f` API server using `python -m g4f.cli api --bind 0.0.0.0:2400`. This makes the API accessible from within the Docker container and externally.

* **`main.py`:**
    * Imports the necessary classes from `langchain_openai` and `rich`.
    * Initializes the `ChatOpenAI` client from Langchain. **Crucially**, the `base_url` is set to `http://localhost:2400/v1`. This redirects Langchain's API calls to the local `g4f` API server running in the Docker container.
    * The `model` parameter is set to `"gpt-4o"`. You can experiment with other models supported by `g4f`.
    * An example prompt "Write a poem about a tree" is used with the `client.invoke()` method to get a response from the language model.
    * The `rich.print()` function is used for nicely formatted output of the response.

## Notes

* This setup allows you to experiment with language models locally using the free `g4f` library and integrate it with Langchain.
* The performance and availability of the models accessed through `g4f` may vary.
* Ensure that the Docker container is running when you execute the `main.py` script.
* You can adapt the `main.py` script to perform more complex tasks and integrate it further with Langchain's capabilities.
* The `g4f` library supports various providers and models. You might need to adjust the `model` parameter in `main.py` depending on the provider being used by the `g4f` API.

## Further Exploration

* Explore the different models and providers available in the `g4f` library.
* Integrate Langchain's other features like memory, chains, and agents with this local API setup.
* Build more complex FastAPI applications that leverage the language model capabilities.
