from pydantic import BaseModel
from typing import List, Dict

class ChatBody(BaseModel):
    query: str
    
