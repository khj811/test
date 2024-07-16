<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, java.io.*, redis.clients.jedis.*" %>
<%@ page import="redis.clients.jedis.exceptions.JedisConnectionException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Categories</title>
    <style>
        body {
            height: 200vh;                                                                                                                   
            background-size: cover;                                                                                                          
            background-position: center;                                                                                                     
            background-image:                                                                                                                
            radial-gradient(circle at 50% 35%, #ffffff 0%, #e1f5fe 40%, #81d4fa 70%, #b3e5fc 100%),                                      
            radial-gradient(circle at 10% 10%, #ffffff 0%, #e0f2f1 50%, #b2dfdb 100%),                                                   
            radial-gradient(circle at 90% 10%, #ffffff 0%, #e1f5fe 30%, #81d4fa 80%, #29b6f6 100%);                                      
            background-blend-mode: normal;  
        }

        h1 {
            margin-top: 0px;
   
            background-color: #81d4fa;
            color: #fff;
            padding: 20px 0;
            text-align: center;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 2px 4px #81d4fa;
        }
        ul {
            list-style-type: none;
            padding: 0;
            margin: 50px auto;
            width: 80%;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 125px;
        }
        div.category {
            margin-bottom: 20px;
            margin-left: 20px;
            width: 20%; /* 5개씩 배치하고 싶은 경우에는 100% / 5 = 20% */
            display: inline-block;
            vertical-align: top; /* 상단 정렬 */
        }
        li a {
            text-decoration: none;
            color: #333;
            display: block;
            padding: 30px;
            background-color: #fff;
            border-radius: 20px;
            transition: background-color 0.3s ease;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            font-size: 20px;
            text-align: center;
        }
        li a:hover {
            background-color: #f0f0f0;
        }
        .category-info {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        }
        .category-info h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .category-info p {
            color: #666;
            line-height: 1.6;
        }
        .category-img {
            display: block;
            margin: 20px auto;
            width: 700px;
            height: 500px;
            border-radius: 10px;
        }
        .category-text {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .user-info {
            position: absolute;
            top: 10px;
            right: 20px;
            color: #333;
            background-color: #fff;
            padding: 10px 30px;
            border-radius: 20px;
            box-shadow: 0 2px 4px #333;
            z-index: 1001;
            margin-top: 10px;
        }
        .button-container {
            display: flex;
            justify-content: center;
            align-items: center; /* 버튼을 세로 방향으로도 가운데 정렬하고 싶으면 추가 */
        }

        .reserve-button {
            padding: 10px 50px;
            background-color: #ff783d;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            width: 200px;
        }
        
        .reserve-button:hover {
            background-color: #ff783d;
        }
    </style>
</head>
<body>
    <% 
        String RsessionId = request.getRequestedSessionId();
        String compareSessionId = session.getId();
        String sessionId = request.getParameter("sessionId");
        String userId = request.getParameter("userId");

        Jedis jedis = new Jedis("redis-test.3r7xgx.ng.0001.apn2.cache.amazonaws.com", 6379); // Redis 서버 주소와 포트
        String redisSessionId = null;

        if (userId != null && !userId.equals("null")) {
            // Redis에서 sessionId 가져오기
            redisSessionId = jedis.get(userId);
        }
        if (userId == null || userId.equals("null")) {
            %>
            out.println("null");
            <% 
        } else {
            if (!userId.equals("null") && redisSessionId != null) {
            %>
            <div class="user-info"> <%= userId %>의 여행지는 어디인가요?? <a href="https://www.withus.site/">Logout</a></div>

        <% 
        }else {
            %>
            out.println("mismatch");

            <% 
            }
        } 
    %>

    
    <h1>Travel Categories</h1>
    <ul>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=중국&userId=<%= userId %>">중국</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=일본&userId=<%= userId %>">일본</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=튀르키예&userId=<%= userId %>">튀르키예</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=영국&userId=<%= userId %>">영국</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=괌&userId=<%= userId %>">괌</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=태국&userId=<%= userId %>">태국</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=베트남&userId=<%= userId %>">베트남</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=스위스&userId=<%= userId %>">스위스</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=이탈리아&userId=<%= userId %>">이탈리아</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=사이판&userId=<%= userId %>">사이판</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=인도네시아&userId=<%= userId %>">인도네시아</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=싱가포르&userId=<%= userId %>">싱가포르</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=프랑스&userId=<%= userId %>">프랑스</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=독일&userId=<%= userId %>">독일</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=호주&userId=<%= userId %>">호주</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=몰디브&userId=<%= userId %>">몰디브</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=대만&userId=<%= userId %>">대만</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=체코&userId=<%= userId %>">체코</a></li></div>
        <div class="category" style="background-color: #ADD8E6;"><li><a href="https://www.withus.site/home/index.jsp?category=북유럽&userId=<%= userId %>">북유럽</a></li></div>
        <div class="category" style="background-color: #FFB6C1;"><li><a href="https://www.withus.site/home/index.jsp?category=미국캐나다&userId=<%= userId %>">미국캐나다</a></li></div>
    </ul>

    <%-- Check if category parameter is present in URL --%>
    <% String category = request.getParameter("category"); %>
    <% if(category != null && !category.isEmpty()) { %>
        <%-- Display detailed information based on the selected category --%>
        <div class="category-info">
        <div class="category-text">
            <h2><%= category %></h2>
            <%-- Switch case to display different information based on category --%>
            <% switch(category) {
                case "중국": %>
                    <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/China.png" alt="중국"></p>

                    <p>
                        <h3>북경/천진 3일</h3> <br>
                        <h3>#핵심관광 #만리장성 #천안문 #초특가필살기</h3><br>
                        
                        합리적인 가격으로 북경을 관광 하는 상품으로, 대표적인 필수관광지를 포함해 알찬 구성으로 이루어진 일정을 만나보세요.<br>
                        <h3> 299,000원 ~ </h3>
                    </p>
                    <div class="button-container">
                        <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                    </div>   
                    <script>
                        function showReservationMessage() {
                            alert(' 예약완료');
                        }
                    </script>    

                    <% break;
                case "일본": %>
                    <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/japan.png" alt="일본">

                    <p>
                        <h3>오사카/규슈 4일</h3> <br>
                        <h3>#관서기행 #훼리타고벚꽃구경</h3><br>
                        
                        오사카 대표관광지를 관광하고 오사카 중심에 위치한 호텔 숙박으로 저녁시간까지 알차게 보낼 수 있습니다.<br>
                        <h3> 299,000원 ~ </h3>
                    </p>
                    <div class="button-container">
                        <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                    </div>                         
                    <script>
                        function showReservationMessage() {
                            alert('예약완료');
                        }
                    </script>
                        
                    <% break;
                    case "태국": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Tai.png" alt="태국"></p>

                        <p>
                            <h3>방콕/파타야 5일</h3> <br>
                            <h3>#방콕의재발견 #5성호텔 #타이마사지</h3><br>
                            
                            시내 중심 5성호텔+핫플레이스+이색체험으로, '새로운 방콕'을 발견하고 싶은 분께 추천드립니다.<br>
                            <h3> 529,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "베트남": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Vietnam.png" alt="베트남"></p>

                        <p>
                            <h3>다낭/호이안 4~6일</h3> <br>
                            <h3>#호이안야경투어 #5성호텔 #5대특식</h3><br>
                            
                            월드체인 5성급 호텔 숙박과 다낭 여행에서 꼭 방문해야 할 명소와 다양한 특식이 포함되어 있습니다.<br>
                            <h3> 519,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "인도네시아": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Indonesia.png" alt="인도네시아"></p>

                        <p>
                            <h3>발리 5~7일</h3> <br>
                            <h3>#짐바란씨푸드 #울루와뚜지역 #르네상스 #노쇼핑 #베네핏</h3><br>
                            
                            아름다운 선셋과 씨푸드로 유명한 짐바란/울루와뚜 지역의 인기 호텔로 구성된 상품입니다.<br>
                            <h3> 1,589,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "싱가포르": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Singapore.png" alt="싱가포르"></p>

                        <p>
                            <h3>싱가포르 5일</h3> <br>
                            <h3>#베스트셀러 #전일관광 #완전일주 #NO쇼핑 #NO팁</h3><br>
                            
                            전 일정 싱가포르 숙박으로 구석구석 제대로 싱가포르를 즐길 수 있는 상품입니다.<br>
                            <h3> 1,403,400원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "몰디브": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Maldives.png" alt="몰디브"></p>

                        <p>
                            <h3>몰디브 7일</h3> <br>
                            <h3>#마디푸시 프라이빗 아일랜드 리조트 #라군 추천 신규 럭셔리 리조트 #전 객실 개인</h3><br>
                            
                            풀을 보유한 총 80채의 프라이빗 아일랜드 #플로팅 조식, 익스커션, 스파 등 다양한 포함 사항<br>
                            <h3> 4,860,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "대만": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Taiwan.png" alt="대만"></p>

                        <p>
                            <h3>대만 3~4일</h3> <br>
                            <h3>#101타워 #영화속명소 #천등날리기</h3><br>
                            
                            영화 속 명소가 포함되어 대만의 감성을 느낄 수 있는 꾸준한 인기의 상품입니다.<br>
                            <h3> 848,100원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "튀르키예": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Turkiye.png" alt="튀르키예"></p>

                        <p>
                            <h3>튀르키예(터키) 일주 9~10일</h3> <br>
                            <h3>#프리미엄 #열기구투어 #단독동굴호텔</h3><br>
                            
                            국내선 항공 3회 탑승으로 편안한 장거리이동, 카파도키아 단독 동굴호텔이 포함되어 있습니다.<br>
                            <h3> 5,501,000원~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "영국": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/United+Kingdom.jpeg" alt="영국"></p>

                        <p>
                            <h3>영국 일주 10일</h3> <br>
                            <h3>정통일주 #잉글랜드/스코틀랜드/북아일랜드/웨일즈</h3><br>
                            
                            다양한 자연과 문화, 예술로 가득한 잉글랜드, 스코틀랜드, 아일랜드를 모두 만나보는 정통 영국 일주 여행입니다.<br>
                            <h3> 4,790,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "스위스": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Swiss.jpeg" alt="스위스"></p>

                        <p>
                            <h3>스위스 일주 8일</h3> <br>
                            <h3>#베스트셀러 #알프스여행 </h3><br>
                            
                            알프스를 깊이있고 여유롭게 즐기는 스위스 일주 여행 시내호텔 1박 이상 숙박, 알프스의 명산을 방문하며 진정한 힐링을 즐기는 여행<br>
                            <h3> 8,790,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "이탈리아": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Italia.jpeg" alt="이탈리아"></p>

                        <p>
                            <h3>이탈리아 일주 8/9일</h3> <br>
                            <h3>#여행의 품격 #힐링 #여유롭고싶다</h3><br>
                            
                            여유롭고 깊이있는 일정으로 유네스코 가득한 이탈리아를 관광하는 쉼표in유럽 상품입니다.<br>
                            <h3> 5,599,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "프랑스": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/France.jpeg" alt="프랑스"></p>

                        <p>
                            <h3>프랑스 일주 7~9일</h3> <br>
                            <h3>#가성비 여행 #초특가필살기</h3><br>
                            
                            낭만이 가득한 파리여행, 프랑스를 찾는 관광객이 꼭 찾는 명소 '몽생미쉘'을 방문하는 여행입니다.<br>
                            <h3> 3,929,000원~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>  id="reserveButton" class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                            
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "독일": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Germany.jpeg" alt="독일"></p>

                        <p>
                            <h3>독일 완전일주 8~10일</h3> <br>
                            <h3>#핵심관광 #초특가필살기</h3><br>
                            
                            독일의 함부르크에서 베를린을 지나 뮌헨까지! 매력적인 나라 독일을 깊이있게 여행하는 합리적인 가격의 상품입니다.<br>
                            <h3> 3,679,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "체코": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Cesko.png" alt="체코"></p>

                        <p>
                            <h3>체코 자유여행 9일</h3> <br>
                            <h3>#프라하 출도착 #에어텔 #항공+호텔</h3><br>
                            
                            낭만과 품격이 가득한 프라하 출도착 자유여행 항공권 + 호텔 1박이 포함되어있는 프라하 자유여행입니다.<br>
                            <h3> 2,899,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "괌": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Guam.jpeg" alt="괌"></p>

                        <p>
                            <h3>괌 4~6일</h3> <br>
                            <h3>#에어텔 #항공+호텔 #괌 공항 왕복셔틀</h3><br>
                            
                            항공+호텔+왕복공항셔틀+여행자보험이 포함된 괌 자유여행 상품입니다<br>
                            <h3> 689,000원~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "사이판": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Saipan.jpeg" alt="사이판"></p>

                        <p>
                            <h3>사이판 자유여행 4~5일</h3> <br>
                            <h3>#PIC #워터파크천국 #키즈클럽 #사이판플렉스</h3><br>
                            
                            [왕복항공권+호텔+현지공항미팅/샌딩+여행자보험]이 포함된 사이판 PIC 자유여행 상품입니다.<br>
                            <h3> 704,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "호주": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/sydney.png" alt="호주"></p>

                        <p>
                            <h3>호주 비비드시드니 10박 11일 </h3> <br>
                            <h3>#시드니 #비비드시드니 #디너크루즈</h3><br>
                            
                            비비드 시드니 축제기간 동안 시드니를 누비는 하나투어 비비드 크루즈에 탑승하여 맛있는 디너를 즐길 수 있는 상품입니다.<br>
                            <h3> 975,000원 ~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "미국캐나다": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Canada.png" alt="미국/캐나다"></p>

                        <p>
                            <h3>미동부/캐나다 9~10일</h3> <br>
                            <h3>#가성비 #빠짐없는 핵심일정</h3><br>
                            
                            자유의 여신상 크루즈, 원월드 전망대, 나이아가라 크루즈, 퀘벡 관광을 포함하였습니다.<br>
                            <h3> 3,999,000원~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                    case "북유럽": %>
                        <img class="category-img" src="https://trip-bucket-1.s3.ap-northeast-2.amazonaws.com/trip-folder/Canada.png" alt="북유럽"></p>

                        <p>
                            <h3>미동부/캐나다 9~10일</h3> <br>
                            <h3>#가성비 #빠짐없는 핵심일정</h3><br>
                            
                            자유의 여신상 크루즈, 원월드 전망대, 나이아가라 크루즈, 퀘벡 관광을 포함하였습니다.<br>
                            <h3> 3,999,000원~ </h3>
                        </p>
                        <div class="button-container">
                            <button class="reserve-button" onclick="showReservationMessage()">예약하기</button>
                        </div>                             
                        <script>
                            function showReservationMessage() {
                                alert('예약완료');
                            }
                        </script>
                    <% break;
                // Add more cases for other categories as needed
                default: %>    
                    <p>No information available for this category.</p>
                    <% break;
            } %>
        </div>
        </div>         
    <% } %>           
</body>                                                                
</html>
