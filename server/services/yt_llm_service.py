from google import genai
from config import Settings

settings = Settings()

class AskLLM:
    def __init__(self):
        self.client = genai.Client(api_key=settings.GEMINI_API_KEY)
    
    def summarise_video(self , transcript  : str):
        full_prompt = f"""
You are an expert in extracting **insightful, structured, and well-presented notes** from a YouTube video transcript. Below is the transcript of the video:

### **Transcript:**
{transcript}

---

## **Your Task:**
Generate a **detailed, well-structured, and engaging summary** from this transcript, covering everything from **basics to advanced** concepts in an easy-to-understand and interesting way. 

The summary should be so **clear, engaging, and insightful** that even a beginner can follow along, while still providing value to advanced learners.

### **Formatting Guidelines:**
- **Use structured headings and subheadings** (`##`, `###`) to make it easy to navigate.
- **Break down complex concepts into simple explanations** before diving into deeper insights.
- **Use bold text for key concepts** to highlight important points.
- **Include real-world applications and examples** to make the content relatable.
- **Use bullet points (-) and numbered lists (1., 2., 3.)** for clarity.
- **Provide formulas, technical terms, and methodologies** with easy explanations.
- **Ensure proper spacing and formatting** for readability.
- **Make it engaging!** The tone should feel natural, as if an expert is explaining things in a way that keeps the reader hooked.

### **Topic-Specific Adaptation:**
- **Science & Engineering:** Explain fundamental principles, laws, and real-world applications.
- **Mathematics & Data Science:** Break down formulas, techniques, and problem-solving methods.
- **Business & Finance:** Summarize strategies, trends, and key financial principles.
- **Technology & AI:** Explain algorithms, coding practices, and architectures.
- **History & Social Sciences:** Give historical overviews and societal impacts.
- **Self-Improvement & Psychology:** Extract actionable insights and mindset shifts.
- **Health & Fitness:** Summarize routines, diet plans, and scientific concepts.
- **Entertainment & Media:** Analyze storytelling techniques and artistic themes.

---

## **Important Rules:**
- if the provided content has no transcripts then give an polite error that either you didnt provide a correct url or the provided video is not in english , and tell i currently understand english only
- **Greet the user naturally** in first person (e.g., "Let's dive into this topic!" or "Here's a clear breakdown for you.").
- **Do NOT mention that this summary is based on a transcript.**
- **Ensure the response is detailed, structured, and visually appealing** (without unnecessary emojis or awkward characters (dont use -)).
- **Make the explanation engaging, insightful, and easy to follow.**
- if required do proper comparisions using tables 
- if required show the summary using tables , graphs , etc.
- **Cover everything from basics to advanced concepts in a progressive manner.**

Now, generate the structured notes in a clear, professional, and visually engaging manner.
"""

        
        response = self.client.models.generate_content(
            model="gemini-2.0-flash",
            contents=full_prompt  
        )
        
        return response.text