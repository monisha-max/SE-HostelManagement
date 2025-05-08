import os
import asyncio
from dotenv import load_dotenv
from crawl4ai import AsyncWebCrawler
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.vectorstores import FAISS
from langchain_openai import OpenAIEmbeddings,ChatOpenAI
from langchain_openai import ChatOpenAI

from langchain.chains import RetrievalQA
import openai
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

if not openai.api_key or "sk-" not in openai.api_key:
    raise ValueError("❌ Please set your OpenAI API key in a .env file as OPENAI_API_KEY=sk-...")

async def crawl_site():
    print("🌐 Crawling Mahindra University website...")
    async with AsyncWebCrawler() as crawler:
        result = await crawler.arun(
            url="https://www.mahindrauniversity.edu.in/"
        )
        text_content = result.markdown
        with open("mahindra_data.txt", "w", encoding="utf-8") as f:
            f.write(text_content)
        print("✅ Content saved to 'mahindra_data.txt'")

def embed_text():
    print("🧠 Splitting and embedding...")
    with open("mahindra_data.txt", "r", encoding="utf-8") as f:
        full_text = f.read()

    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
    chunks = splitter.split_text(full_text)

    embeddings = OpenAIEmbeddings()
    vectordb = FAISS.from_texts(chunks, embeddings)
    vectordb.save_local("vector_store")
    print("✅ Vector DB saved at './vector_store'")

def answer_query(query):
    embeddings = OpenAIEmbeddings()
    vectordb = FAISS.load_local(
        "vector_store",
        embeddings,
        allow_dangerous_deserialization=True  
    )
    retriever = vectordb.as_retriever(search_kwargs={"k": 4})
    llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)

    qa_chain = RetrievalQA.from_chain_type(
        llm=llm,
        retriever=retriever,
        chain_type="stuff"
    )

    answer = qa_chain.run(query)
    return answer

async def main():
    await crawl_site()
    embed_text()

    print("\n🤖 Ask anything about Mahindra University! Type 'exit' to quit.")
    while True:
        q = input("\nYour Question: ").strip()
        if q.lower() == "exit":
            print("👋 Exiting.")
            break
        answer_query(q)
        
if __name__ == "__main__":
    asyncio.run(main())
