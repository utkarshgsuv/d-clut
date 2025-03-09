from langdetect import detect
from youtube_transcript_api import YouTubeTranscriptApi
from indic_transliteration import sanscript
from indic_transliteration.sanscript import transliterate



class YTTranscript:
    def extract_transcript(self , video_id: str):
        try:
            try:
                transcript = YouTubeTranscriptApi.get_transcript(video_id, languages=['en'])
            except:
                transcript = YouTubeTranscriptApi.get_transcript(video_id, languages=['hi'])
                
            transcript_text = " ".join(chunk['text'] for chunk in transcript)
            # Detect language
            lang = detect(transcript_text)
            
            if lang == "hi":
                hinglish_transcript = transliterate(transcript_text , sanscript.DEVANAGARI , sanscript.ITRANS)
                return hinglish_transcript
            else:
                return transcript_text
            
        except Exception as e:
            print('yt transcript' , e)