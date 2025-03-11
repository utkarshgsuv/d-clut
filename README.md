# **D-Clut – AI-Powered Information Decluttering Platform**  

## **Overview**  
D-Clut is an **AI-driven platform** designed to streamline information retrieval by providing **real-time, structured, and context-aware insights.** It leverages cutting-edge AI techniques to help users efficiently navigate vast amounts of data, eliminating information overload.  

The platform consists of two core tools:  
- **D-Search** – An AI-powered search engine that delivers real-time, ranked, and summarized information.  
- **D-Summarize** – An advanced video summarization tool that extracts key insights from long-form YouTube content.  

## **Objective**  
D-Clut aims to enhance **information accessibility and efficiency** by leveraging AI for precise, structured, and easily digestible content.  

---  

## **Features & Technology**  

### **D-Search – AI-Driven RAG Search Engine**  
A **real-time, intelligent search engine** that retrieves, ranks, and summarizes relevant web-based information.  
With d-Search, simply enter your query and get real-time, to-the-point answers with AI-powered insights, live updates, subject notes , summaries, codes ,etc and keeping contextual understanding.

#### **Key Features:**  
- AI-powered **retrieval-augmented generation (RAG)** pipeline for accurate, context-aware responses.  
- **FastAPI backend with WebSockets** for low-latency, real-time search.  
- **Vector embedding & cosine similarity** for ranking search results.  
- **LLM-based summarization** to deliver structured, concise insights.  
- **Follow-up query support** with conversation history retention.  
- **Flutter-based UI** ensuring a seamless cross-platform experience.  

#### **Tech Stack:**  
- **Backend:** FastAPI, Python, WebSockets, Pydantic, RAG Model, LLM  
- **Search & Ranking:** Vectorization, Cosine Similarity  
- **UI/UX:** Flutter, Singleton Pattern, Stream Controllers  

---  

### **D-Summarize – AI-Powered YouTube Video Summarizer**  
An AI-driven tool that **analyzes YouTube videos and generates structured, research-grade summaries.**  
Users submit a YouTube URL, and the AI tool generates a structured summary.

#### **Key Features:**  
- **AI-powered transcript extraction** and structured summarization.  
- **Multi-language support** with **LangDetect** and Hindi-to-Hinglish transliteration.  
- **Context-aware topic detection** for adaptive summarization formats.  
- **AI-driven structured output** (comparisons, key takeaways, tabular data).  
- **Technical content extraction** for code snippets, equations, and diagrams.  
- **Flutter-based responsive UI** for a seamless experience across devices.  

#### **Tech Stack:**  
- **Backend:** Python, FastAPI, LLM  
- **NLP & Processing:** LangDetect, Indic Transliteration, YouTube API  
- **UI/UX:** Flutter  

---  

## **Conclusion**  
D-Clut simplifies knowledge discovery by combining **AI-powered search and intelligent summarization**, enabling users to **efficiently access and process information.** The platform is designed to scale, ensuring accuracy, usability, and a seamless user experience.  
