<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script>
	    let searchedFriendId = null; // 전역 변수로 친구 ID 저장
	    
	    function showFriendForm() {
	        const formArea = document.getElementById("friendForm");
	        formArea.style.display = "block";
	    }

	    function checkFriendEmail() {
	        const email = document.getElementById("friend_ID").value.trim();
	        const nameInput = document.getElementById("friend_name");
	        const requestBtn = document.getElementById("friendRequestBtn");

	        if (email === "") {
	            alert("이메일을 입력해주세요.");
	            return;
	        }

	        fetch("checkFriend?email=" + encodeURIComponent(email))
	            .then(response => response.json())
	            .then(data => {
	                if (data && data.id) {
	                    nameInput.value = data.name + " (ID: " + data.id + ")";
	                    searchedFriendId = data.id;
	                    requestBtn.disabled = false;
	                } else {
	                    nameInput.value = "";
	                    searchedFriendId = null;
	                    alert("❌ 해당 이메일의 사용자를 찾을 수 없습니다.");
	                    requestBtn.disabled = true;
	                }
	            })
	            .catch(error => {
	                console.error("에러 발생:", error);
	                nameInput.value = "";
	                searchedFriendId = null;
	                alert("서버 오류가 발생했습니다.");
	                requestBtn.disabled = true;
	            });
	    }

	    function sendFriendRequest() {
	        if (!searchedFriendId) {
	            alert("친구 정보가 없습니다.");
	            return;
	        }

	        fetch("addFriend", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify({
	                customer_id2: searchedFriendId
	            })
	        })
	        .then(res => res.json())
	        .then(data => {
	            if (data.success) {
	                alert("친구 신청이 전송되었습니다!");
	            } else {
	                alert("친구 신청 실패: " + data.message);
	            }
	        })
	        .catch(err => {
	            console.error("친구 신청 에러", err);
	            alert("친구 신청 중 오류가 발생했습니다.");
	        });
	    }
	    </script>

</head>
<body>
	<a href="main">🏠 홈으로가기</a><br><br>

	<h3>친구 리스트 출력 예정</h3>

	<input type="button" value="친구추가하기" onclick="showFriendForm()">
	<input type="button" value="친구삭제하기" onclick="location.href='#'"><br><br>

	<div id="friendForm" style="display: none; border: 1px solid #ccc; padding: 10px; width: 300px;">
	    <h4>친구 추가</h4>
	    친구의 이메일을 아래에 입력
	    <input type="text" id="friend_ID" name="friend_ID" placeholder="친구 이메일"><br><br>
	
	    <button type="button" onclick="checkFriendEmail()">이메일검색</button><br><br>
	
	    해당 친구의 이름<br>
	    <input type="text" id="friend_name" name="friend_name" placeholder="친구 ID" disabled><br><br>
	
	    <button type="button" id="friendRequestBtn" disabled onclick="sendFriendRequest()">친구신청하기</button>
	</div>

</body>
</html>
