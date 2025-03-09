from dotenv import load_dotenv
from pydantic_settings import BaseSettings




load_dotenv()   #we can skip this as BaseSettings is doing the job

class Settings(BaseSettings):
    TAVILY_API_KEY : str =  ""
    GEMINI_API_KEY : str = ""
    WEBSOCKET_URI : str = ""