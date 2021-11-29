<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.uploadResult {
			width : 100%;
			background-color : gray;
		}
		
		.uploadResult ul {
			display : flex;
			flex-flow : row;
			justify-content : center;
			align-items : center;
		}
		
		.uploadResult ul li {
			list-style : none;
			padding : 10px;
		}
		
		.uploadResult ul li img {
			width : 20px;
		}
		.bigPictureWrapper {
			position : absolute;
			display : none;
			justify-content : center;
			align-items : center;
			top : 0%;
			width : 100%;
			height : 100%;
			bacground-color : gray;
			z-index : 100;
		}
		.bigPicture {
			position : relative;
			display : flex;
			justify-content : center;
			align-items : center;
		}
		.bigPicture img{
			width : 600px;
		}
	</style>
</head>
<body>
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		
		</div>
	</div>
	<h1>File Upload</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>
	<button id="uploadBtn">Upload</button>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		// 썸네일 클릭시 원본사진 보여주는 함수
		// ready 밖에 입력. 나중에 a태그에서 직접 호출하는 방식으로 하기 위해서.
		function showImage(fileCallPath){
			$(".bigPictureWrapper").css("display", "flex").show();
			
			$(".bigPicture").html("<img src='/display?fileName="+ encode(fileCallPath) +"'>").animate({width : '100%', heigth : '100%'}, 1000);
			
		}
		
		
		
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
			
			// 원본사진이 출력된 이후, 다시 종료하는 함수.
			$(".bigPictureWrapper").on("click", function(e){
				$(".bigPicture").animate({width : '0%', heigth : '0%'}, 1000);
				setTimeOut(() => {
					$(this).hide();
				}, 1000);
			});
			
			
			// 업로드한 파일 리스트를 보여주는 코드
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr){
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					if(!obj.image){
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
						
						str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" +
								"<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" + 
								"<span data-file='" + fileCallPath + "' data-type='file'> x </span>" + 
								"</div></li>";
					}
					else{
						// str += "<li>" + obj.fileName + "</li>";
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						var originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
						
						originPath = originPath.replace(new RegExp(/\\/g), "/");

						str += "<li><a href=\"javascript:showImage('" + originPath + "')\">" +
								"<img src='display?fileName=" + fileCallPath + "'></a>" + 
								"<span data-file='"+ fileCallPath +"' file-type='image'> x </span></li>";
					}
				});
				uploadResult.append(str);
			}
			
			
			
			// 파일 업로드 후, 초기화해주는데 필요한 clone
			var cloneObj = $(".uploadDiv").clone();
			
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
					dataType : 'json',
					success : function(result){
						alert("Uploaded");
						showUploadedFile(result);
						$(".uploadDiv").html(cloneObj.html());
					}
				}); // ajax문법. >> parameter는 객체로 받는다. 내부는 프로퍼티로 꽉~
			});
			
			$(".uploadResult").on("click", "span", function(e){
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				console.log(targetFile);
				
				$.ajax({
					url : '/deleteFile',
					data : {fileName : targetFile, type : type},
					dataType : 'text',
					type : 'POST',
					success : function(result){
						alert(result);
					}
				});
			});
		});
	</script>
</body>
</html>