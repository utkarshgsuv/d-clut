import asyncio
from fastapi import FastAPI, WebSocket
from pydantic_model.chat_body import ChatBody
from services.yt_llm_service import AskLLM
from services.yt_transcript import YTTranscript
from services.yt_video_id import VideoID
from services.llm_service import LLMService
from services.sort_web_service import SortWebService
from services.search_service import SearchService
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # will Change * to my frontend URL for better security 
    allow_credentials=True,
    allow_methods=["*"],  # Allow POST, GET, OPTIONS, etc.
    allow_headers=["*"],
)

search_service = SearchService()
sort_web_service = SortWebService()
llm_service = LLMService()
id_service = VideoID()
transcript_service = YTTranscript()
video_summary = AskLLM()



chat_histories = {}

@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    
    session_id = id(websocket)  
    chat_histories[session_id] = [] 

    try:
        while True: 
            data = await websocket.receive_json()  
            validated_data = ChatBody(**data)  
            query = validated_data.query 

          
            chat_histories[session_id].append({"role": "user", "content": query})

            
            search_results = search_service.web_search(query)
            sorted_results = sort_web_service.sort_sources(query, search_results)

           
            await websocket.send_json({"type": "search_result", "data": sorted_results})

            response_text = ""
            
            
            for chunk in llm_service.generate_response(chat_histories[session_id], sorted_results):
                # print(chunk)
                response_text += chunk
                await websocket.send_json({"type": "content", "data": chunk})

            
            chat_histories[session_id].append({"role": "assistant", "content": response_text})
            # print(chat_histories)

    except Exception as e:
        print("Unexpected Error:", e)
    finally:
        # Cleanup session when WebSocket disconnects
        chat_histories.pop(session_id, None)
        await websocket.close()
        
        


#api endpoint for getting yt video summary
@app.post("/summarise")
def yt_endpoint(body: ChatBody) :
    try:
        print('post connection started')
        #step - 1 get the video id
        video_id = id_service.get_video_id(body.query)
        # print(video_id , 'video id')
        
        #step - 2 pass this video id to getTranscript function
        if(video_id != "VIDEO_ID_NOT_FOUND"):
            full_text = transcript_service.extract_transcript(video_id)
            # print('transcripts' , full_text )
        else:
             full_text = transcript_service.extract_transcript("The user didn't provide the correct youtube video , pls ask him to provide correct url and start again")

        
        #step 3 passing the transcripts to llm model
        response = video_summary.summarise_video(full_text)
        # print(response)
        return {"summary": response}
        
        
        
    except Exception as e:
        print("problem in main.py" , e)
