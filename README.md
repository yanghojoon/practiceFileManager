# practiceFileManager

야곰아카데미 iOS 파일 시스템 관련 활동학습

fileManager 학습을 위해 `Application Support`, `Documents`, `tmp`에 파일을 생성

<br>

### ⌨️ 알아두면 좋을 단축키 
- `cmd + shift + .` → 숨김 파일 보기
- `cmd + shift + g` → 폴더 찾기
- 폴더 생성 → `touch 파일명.확장자` / `echo “내용" > 파일명.확장자명`

### 🗂 파일 위치 
#### `Application Support`

라이브러리는 일단 숨김 파일로 되어 있기 때문에 사용자로 들어가서 `cmd + shift + .`를 해줘야 한다. 

<img width="653" alt="라이브러리 " src="https://user-images.githubusercontent.com/90880660/148767901-748bf74b-59cc-402d-bd5c-62a2ead99c88.png">
<img width="435" alt="ApplicationSupport 파일" src="https://user-images.githubusercontent.com/90880660/148768150-85ef4dad-5b33-4742-b827-4b96c290c243.png">

#### `document`
<img width="722" alt="스크린샷 2022-01-10 오후 8 52 32" src="https://user-images.githubusercontent.com/90880660/148768408-54eadefe-1993-4777-87aa-8d760753081d.png">

#### `tmp`

`tmp`는 Application Support와는 다르게 시스템에 위치해있다. 이는 `NSTemporaryDirectory()`와 동일하다. 

<img width="639" alt="tmp 위치 " src="https://user-images.githubusercontent.com/90880660/148768529-c860c1bb-c932-4cd9-970b-d6905ec71db8.png">

<br>

### 📦 사용한 메서드 정리 
#### 디렉토리의 주소를 찾는 경우
- [`urls(for: in:)`](https://developer.apple.com/documentation/foundation/filemanager/1407726-urls) : FileManager의 인스턴스 메서드 
  - directory: 찾을 path directory를 작성한다. 다양한 [SearchPathDirectory](https://developer.apple.com/documentation/foundation/filemanager/searchpathdirectory)를 가지고 있다.
  - domainMask: 찾을 file system의 도메인을 작성한다. 
    - userDomainMask: 사용자의 홈 디렉토리
    - localDomainMask: 기기에서 모든 사람이 item을 설치할 수 있는 곳
    - networkDomainMask: 네트워크에서 item을 설치할 수 있는 곳
    - systemDomainMask: 애플에서 제공하는 시스템 파일을 위한 디렉토리
    - allDomainMask: 모든 도메인
- [`FileManager.default`](https://developer.apple.com/documentation/foundation/filemanager/1409234-default): 싱글톤처럼 전역에서 사용할 수 있는 Filemanager 객체

#### 새로운 SubDirectory를 생성하는 경우 
- [`appendingPathComponent(_:)`](https://developer.apple.com/documentation/foundation/url/1780239-appendingpathcomponent) : 주어진 경로의 구성요소(URL)에 path component를 추가한 후 URL을 반환함
  - pathComponent: 추가할 path 구성 요소
- [`createDirectory(at:withIntermediateDirectories:attributes:)`](https://developer.apple.com/documentation/foundation/filemanager/1415371-createdirectory) : 주어진 attribute에 따라 디렉토리를 생성하는 메서드
  - url: 생성할 디렉토리를 지정해줌, 이는 반드시 nil이 되면 안됨. 
  - createdIntermediates: true면 url에 디렉토리를 만드는 과정 중에 존재하지 않는 부모 디렉토리를 생성함. false라면 중간 상위 디렉토리가 존재하지 않는 경우 메소드가 실패함. 
  - attributes: 새로운 디렉토리의 파일 속성(소유자 및 그룹 번호, 파일 권한, 수정일 등)을 정해준다. nil로 해주면 umask(2) macOS Developer Tools Manual Page에 따라 정해진다. 
  
#### 파일에 새로운 내용 작성 
- [`write(to:atomically:encoding:)`](https://developer.apple.com/documentation/foundation/nsstring/1417341-write) : 받은 URL에 지정한 encoding 방법을 통해 콘텐츠를 작성함.
  - url: 작성할 컨텐츠를 받을 주소로 file URLs만 지원한다.
  - useAuxiliaryFile: true면 auxiliary file에 기록하고 auxiliary file의 이름이 url로 바뀜. false면 url에 직접 기록을 하게 됨. true를 주면 url이 존재하는 경우 작성하는 동안 시스템이 충돌하게 되더라도 기록이 손상되지 않는 것을 보장.
  - enc: 출력에 사용할 인코딩 방법을 정함
  
#### 파일을 읽기
- [`contents(atPath:)`](https://developer.apple.com/documentation/foundation/filemanager/1407347-contents) : 지정한 path의 파일 컨텐츠를 반환해줌. FileManager의 인스턴스 메서드

#### 파일을 삭제 
- [`removeItem(at:)`](https://developer.apple.com/documentation/foundation/filemanager/1413590-removeitem) : 지정한 URL의 파일 혹은 디렉토리를 삭제. FileManager의 인스턴스 메서드
