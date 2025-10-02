import instaloader
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Allow frontend to call backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

L = instaloader.Instaloader()

# List of public Instagram usernames
usernames = ["instagram", "natgeo", "nasa", "cristiano", "therock", "selenagomez", "kimkardashian", "shakira", "nike", "adidas"]

def get_profile_data(username):
    try:
        profile = instaloader.Profile.from_username(L.context, username)
        return {
            "username": profile.username,
            "full_name": profile.full_name,
            "followers": profile.followers,
            "following": profile.followees,
            "posts": profile.mediacount,
        }
    except Exception as e:
        return {"username": username, "error": str(e)}

@app.get("/profiles")
def fetch_profiles():
    data = [get_profile_data(u) for u in usernames]
    # Sort by followers descending
    data.sort(key=lambda x: x.get("followers", 0), reverse=True)
    return data
