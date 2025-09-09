# RAG Agent for Document Ingestion and Retrieval

A powerful, automated system built on n8n that creates a Retrieval-Augmented Generation (RAG) agent. It seamlessly ingests documents from Google Drive into a Pinecone vector store and provides an intelligent conversational interface to query the collected data.

![n8n](https://img.shields.io/badge/n8n-%23000000.svg?style=for-the-badge&logo=n8n&logoColor=white)
![Pinecone](https://img.shields.io/badge/Pinecone-4300c1?style=for-the-badge)
![Cohere](https://img.shields.io/badge/Cohere-FFFFFF?style=for-the-badge)
![Groq](https://img.shields.io/badge/Groq-00FF40?style=for-the-badge)

## 🌟 Features

- **Automated Ingestion**: Automatically detects and processes new or updated files in a designated Google Drive folder.
- **Intelligent Vectorization**: Leverages the Cohere Embeddings API to create powerful vector representations of document content.
- **Scalable Storage**: Efficiently stores and indexes document chunks and their embeddings in a Pinecone vector database.
- **Conversational Interface**: Provides a clean chat interface to interact with your documents.
- **Contextual Responses**: Grounds its answers in retrieved information from your documents, ensuring accuracy and relevance.

## 🛠️ Architecture and Workflow

The system is composed of two distinct but interconnected n8n workflows:

### 1. Ingestion Workflow (`RAG Agent Process`)

This workflow is the data pipeline responsible for preparing and loading documents into the vector database.

**Flow:**
1.  **Google Drive Trigger**: Listens for new or updated files in a specific folder.
2.  **Google Drive Node**: Downloads the file content.
3.  **Recursive Character Text Splitter**: Splits document content into smaller, manageable chunks optimal for embedding and retrieval.
4.  **Embeddings (Cohere)**: Generates vector embeddings for each text chunk using the `embed-multilingual-v2.0` model.
5.  **Vector Store (Pinecone)**: Upserts the text chunks and their corresponding embeddings into a Pinecone index named `ragforn8n`.

### 2. Query Workflow (`RAG Agent`)

This workflow serves as the user-facing application, handling incoming queries and generating intelligent responses.

**Flow:**
1.  **Input Message**: The entry point for a user's query.
2.  **RAG Agent Node**: The core orchestrator. It uses the configured tools and memory to process the request.
3.  **Vector Store (Tool)**: Performs a similarity search in the Pinecone index. It embeds the user's query and retrieves the most relevant document chunks.
4.  **Simple Memory**: Maintains conversation history to enable context-aware follow-up questions.
5.  **Chat Model (Groq)**: Synthesizes a coherent and final response based on the retrieved context and conversation history using an LLM like `moonshotai/kimi-k2-instruct-0905`.

## ⚙️ Prerequisites

Before setting up, ensure you have accounts and API keys for the following services:

-   **Google Drive**: To set up the trigger for document ingestion.
-   **Cohere**: API Key for generating text embeddings.
-   **Pinecone**: API Key and environment for accessing and managing the vector database.
-   **Groq** (or similar LLM provider): API Key for the chat model used by the RAG Agent.

## 🚀 Setup and Usage

### 1. Import Workflows
-   Download the provided JSON workflow files (`RAG Agent Process.json` and `RAG AGENT (1).json`).
-   Import them into your n8n instance.

### 2. Configure Credentials
-   In your n8n settings, add new credentials for:
    -   Google Drive
    -   Cohere API
    -   Pinecone API
    -   Groq API
-   Update the credential fields in each node of the imported workflows to use the new credentials you created.

### 3. Configure the Ingestion Workflow
-   In the **Google Drive Trigger** node, configure it to watch your specific target folder.
-   Activate the **RAG Agent Process** workflow. It will now automatically ingest any new or updated files.

### 4. Configure and Test the Query Workflow
-   Activate the **RAG Agent** workflow.
-   Use the **Input message** node to test the agent by sending queries related to your ingested documents.

## 🤝 Contribution

This project is an excellent foundation for building a custom RAG system. We welcome contributions and extensions, such as:

-   Adding support for more data sources (e.g., websites, Slack, Notion, SharePoint).
-   Integrating different embedding models (e.g., OpenAI, OpenAI-compatible, local) or large language models.
-   Enhancing the chunking strategy for different document types (PDFs, PPTs, HTML).
-   Creating a custom front-end application for a better user experience.
-   Adding advanced retrieval techniques (hybrid search, re-ranking).

---

**Disclaimer:** This project is for demonstration purposes. Ensure you comply with the terms of service for all integrated APIs and handle data responsibly.
