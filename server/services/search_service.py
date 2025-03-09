from config import Settings
from tavily import TavilyClient
import trafilatura

settings = Settings()
tavily_client = TavilyClient(api_key=settings.TAVILY_API_KEY)

class SearchService:
    def web_search(self , query:str):
        try:
            ans= []
            #how we gonna search the web for appropriate resources
            response = tavily_client.search(query , max_results=10)   #travily just searches for our query into the whole blogs and give that cotent which contains the terms from our query so we will take urls from travily and use another package[trafilatura] for depth research
            search_results = response.get("results")

            #now we will loop through each result url from trafilatura
            for result in search_results:
                downloaded  = trafilatura.fetch_url(result.get("url"))   #it is downloading the content from each url
                content = trafilatura.extract(downloaded)   #to extract the content from the varialble
                ans.append(
                {
                "title" : result.get("title" , ""),
                "url" : result.get("url" ),
                "content" : content,
                }
                )

        
            return ans   #we have the data we want
        except Exception as e:
            print('web search' , e)