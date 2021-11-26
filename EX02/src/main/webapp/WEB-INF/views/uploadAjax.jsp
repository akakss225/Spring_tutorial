<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>File Upload</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<button id="uploadBtn">Upload</button>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			// 파일의 확장자or 크기 사전처리
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
			// upload
			$("#uploadBtn").on("click", function(e){
				var formData = new FormData(); // form태그에 데이터를 저장하는 컨테이너 역할을 하는 객체
				var inputFile = $("input[name='uploadFile']"); // return 값이 배열임.
				var files = inputFile[0].files; // multiple 데이터 이므로, 배열
				
				for(var i = 0; i < files.length; i++){
					// check 구문 추가 >> 확장자 체크
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					// formData에 파일 추가
					formData.append("uploadFile", files[i]);
				}
				$.ajax({
					url : "/uploadAjaxAction",
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					success : function(result){
						alert("Uploaded");
					}
				}); // ajax문법. >> parameter는 객체로 받는다. 내부는 프로퍼티로 꽉~
			});
			
			
		});
	</script>
</body>
</html>