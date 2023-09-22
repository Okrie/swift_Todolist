# swift_Todolist

---
### TodoList 
Swift를 사용하여 Ios 어플리케이션 제작    
3개의 다른 Database를 사용하여 TodoList 작성 및 타 유저와 일정 공유 기능을 구현    
    
<a href="https://drive.google.com/file/d/1L5U2Mx-rUpq8Bzkz0fgyD7y3cKfsVDlz/view?usp=drive_link">![cover](https://github.com/Okrie/swift_Todolist/blob/main/Swift%20TodoList.png)</a>    


##### 시연 영상

<a href="https://drive.google.com/file/d/1pcdLfJ_qR3wfjAbwK0xTfpxOyN_1RIJm/view?usp=sharing"><img src="https://github.com/Okrie/swift_Todolist/blob/main/Thumbnail.png" width="150" height="300"></a>

---

### 기능 설명
- 로그인한 '유저'가 공유 유무 판별하여 공유 일정 리스트에 해당 유저 이름으로 일정 공개 가능
- 일정 별로 공유 기능으로 공개하고 싶은 일정, 공개 하고 싶지 않은 일정 개별 설정하여 공개 가능
- 일정 완료 체크한 일정일 경우 본인 일정에서 최하단으로 정렬
- 일정 검색 기능으로 타이틀 기준으로 본인이 작성한 일정을 검색하여 관리 가능
- 공유 일정 리스트의 경우 보는 것은 가능하되, 수정은 불가능하게 막음


---
---
#### Database    
    : Sqlite3    
    : MySQL    
    : Firebase    
    
    
#### 기술 스택
<p align="left">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=git,github,vscode,firebase,mysql,sqlite,swift,java" />
  </a>
    <img src="https://cdn.icon-icons.com/icons2/3053/PNG/256/xcode_helper_macos_bigsur_icon_189446.png" height="53">
    <img src="https://cdn.icon-icons.com/icons2/2415/PNG/512/tomcat_original_wordmark_logo_icon_146324.png" height="53">
</p>


---
##### MVVM
- Model
- View
- ViewModel
      
  MVVM 패턴을 사용하여 각 기능들 기준으로 코드 분리하여 작성    
  Module : 공통적으로 사용하는 기능들을 재사용하기 위해 분리 작성    
  Model : 각 DB의 모델별로 추후 수정, 추가 및 관리에 있어 용이하기 위해 분리 작성    
  ViewModel : Model에서 분리해둔 각 DB를 사용하기 위해 DB명-기능으로 분리 작성    
  View : View를 타 컨트롤러와 혼동이 오지 않게 각 기능별로 View를 분리 작성    
