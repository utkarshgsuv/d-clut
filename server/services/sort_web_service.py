from typing import List
from sentence_transformers import SentenceTransformer
import numpy as np


class SortWebService:
    #we will create constructor to define the model of sentence transfrmers we will use for embedding
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")

    def sort_sources(self, query:str , search_results : List[dict]):
        try:
            relevant_docs = [] #a filtered list of docs which have a high cos similarity
            query_embedding = self.embedding_model.encode(query)
        
            for res in search_results:
                
                content = res.get('content')
                
                if not content:
                    print("skipping this result due to missing content")
                    continue
                
                res_embedding = self.embedding_model.encode(content)

                #cos similarity search
                similarity = float(np.dot(query_embedding , res_embedding) / (np.linalg.norm(query_embedding)*np.linalg.norm(res_embedding)))
                res['relevance_score'] = similarity
            
                if(similarity > 0.3):
                    relevant_docs.append(res)
        
        
            #sort the resources based on similarity and return them
            return sorted(relevant_docs , key = lambda x: x['relevance_score'] , reverse= True)
        except Exception as e:
            print('sort result' , e)
