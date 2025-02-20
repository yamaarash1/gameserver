from enum import Enum

from fastapi import Depends, FastAPI, HTTPException
from fastapi.security.http import HTTPAuthorizationCredentials, HTTPBearer
from pydantic import BaseModel

from . import model
from .model import SafeUser

from . import room_model
from . import room_function
from .room_model import LiveDifficulty, JoinRoomResult, WaitRoomStatus, RoomInfo, RoomUser, ResultUser

app = FastAPI()

####### Sample APIs #######

@app.get("/")
async def root():
    return {"message": "Hello World"}


####### User APIs #######


class UserCreateRequest(BaseModel):
    user_name: str
    leader_card_id: int


class UserCreateResponse(BaseModel):
    user_token: str


@app.post("/user/create", response_model=UserCreateResponse)
def user_create(req: UserCreateRequest):
    """新規ユーザー作成"""
    token = model.create_user(req.user_name, req.leader_card_id)
    return UserCreateResponse(user_token=token)


bearer = HTTPBearer()


def get_auth_token(cred: HTTPAuthorizationCredentials = Depends(bearer)) -> str:
    assert cred is not None
    if not cred.credentials:
        raise HTTPException(status_code=401, detail="invalid credential")
    return cred.credentials


@app.get("/user/me", response_model=SafeUser)
def user_me(token: str = Depends(get_auth_token)):
    user = model.get_user_by_token(token)
    if user is None:
        raise HTTPException(status_code=404)
    # print(f"user_me({token=}, {user=})")
    return user


class Empty(BaseModel):
    pass


@app.post("/user/update", response_model=Empty)
def update(req: UserCreateRequest, token: str = Depends(get_auth_token)):
    """Update user attributes"""
    #print(req)
    model.update_user(token, req.user_name, req.leader_card_id)
    return {}


 ####### Room APIs  #######


class RoomCreateRequest(BaseModel):
    live_id: int
    select_difficulty: LiveDifficulty


class RoomCreateResponse(BaseModel):
    room_id: int


class RoomListRequest(BaseModel):
    live_id: int


class RoomListResponse(BaseModel):
    room_info_list: list[RoomInfo]


class RoomJoinRequest(BaseModel):
    room_id: int
    select_difficulty: LiveDifficulty


class RoomJoinResponse(BaseModel):
    join_room_result: JoinRoomResult

    
class RoomWaitRequest(BaseModel):
    room_id: int

class RoomWaitResponse(BaseModel):
    status: WaitRoomStatus
    room_user_list: list[RoomUser]

class RoomStartRequest(BaseModel):
    room_id: int

class RoomEndRequest(BaseModel):
    room_id: int
    judge_count_list: list[int]
    score: int

class RoomResultRequest(BaseModel):
    room_id: int


class RoomResultResponse(BaseModel):
    result_user_list: list[ResultUser] or list

class RoomLeaveRequest(BaseModel):
    room_id: int


@app.post("/room/create", response_model=RoomCreateResponse)
def room_create_api(req: RoomCreateRequest, token: str = Depends(get_auth_token)):
    user = model.get_user_by_token(token)
    res = room_function.room_create(req.live_id, req.select_difficulty, user, token)
    return res


@app.post("/room/list", response_model=RoomListResponse)
def room_list_get_api(req: RoomListRequest):
    res = room_function.room_list_get(req.live_id)
    return res


@app.post("/room/join", response_model=RoomJoinResponse)
def join_room_api(req: RoomJoinRequest, token: str = Depends(get_auth_token)):
    user = model.get_user_by_token(token)
    res = room_function.room_join(req.room_id, req.select_difficulty, user)
    return res


@app.post("/room/wait", response_model=RoomWaitResponse)
def room_wait_api(req: RoomWaitRequest, token: str = Depends(get_auth_token)):
    user = model.get_user_by_token(token)
    res = room_function.room_wait(req.room_id, user)
    return res

@app.post("/room/start")
def room_start_api(req: RoomStartRequest, token: str = Depends(get_auth_token)):
    user = model.get_user_by_token(token)
    room_function.room_start(req.room_id, user)
    return {}

@app.post("/room/end")
def room_end_api(req: RoomEndRequest, token: str = Depends(get_auth_token)):
    user = model.get_user_by_token(token)
    res = room_function.room_end(req.room_id, req.judge_count_list, req.score, user)
    return res

@app.post("/room/result", response_model=RoomResultResponse)
def room_result_api(req: RoomResultRequest):
    res = room_function.room_result(req.room_id)
    return res

@app.post("/room/leave")
def room_leave_api(req: RoomLeaveRequest, token: str = Depends(get_auth_token)):
    user = model.get_user_by_token(token)
    res = room_function.room_leave(req.room_id, user)
    return res