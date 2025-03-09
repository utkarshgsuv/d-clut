class VideoID:
    def get_video_id(self , video_url : str):
        try:
            if "watch?v=" in video_url:
                video_id = video_url.split("watch?v=")[-1].split("&")[0]
                return video_id
            elif "youtu.be/" in video_url:
                video_id = video_url.split("youtu.be/")[-1].split("?")[0]
                return video_id
            else:
                video_id = "VIDEO_ID_NOT_FOUND"
                return video_id
        except Exception as e:
            print("video id " , e)